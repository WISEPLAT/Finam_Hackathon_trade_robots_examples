using Finam.TradeApi.Proto.V1;
using FinamClient;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;

namespace OrderBookScreener.Connectors
{
    /// <summary>
    /// Коннектор к Finam Trade API
    /// </summary>
    public class FinamConnector : IConnector
    {
        private ConcurrentDictionary<string, Money> _moneys = new();
        public IDictionary<string, Money> Moneys => _moneys;

        private ConcurrentDictionary<string, Position> _positons = new();
        public IDictionary<string, Position> Positions => _positons;

        private ConcurrentDictionary<string, Order> _order = new();
        public IDictionary<string, Order> Orders => _order;

        public event Action? UpdateMoneys;
        public event Action? UpdatePositions;
        public event Action<Order>? UpdateOrder;
        public event Action<OrderBook>? UpdateOrderBook;
        public event Action<FinInfo>? UpdateFinInfo;
        public event Action<Exception>? Error;
        public event Action<string>? Message;

        private readonly FinamApi _client;
        private readonly Config _config;
        private readonly BlockingCollection<Event> _events = new();
        private Timer? _timerUpdateExtraData;
        private bool _isPortfolioAvailable;

        public FinamConnector(params object[] args)
        {
            _config = (Config)args[0];
            _client = new FinamApi(_config.Token!);
            _client.EventResponse += x => _events.Add(x);
            Task.Run(ProcessEvents);
        }

        public async Task Connect()
        {
            try
            {
                Message?.Invoke("Получаю данные по портфелю");
                try
                {
                    await UpdatePortfolioAsync().ConfigureAwait(false);
                    _isPortfolioAvailable = true;
                }
                catch (Exception ex)
                {
                    if (ex.ToString().Contains("PermissionDenied"))
                    {
                        _isPortfolioAvailable = false;
                        Message?.Invoke("Нет разрешения на получение портфеля, поэтому работаем без него.");
                    }
                    else if (ex.ToString().Contains("Unauthenticated"))
                    {
                        Message?.Invoke("Неверный токен.");
                        throw;
                    }
                    else
                    {
                        throw;
                    }
                }

                if (_isPortfolioAvailable)
                {
                    Message?.Invoke("Получаю заявки");
                    await UpdateOrdersAsync().ConfigureAwait(false);
                }

                Message?.Invoke("Подписываюсь на данные");
                await _client.SubscribeOrderTradeAsync(new[] { _config.ClientId }).ConfigureAwait(false);
                var securities = await _client.GetSecuritiesAsync().ConfigureAwait(false);
                var listTQBR = securities.Securities.Where(x => x.Board == "TQBR").ToList();
                var listFUT = securities.Securities.Where(x => x.Board == "FUT").ToList();
                var listCETS = securities.Securities.Where(x => x.Board == "CETS").ToList();
                var listAll = listTQBR.Union(listFUT).Union(listCETS).ToList();

                foreach (var item in listAll)
                {
                    await _client.SubscribeOrderBookAsync(item.Board, item.Code).ConfigureAwait(false);
                }

                _timerUpdateExtraData = new(x => Task.Run(UpdateExtraData), null, TimeSpan.FromSeconds(5), TimeSpan.FromMinutes(1));
                Message?.Invoke("Готов к работе");
            }
            catch (Exception ex)
            {
                Error?.Invoke(ex);
            }
        }

        public void Dispose()
        {
            _moneys.Clear();
            _positons.Clear();
            _order.Clear();
        }

        private async Task UpdatePortfolioAsync()
        {
            var portfolio = await _client.GetPortfolioAsync(_config.ClientId).ConfigureAwait(false);

            {
                _moneys.Clear();
                foreach (var item in portfolio.Currencies)
                {
                    var money = new Money
                    {
                        Currency = item.Name,
                        Balance = item.Balance.Normalize(),
                    };
                    _moneys[money.Currency] = money;
                }
                UpdateMoneys?.Invoke();
            }

            {
                _positons.Clear();
                foreach (var item in portfolio.Positions)
                {
                    var position = new Position
                    {
                        Symbol = item.SecurityCode,
                        Market = item.Market.ToString(),
                        Balance = item.Balance,
                        Profit = item.Profit.Normalize(),
                    };
                    _positons[position.Symbol] = position;
                }
                UpdatePositions?.Invoke();
            }
        }

        private async Task UpdateOrdersAsync()
        {
            var orders = await _client.GetOrdersAsync(_config!.ClientId!).ConfigureAwait(false);

            _order.Clear();
            foreach (var item in orders.Orders)
            {
                var order = new Order
                {
                    Id = item.TransactionId.ToString(),
                    Date = (item.CreatedAt ?? item.AcceptedAt)?.ToDateTime().ToLocalTime() ?? DateTime.Now,
                    Symbol = item.SecurityCode,
                    Status = ToOrderStatus(item.Status),
                    Side = ToOrderSide(item.BuySell),
                    Price = item.Price,
                    Quantity = item.Quantity,
                    RestQuantity = item.Balance,
                };
                _order[order.Id] = order;
                UpdateOrder?.Invoke(order);
            }
        }

