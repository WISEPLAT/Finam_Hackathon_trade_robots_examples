import '../database.dart';

class ClientInfoTable extends SupabaseTable<ClientInfoRow> {
  @override
  String get tableName => 'client_info';

  @override
  ClientInfoRow createRow(Map<String, dynamic> data) => ClientInfoRow(data);
}

class ClientInfoRow extends SupabaseDataRow {
  ClientInfoRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClientInfoTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get fName => getField<String>('fName');
  set fName(String? value) => setField<String>('fName', value);

  String? get lName => getField<String>('lName');
  set lName(String? value) => setField<String>('lName', value);

  String? get pName => getField<String>('pName');
  set pName(String? value) => setField<String>('pName', value);

  String? get idUser => getField<String>('id_user');
  set idUser(String? value) => setField<String>('id_user', value);

  DateTime? get birthday => getField<DateTime>('birthday');
  set birthday(DateTime? value) => setField<DateTime>('birthday', value);

  String? get sex => getField<String>('sex');
  set sex(String? value) => setField<String>('sex', value);

  String? get photo => getField<String>('photo');
  set photo(String? value) => setField<String>('photo', value);

  String? get username => getField<String>('username');
  set username(String? value) => setField<String>('username', value);
}
