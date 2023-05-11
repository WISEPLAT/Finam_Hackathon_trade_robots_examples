using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Threading;
using System.Windows;
using System.Windows.Markup;

namespace OrderBookScreener
{
    public partial class App : Application
    {
        public App()
        {
            // Устанавливаем культуру
            var culture = GetCulture();
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;
            FrameworkElement.LanguageProperty.OverrideMetadata(
                typeof(FrameworkElement), new FrameworkPropertyMetadata(XmlLanguage.GetLanguage(culture.IetfLanguageTag)));

            // Поддержка кодировки 1251
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);

            // Перехват неотловленных ошибок
            this.DispatcherUnhandledException += App_DispatcherUnhandledException;
        }

        private void App_DispatcherUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            Debug.WriteLine(e.Exception);
            MessageBox.Show(e.Exception.ToString());
        }

        private static CultureInfo GetCulture()
        {
            return new("ru-RU")
            {
                DateTimeFormat =
                {
                    TimeSeparator = ":",
                    DateSeparator = "/"
                },
                NumberFormat =
                {
                    NumberDecimalSeparator = ".",
                    NumberGroupSeparator = " ",
                    PercentDecimalSeparator = ".",
                    CurrencyDecimalSeparator = "."
                }
            };
        }
    }
}
