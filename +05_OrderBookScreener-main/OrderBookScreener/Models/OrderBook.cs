namespace OrderBookScreener
{
    /// <summary>Стакан</summary>
    public class OrderBook
    {
        /// <summary>Режим торгов</summary>
        public string SecBoard { get; set; }

        /// <summary>Инструмент</summary>
        public string SecCode { get; set; }

        /// <summary>Список заявок на покупку</summary>
        public OrderBookRow[] Bids { get; set; }

        /// <summary>Список заявок на продажу</summary>
        public OrderBookRow[] Asks { get; set; }
    }

    /// <summary>Строка стакана</summary>
    public class OrderBookRow
    {
        /// <summary>Покупка или продажа</summary>
        public bool IsBid { get; }

        /// <summary>Цена</summary>
        public double Price { get; }

        /// <summary>Количество</summary>
        public double Quantity { get; set; }

        /// <summary>Количество на покупку</summary>
        public double? QuantityBid { get; set; }

        /// <summary>Количество на продажу</summary>
        public double? QuantitySell { get; set; }

        public OrderBookRow(bool isBid, double price, double quantity)
        {
            IsBid = isBid;
            Price = price.Normalize();
            Quantity = quantity.Normalize();
            QuantityBid = IsBid ? Quantity : null;
            QuantitySell = IsBid ? null : Quantity;
        }

        public override string ToString() => $"{Price}: {Quantity}";
    }
}
