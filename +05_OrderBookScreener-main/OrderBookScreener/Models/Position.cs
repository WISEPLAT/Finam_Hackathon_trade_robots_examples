namespace OrderBookScreener
{
    /// <summary>Позиция</summary>
    public class Position
    {
        /// <summary>Инструмент</summary>
        public string Symbol { get; set; }

        /// <summary>Рынок</summary>
        public string Market { get; set; }

        /// <summary>Текущая позиция</summary>
        public double Balance { get; set; }

        /// <summary>Прибыль/убыток</summary>
        public double Profit { get; set; }
    }
}
