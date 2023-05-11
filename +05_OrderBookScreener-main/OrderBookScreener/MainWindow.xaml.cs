using OrderBookScreener.Connectors;
using System;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Input;
using System.Windows.Threading;

namespace OrderBookScreener
{
    public partial class MainWindow : Window
    {
        private const string FILE_CONFIG = "config.txt";
        private readonly Config? _config;
        private readonly IConnector? _connector;
        private readonly MainVM _model;
        private DateTime _lastRefreshGrid;

        public MainWindow()
        {
            InitializeComponent();

            _model = (MainVM)DataContext;
            _model.FiltersBoard.Add(new MainVM.FilterBoard { Name = "Акции", Board = "TQBR", IsChecked = true });
            _model.FiltersBoard.Add(new MainVM.FilterBoard { Name = "Фьючерсы", Board = "FUT" });
            _model.FiltersBoard.Add(new MainVM.FilterBoard { Name = "Валюты", Board = "CETS" });
            _model.ViewOrders.View.CollectionChanged += OnOrderViewCollectionChanged;

            _config = TryReadConfig(FILE_CONFIG, out var error);
            if (error != null || _config == null)
            {
                AddLog($"Ошибка чтении настроек {FILE_CONFIG}\r\n{error}");
                return;
            }

            _connector = new FinamConnector(_config);
            _connector.Message += OnConnector_Message;
            _connector.Error += OnConnector_Error;
            _connector.UpdateMoneys += OnConnector_UpdateMoneys;
            _connector.UpdatePositions += OnConnector_UpdatePositions;
            _connector.UpdateOrderBook += OnConnector_UpdateOrderBook;
            _connector.UpdateFinInfo += OnConnector_UpdateFinInfo;
            _connector.UpdateOrder += OnConnector_UpdateOrder;
            _connector.Connect();
        }

        private void OnConnector_Message(string msg)
        {
            AddLog(msg);
        }

        private void OnConnector_Error(Exception ex)
        {
            AddLog(ex.ToString());
        }
        
        private void OnConnector_UpdateMoneys()
        {
            Dispatcher.Invoke(() =>
            {
                _model.Moneys.Clear();
                foreach (var item in _connector!.Moneys.Values)
                {
                    _model.Moneys.Add(item);
                }
            });
        }

        private void OnConnector_UpdatePositions()
        {
            Dispatcher.Invoke(() =>
            {
                _model.Positions.Clear();
                foreach (var item in _connector!.Positions.Values)
                {
                    _model.Positions.Add(item);
                }
            });
        }

        private void OnConnector_UpdateOrderBook(OrderBook obj)
        {
            var key = $"{obj.SecBoard}:{obj.SecCode}";
            var orderBook = _model.OrderBooksDic.GetOrAdd(key, x =>
            {
                var orderBook = new OrderBookVM(obj.SecBoard, obj.SecCode);
                Dispatcher.Invoke(() => _model.OrderBooks.Add(orderBook));
                return orderBook;
            });

            Dispatcher.Invoke(() =>
            {
                orderBook.Update(obj);
                
                // Обновляем таблицу по выбранной сортировке
                if (DateTime.Now > _lastRefreshGrid.AddMilliseconds(5000))
                {
                    // Смотрим какой элемент сейчас в фокусе
                    var focusedElement = Keyboard.FocusedElement as DependencyObject;
                    var focusedDataGrid = Utils.FindParentOfType<DataGrid>(focusedElement);
                    var needFocused = focusedDataGrid == PART_OrderBooks;

                    // Обновляем таблицу по выбранной сортировке
                    _model?.ViewOrderBooks?.View?.Refresh();
                    _lastRefreshGrid = DateTime.Now;

                    // После Refresh нужно возвратить фокус на строку
                    if (needFocused)
                    {
                        PART_OrderBooks.Focus();
                        Keyboard.Focus(PART_OrderBooks);

                        if (PART_OrderBooks.SelectedItems != null && PART_OrderBooks.SelectedItems.Count > 0)
                        {
                            PART_OrderBooks.UpdateLayout();
                            var row = PART_OrderBooks.ItemContainerGenerator.ContainerFromItem(PART_OrderBooks.SelectedItem) as DataGridRow;
                            if (row != null && PART_OrderBooks?.CurrentCell != null)
                            {
                                var columnIndex = PART_OrderBooks.Columns.IndexOf(PART_OrderBooks.CurrentCell.Column);
                                var presenter = Utils.FindVisualChild<DataGridCellsPresenter>(row);
                                var cell = presenter?.ItemContainerGenerator?.ContainerFromIndex(columnIndex) as DataGridCell;
                                cell?.Focus();
                            }
                        }
                    }
                }
            });
        }

