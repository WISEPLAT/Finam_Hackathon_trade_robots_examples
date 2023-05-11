namespace OrderBookScreener
{
    /// <summary>Информация по инструменту</summary>
    public class FinInfo
    {
        /// <summary>Режим торгов</summary>
        public string Board { get; set; }

        /// <summary>Код инструмента</summary>
        public string Symbol { get; set; }

        /// <summary>Объем совершенных сделок, рублей</summary>
        public double Valtoday { get; set; }

        /// <summary>Объем совершенных сделок, контрактов</summary>
        public double Voltoday { get; set; }
    }
}
