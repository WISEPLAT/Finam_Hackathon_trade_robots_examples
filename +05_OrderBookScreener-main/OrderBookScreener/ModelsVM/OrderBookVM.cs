using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;

namespace OrderBookScreener
{
    /// <summary>Стакан (визуальное представление)</summary>
    public class OrderBookVM : INotifyPropertyChanged
    {
        public const int MaxRows = 15;
        public event PropertyChangedEventHandler? PropertyChanged;
        public object Lock { get; } = new object();
        public string SecBoard { get; }
        public string SecCode { get; }
        public string Market { get; }
        public ObservableCollection<OrderBookRow> Rows { get; private set; } = new();

        private double? _bestBid;
        public double? BestBid
        {
            get { return _bestBid; }
            set { SetProperty(ref _bestBid, value); }
        }

        private double? _bestAsk;
        public double? BestAsk
        {
            get { return _bestAsk; }
            set { SetProperty(ref _bestAsk, value); }
        }

        private double? _spreadPrc;
        public double? SpreadPrc
        {
            get { return _spreadPrc; }
            set { SetProperty(ref _spreadPrc, value); }
        }

        private double? _bigQty;
        public double? BigQty
        {
            get { return _bigQty; }
            set { SetProperty(ref _bigQty, value); }
        }

        /// <summary>
        /// Объем совершенных сделок, рублей
        /// </summary>
        public double? Valtoday
        {
            get { return _valtoday; }
            set { SetProperty(ref _valtoday, value); }
        }
        private double? _valtoday;

        /// <summary>
        /// Объем совершенных сделок, контрактов
        /// </summary>
        public double? Voltoday
        {
            get { return _voltoday; }
            set { SetProperty(ref _voltoday, value); }
        }
        private double? _voltoday;

        public OrderBookVM(string secBoard, string secCode)
        {
            SecBoard = secBoard;
            SecCode = secCode;
            Market = GetMarket(secBoard);
        }

        public void Update(OrderBook orderBook)
        {
            lock(Lock)
            {
                Rows.Clear();
                foreach (var item in orderBook.Asks.OrderBy(x => x.Price).Take(MaxRows).OrderByDescending(x => x.Price))
                    Rows.Add(item);
                foreach (var item in orderBook.Bids.OrderByDescending(x => x.Price).Take(MaxRows))
                    Rows.Add(item);
                
                BestBid = orderBook.Bids.FirstOrDefault()?.Price;
                BestAsk = orderBook.Asks.FirstOrDefault()?.Price;
                SpreadPrc = BestBid == null || BestAsk == null || BestBid == 0 ? null : (BestAsk / BestBid * 100 - 100).Value.Round(2);

                if (Rows.Any())
                {
                    var avgQty = Rows.Select(x => x.Quantity).Average();
                    BigQty = Math.Round(Rows.Select(x => x.Quantity / avgQty).Max(), 2);
                }
                else
                {
                    BigQty = null;
                }
            }
        }

        public override string ToString() => SecCode;

        protected void SetProperty<T>(ref T field, T value, [CallerMemberName] string? name = null)
        {
            field = value;
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }

        private static string GetMarket(string board)
        {
            return board.ToUpper() switch
            {
                "TQBR" => "Акция",
                "FUT" => "Фьючерс",
                "CETS" => "Валюта",
                _ => string.Empty,
            };
        }
    }
}