        private void OnConnector_UpdateOrder(Order obj)
        {
            Dispatcher.Invoke(() =>
            {
                var order = _model.OrdersDic.GetOrAdd(obj.Id, x =>
                {
                    var order = new OrderVM(obj.Id);
                    _model.Orders.Add(order);
                    return order;
                });
                order.Update(obj);
            });
        }

        private void OnConnector_UpdateFinInfo(FinInfo obj)
        {
            if (_model.OrderBooksDic.TryGetValue($"{obj.Board}:{obj.Symbol}", out var orderBook))
            {
                orderBook.Valtoday = obj.Valtoday;
                orderBook.Voltoday = obj.Voltoday;
            }
        }

        public void AddLog(string message)
        {
            PART_Log.Dispatcher.Invoke(() =>
            {
                if (PART_Log.Text.Length > 0)
                    PART_Log.Text += Environment.NewLine;
                PART_Log.Text += $"{DateTime.Now:HH:mm:ss} {message}";
                PART_LogScroll.ScrollToBottom();
            });
        }

        private void UpdateFilter(object sender, RoutedEventArgs e)
        {
            _model?.ViewOrderBooks?.View?.Refresh();
        }

        private static Config? TryReadConfig(string file, out Exception? error)
        {
            try
            {
                error = null;
                if (!File.Exists(file))
                {
                    Utils.WriteJson(file, new Config()
                    {
                        Token = "CAEQz8UBGhgtzWDtPhu+T78+8hFycU4pY7dVq6ekZWU=",
                        ClientId = "31521R51TB",
                    });
                }
                var res = Utils.ReadJson<Config>(file);
                return res ?? throw new Exception("Config is null");
            }
            catch (Exception ex)
            {
                error = ex;
                return null;
            }
        }

        private void OnSendOrder(object sender, RoutedEventArgs e)
        {
            try
            {
                if (_connector == null || _config?.ClientId == null)
                    return;
                if (sender != btnBuy && sender != btnSell)
                    return;

                var orderBook = _model.SelectedOrderBook;
                if (orderBook == null)
                {
                    AddLog("Не выбран инструмент");
                    return;
                }

                if (!double.TryParse(txtPrice.Text.Trim(), out var price))
                {
                    AddLog("Неверно введена цена");
                    return;
                }

                if (!int.TryParse(txtQuantity.Text.Trim(), out var quantity))
                {
                    AddLog("Неверно введено количество");
                    return;
                }

                var isBuy = sender == btnBuy;
                _connector.SendOrderAsync(_config.ClientId, orderBook.SecBoard, orderBook.SecCode, isBuy, quantity, price)
                    .ContinueWith(t =>
                    {
                        if (t.Exception != null)
                            AddLog($"Ошибка отправки заявки {orderBook.SecCode}: {t.Exception?.GetBaseException()?.Message}");
                        else
                            AddLog($"Отправлена заявка {orderBook.SecCode}");
                    });
            }
            catch (Exception ex)
            {
                AddLog($"Ошибка отпраки заявки: {ex.Message}");
            }
        }

        private void OnCancelOrder(object sender, RoutedEventArgs e)
        {
            try
            {
                if (_connector == null || _config?.ClientId == null)
                    return;

                var orderVM = (sender as ICommandSource)?.CommandParameter as OrderVM;
                if (orderVM == null) return;

                if (!_connector.Orders.TryGetValue(orderVM.Id, out var order))
                    return;

                _connector.CancelOrderAsync(order)
                    .ContinueWith(t =>
                    {
                        if (t.Exception != null)
                            AddLog($"Ошибка отмены заявки {orderVM.Id}: {t.Exception?.GetBaseException()?.Message}");
                        else
                            AddLog($"Заявка отменена id: {orderVM.Id}");
                    });
            }
            catch (Exception ex)
            {
                AddLog($"Ошибка отмены заявки: {ex.Message}");
            }
        }

        private void OnOrderBookRowClick(OrderBookRow obj)
        {
            txtPrice.Text = obj.Price.ToString();
        }

        private readonly Regex _regexNumbers = new("[^0-9.-]+", RegexOptions.Compiled);
        private void OnPreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            e.Handled = _regexNumbers.IsMatch(e.Text);
        }

        private void OnOrderViewCollectionChanged(object? sender, NotifyCollectionChangedEventArgs e)
        {
            if (e.Action == NotifyCollectionChangedAction.Move)
            {
                var lastOrder = PART_ListViewOrders.Items.OfType<OrderVM>().MaxBy(x => x.Date);
                PART_ListViewOrders.ScrollIntoView(lastOrder);
            }
        }
    }
}
