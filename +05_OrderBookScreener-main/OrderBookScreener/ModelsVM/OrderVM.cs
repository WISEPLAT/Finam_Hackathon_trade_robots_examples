using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace OrderBookScreener
{
    /// <summary>Заявка (визуальное представление)</summary>
    public class OrderVM : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        public string Id { get; set; }

        private DateTime? _date;
        public DateTime? Date
        {
            get { return _date; }
            set { SetProperty(ref _date, value); }
        }

        private string? _symbol;
        public string? Symbol
        {
            get { return _symbol; }
            set { SetProperty(ref _symbol, value); }
        }

        private OrderSide _side;
        public OrderSide Side
        {
            get { return _side; }
            set { SetProperty(ref _side, value); }
        }

        private OrderStatus _status;
        public OrderStatus Status
        {
            get { return _status; }
            set { SetProperty(ref _status, value); }
        }

        private double _price;
        public double Price
        {
            get { return _price; }
            set { SetProperty(ref _price, value); }
        }

        private double _quantity;
        public double Quantity
        {
            get { return _quantity; }
            set { SetProperty(ref _quantity, value); }
        }

        private double _restQuantity;
        public double RestQuantity
        {
            get { return _restQuantity; }
            set { SetProperty(ref _restQuantity, value); }
        }

        public OrderVM(string id)
        {
            Id = id;
        }

        public void Update(Order order)
        {
            Date = order.Date;
            Symbol = order.Symbol;
            Status = order.Status;
            Side = order.Side;
            Price = order.Price;
            Quantity = order.Quantity;
            RestQuantity = order.RestQuantity;
        }

        protected void SetProperty<T>(ref T field, T value, [CallerMemberName] string? name = null)
        {
            field = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }
    }
}
