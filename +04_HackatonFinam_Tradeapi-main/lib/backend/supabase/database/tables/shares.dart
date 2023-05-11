import '../database.dart';

class SharesTable extends SupabaseTable<SharesRow> {
  @override
  String get tableName => 'shares';

  @override
  SharesRow createRow(Map<String, dynamic> data) => SharesRow(data);
}

class SharesRow extends SupabaseDataRow {
  SharesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SharesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  List<dynamic> get bonds => getListField<dynamic>('bonds');
  set bonds(List<dynamic>? value) => setListField<dynamic>('bonds', value);
}
