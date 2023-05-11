using System;

namespace OrderBookScreener
{
    /// <summary>Заявка</summary>
    public class Order
    {
        /// <summary>Номер</summary>
        public string Id { get; set; }

        /// <summary>Инструмент</summary>
        public string? Symbol { get; set; }

        /// <summary>Дата создания</summary>
        public DateTime Date { get; set; }

        /// <summary>Напраление (покупка/продажа)</summary>
        public OrderSide Side { get; set; }

        /// <summary>Статус</summary>
        public OrderStatus Status { get; set; }

        /// <summary>Цена</summary>
        public double Price { get; set; }

        /// <summary>Количество</summary>
        public double Quantity { get; set; }

        /// <summary>Оставшееся количество</summary>
        public double RestQuantity { get; set; }
    }

    /// <summary>Направление заявки</summary>
    public enum OrderSide
    {
        /// <summary>Покупка</summary>
        Buy,
        /// <summary>Продажа</summary>
        Sell
    }

    /// <summary>Статус заявки</summary>
    public enum OrderStatus
    {
        /// <summary>Неизвестно</summary>
        None,
        /// <summary>Активная</summary>
        Active,
        /// <summary>Отменена</summary>
        Cancelled,
        /// <summary>Выполнена</summary>
        Executed,
    }
}