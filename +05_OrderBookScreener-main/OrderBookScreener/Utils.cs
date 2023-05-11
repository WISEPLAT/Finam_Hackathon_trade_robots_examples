using System;
using System.IO;
using System.Text.Json;
using System.Windows;
using System.Windows.Media;

namespace OrderBookScreener
{
    public static class Utils
    {
        /// <summary>
        /// Записать объект в json файл
        /// </summary>
        public static void WriteJson<T>(string file, T obj)
        {
            using var fs = new FileStream(file, FileMode.OpenOrCreate);
            JsonSerializer.Serialize<T>(fs, obj, new JsonSerializerOptions() { WriteIndented = true });
        }

        /// <summary>
        /// Прочитать объект из json файла
        /// </summary>
        public static T? ReadJson<T>(string file)
        {
            using var fs = new FileStream(file, FileMode.OpenOrCreate);
            var res = JsonSerializer.Deserialize<T>(fs, new JsonSerializerOptions() { WriteIndented = true });
            return res;
        }

        /// <summary>
        /// Нормализация длинных чисел с плавающей точкой (округление до 8 знаков).
        /// Например 21.1000000001 => 21.1
        /// </summary>
        public static double Normalize(this double value)
        {
            return Math.Round(value, 8);
        }

        /// <summary>
        /// Округление дробные чисел
        /// </summary>
        public static double Round(this double value, int digits)
        {
            return Math.Round(value, digits);
        }

        public static T? FindParentOfType<T>(this DependencyObject? child) where T : DependencyObject
        {
            if (child == null)
                return null;
            DependencyObject parentDepObj = child;
            do
            {
                parentDepObj = VisualTreeHelper.GetParent(parentDepObj);
                var parent = parentDepObj as T;
                if (parent != null) 
                    return parent;
            }
            while (parentDepObj != null);
            return null;
        }

        public static T? FindVisualChild<T>(DependencyObject? obj) where T : DependencyObject
        {
            if (obj == null)
                return null;
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(obj); i++)
            {
                var child = VisualTreeHelper.GetChild(obj, i);
                if (child != null && child is T)
                {
                    return (T)child;
                }
                else
                {
                    var childOfChild = FindVisualChild<T>(child);
                    if (childOfChild != null)
                        return childOfChild;
                }
            }
            return null;
        }
    }
}
