import '../database.dart';

class StockTable extends SupabaseTable<StockRow> {
  @override
  String get tableName => 'stock';

  @override
  StockRow createRow(Map<String, dynamic> data) => StockRow(data);
}

class StockRow extends SupabaseDataRow {
  StockRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StockTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  List<dynamic> get currentPrice => getListField<dynamic>('currentPrice');
  set currentPrice(List<dynamic>? value) =>
      setListField<dynamic>('currentPrice', value);

  List<dynamic> get balance => getListField<dynamic>('balance');
  set balance(List<dynamic>? value) => setListField<dynamic>('balance', value);

  List<dynamic> get equity => getListField<dynamic>('equity');
  set equity(List<dynamic>? value) => setListField<dynamic>('equity', value);

  List<dynamic> get averagePrice => getListField<dynamic>('averagePrice');
  set averagePrice(List<dynamic>? value) =>
      setListField<dynamic>('averagePrice', value);

  List<double> get unrealizedProfit => getListField<double>('unrealizedProfit');
  set unrealizedProfit(List<double>? value) =>
      setListField<double>('unrealizedProfit', value);

  double? get balancePortfolio => getField<double>('balancePortfolio');
  set balancePortfolio(double? value) =>
      setField<double>('balancePortfolio', value);

  List<dynamic> get stock => getListField<dynamic>('stock');
  set stock(List<dynamic>? value) => setListField<dynamic>('stock', value);

  List<dynamic> get sign => getListField<dynamic>('sign');
  set sign(List<dynamic>? value) => setListField<dynamic>('sign', value);

  String? get balanceMoney => getField<String>('balanceMoney');
  set balanceMoney(String? value) => setField<String>('balanceMoney', value);
}
