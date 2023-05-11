using System.Collections.Concurrent;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows.Data;

namespace OrderBookScreener
{
    /// <summary>Модель главного окна</summary>
    public class MainVM : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        public ObservableCollection<Money> Moneys { get; } = new();
        public ObservableCollection<Position> Positions { get; } = new();
        
        public ConcurrentDictionary<string, OrderVM> OrdersDic { get; } = new();
        public ObservableCollection<OrderVM> Orders { get; } = new();
        public CollectionViewSource ViewOrders { get; } = new();

        public ConcurrentDictionary<string, OrderBookVM> OrderBooksDic { get; } = new();
        public ObservableCollection<OrderBookVM> OrderBooks { get; } = new();
        public CollectionViewSource ViewOrderBooks { get; } = new();


        private OrderBookVM? _selectedOrderBook;
        public OrderBookVM? SelectedOrderBook
        {
            get { return _selectedOrderBook; }
            set { SetProperty(ref _selectedOrderBook, value); }
        }

        public ObservableCollection<FilterBoard> FiltersBoard { get; } = new();
        
        public string? _filterSecCode;
        public string? FilterSecCode
        {
            get { return _filterSecCode; }
            set { SetProperty(ref _filterSecCode, value); ViewOrderBooks.View.Refresh(); }
        }

        public MainVM()
        {
            ViewOrderBooks.Source = this.OrderBooks;
            ViewOrderBooks.SortDescriptions.Add(new SortDescription(nameof(OrderBookVM.BigQty), ListSortDirection.Descending));
            ViewOrderBooks.Filter += ViewOrderBooks_Filter;

            ViewOrders.Source = this.Orders;
            ViewOrders.SortDescriptions.Add(new SortDescription(nameof(OrderVM.Date), ListSortDirection.Ascending));
            ViewOrders.IsLiveSortingRequested = true;
        }

        private void ViewOrderBooks_Filter(object sender, FilterEventArgs e)
        {
            if (e.Item is OrderBookVM orderBook)
            {
                e.Accepted = false;
                if (FilterSecCode?.Length > 0 && !orderBook.SecCode.Contains(FilterSecCode, System.StringComparison.OrdinalIgnoreCase))
                    return;
                if (!(FiltersBoard.FirstOrDefault(x => x.Board == orderBook.SecBoard)?.IsChecked ?? false))
                    return;
                e.Accepted = true;
            }
        }

        protected void SetProperty<T>(ref T field, T value, [CallerMemberName] string? name = null)
        {
            field = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }

        public class FilterBoard
        {
            public string? Name { get; set; }
            public string? Board { get; set; }
            public bool IsChecked { get; set; }
        }
    }
}
