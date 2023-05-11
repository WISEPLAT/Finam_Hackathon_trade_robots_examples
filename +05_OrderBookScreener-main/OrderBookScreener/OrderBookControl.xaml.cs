using System;
using System.Collections;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace OrderBookScreener
{
    public partial class OrderBookControl : UserControl
    {
        public event Action<OrderBookRow>? ItemClick;

        public IEnumerable ItemSource
        {
            get => (IEnumerable)GetValue(ItemSourceProperty);
            set => SetValue(ItemSourceProperty, value);
        }

        public static readonly DependencyProperty ItemSourceProperty =
            DependencyProperty.Register(nameof(ItemSource), typeof(IEnumerable), typeof(OrderBookControl),
                 new PropertyMetadata(new PropertyChangedCallback(OnItemsSourcePropertyChanged)));

        private static void OnItemsSourcePropertyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is OrderBookControl orderBookControl)
                orderBookControl.PART_Grid.ItemsSource = e.NewValue as IEnumerable;
        }

        public OrderBookControl()
        {
            InitializeComponent();

            ItemSource = new[] 
            {
                new OrderBookRow(true, 1, 1),
                new OrderBookRow(true, 2, 1),
                new OrderBookRow(true, 3, 1)
            };
        }

        private void OnClickCell(object sender, MouseButtonEventArgs e)
        {
            var cell = sender as DataGridCell;
            if (cell == null)
                return;

            var orderBook = cell.DataContext as OrderBookRow;
            if (orderBook == null)
                return;

            ItemClick?.Invoke(orderBook);
        }
    }
}