        public async Task SendOrderAsync(string account, string board, string symbol, bool isBuy, double quantity, double price)
        {
            if (!_isPortfolioAvailable)
            {
                Message?.Invoke("Нет разрешения на работу с портфелем.");
                return;
            }

            await _client.NewOrderAsync(account, board, symbol, isBuy, (int)quantity, price)
            .ContinueWith(t =>
            {
                if (t.Exception != null)
                    throw t.Exception;
            });
        }

        public async Task CancelOrderAsync(Order order)
        {
            if (!_isPortfolioAvailable)
            {
                Message?.Invoke("Нет разрешения на работу с портфелем.");
                return;
            }

            await _client.CancelOrderAsync(_config!.ClientId!, int.Parse(order.Id))
            .ContinueWith(t =>
            {
                if (t.Exception != null)
                    throw t.Exception;
            });
        }

        private void ProcessEvents()
        {
            foreach (var ev in _events.GetConsumingEnumerable())
            {
                try
                {
                    if (ev.OrderBook != null)
                    {
                        var key = $"{ev.OrderBook.SecurityBoard}:{ev.OrderBook.SecurityCode}";
                        var orderBook = new OrderBook
                        {
                            SecBoard = ev.OrderBook.SecurityBoard,
                            SecCode = ev.OrderBook.SecurityCode,
                            Bids = ev.OrderBook.Bids.Select(x => new OrderBookRow(true, x.Price, x.Quantity)).ToArray(),
                            Asks = ev.OrderBook.Asks.Select(x => new OrderBookRow(false, x.Price, x.Quantity)).ToArray(),
                        };
                        UpdateOrderBook?.Invoke(orderBook);
                    }

                    if (ev.Order != null)
                    {
                        var order = new Order
                        {
                            Id = ev.Order.TransactionId.ToString(),
                            Date = (ev.Order.CreatedAt ?? ev.Order.AcceptedAt)?.ToDateTime().ToLocalTime() ?? DateTime.Now,
                            Symbol = ev.Order.SecurityCode,
                            Status = ToOrderStatus(ev.Order.Status),
                            Side = ToOrderSide(ev.Order.BuySell),
                            Price = ev.Order.Price,
                            Quantity = ev.Order.Quantity,
                            RestQuantity = ev.Order.Balance,
                        };

                        _order[order.Id] = order;
                        UpdateOrder?.Invoke(order);
                    }

                    if (ev.Trade != null)
                    {
                        Task.Run(async () =>
                        {
                            try
                            {
                                await UpdatePortfolioAsync().ConfigureAwait(false);
                            }
                            catch { }
                        });
                    }
                }
                catch (TaskCanceledException) { }
                catch (Exception ex)
                {
                    Error?.Invoke(ex);
                }
            }
        }

        private async Task UpdateExtraData()
        {
            try
            {
                var client = new HttpClient();
                var baseUrl = "https://iss.moex.com/iss/engines";
                var pameteres = "?iss.meta=off&iss.only=marketdata&marketdata.columns=BOARDID,SECID,VALTODAY,VOLTODAY";
                await UpdateByUrl($"{baseUrl}/stock/markets/shares/boards/TQBR/securities.xml{pameteres}");
                await UpdateByUrl($"{baseUrl}/currency/markets/selt/boards/CETS/securities.xml{pameteres}");
                await UpdateByUrl($"{baseUrl}/futures/markets/forts/boards/RFUD/securities.xml{pameteres}");

                async Task UpdateByUrl(string url)
                {
                    var res = await client.GetStringAsync(url).ConfigureAwait(false);

                    var xDoc = new XmlDocument();
                    xDoc.LoadXml(res);
                    var rows = xDoc.SelectNodes("//row");
                    if (rows == null)
                        return;
                    foreach (XmlElement row in rows)
                    {
                        var boardid = row.GetAttribute("BOARDID").Replace("RFUD", "FUT");
                        var secid = row.GetAttribute("SECID");
                        var valtoday = row.GetAttribute("VALTODAY");
                        var voltoday = row.GetAttribute("VOLTODAY");

                        if (!double.TryParse(valtoday, out var nValtoday))
                            continue;

                        if (!double.TryParse(voltoday, out var nVoltoday))
                            continue;

                        var finInfo = new FinInfo
                        {
                            Board = boardid,
                            Symbol = secid,
                            Valtoday = nValtoday,
                            Voltoday = nVoltoday,
                        };
                        UpdateFinInfo?.Invoke(finInfo);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
            }
        }

        private static OrderSide ToOrderSide(Finam.TradeApi.Proto.V1.BuySell side)
        {
            return side == BuySell.Buy ? OrderSide.Buy : OrderSide.Sell;
        }

        private static OrderStatus ToOrderStatus(Finam.TradeApi.Proto.V1.OrderStatus status)
        {
            return status switch
            {
                Finam.TradeApi.Proto.V1.OrderStatus.Unspecified => OrderStatus.None,
                Finam.TradeApi.Proto.V1.OrderStatus.None => OrderStatus.None,
                Finam.TradeApi.Proto.V1.OrderStatus.Active => OrderStatus.Active,
                Finam.TradeApi.Proto.V1.OrderStatus.Cancelled => OrderStatus.Cancelled,
                Finam.TradeApi.Proto.V1.OrderStatus.Matched => OrderStatus.Executed,
                _ => throw new NotImplementedException(),
            };
        }
    }
}
