import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('ff_UserData')) {
      try {
        _UserData = jsonDecode(prefs.getString('ff_UserData') ?? '');
      } catch (e) {
        print("Can't decode persisted json. Error: $e.");
      }
    }

    _AccessToken = prefs.getString('ff_AccessToken') ?? _AccessToken;
    _RegistrationID = prefs.getString('ff_RegistrationID') ?? _RegistrationID;
    _color = prefs.getString('ff_color') ?? _color;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  dynamic _UserData;
  dynamic get UserData => _UserData;
  set UserData(dynamic _value) {
    _UserData = _value;
    prefs.setString('ff_UserData', jsonEncode(_value));
  }

  String _AccessToken = '';
  String get AccessToken => _AccessToken;
  set AccessToken(String _value) {
    _AccessToken = _value;
    prefs.setString('ff_AccessToken', _value);
  }

  String _RegistrationID = '';
  String get RegistrationID => _RegistrationID;
  set RegistrationID(String _value) {
    _RegistrationID = _value;
    prefs.setString('ff_RegistrationID', _value);
  }

  String _UploadedFileUrl = '';
  String get UploadedFileUrl => _UploadedFileUrl;
  set UploadedFileUrl(String _value) {
    _UploadedFileUrl = _value;
  }

  String _idUser = '';
  String get idUser => _idUser;
  set idUser(String _value) {
    _idUser = _value;
  }

  List<String> _greetings = [
    'Доброе утро',
    'Добрый день',
    'Добрый вечер',
    'Доброй ночи'
  ];
  List<String> get greetings => _greetings;
  set greetings(List<String> _value) {
    _greetings = _value;
  }

  void addToGreetings(String _value) {
    _greetings.add(_value);
  }

  void removeFromGreetings(String _value) {
    _greetings.remove(_value);
  }

  void removeAtIndexFromGreetings(int _index) {
    _greetings.removeAt(_index);
  }

  String _color = 'светлая';
  String get color => _color;
  set color(String _value) {
    _color = _value;
    prefs.setString('ff_color', _value);
  }

  List<String> _portfolio = [];
  List<String> get portfolio => _portfolio;
  set portfolio(List<String> _value) {
    _portfolio = _value;
  }

  void addToPortfolio(String _value) {
    _portfolio.add(_value);
  }

  void removeFromPortfolio(String _value) {
    _portfolio.remove(_value);
  }

  void removeAtIndexFromPortfolio(int _index) {
    _portfolio.removeAt(_index);
  }

  List<int> _balance = [];
  List<int> get balance => _balance;
  set balance(List<int> _value) {
    _balance = _value;
  }

  void addToBalance(int _value) {
    _balance.add(_value);
  }

  void removeFromBalance(int _value) {
    _balance.remove(_value);
  }

  void removeAtIndexFromBalance(int _index) {
    _balance.removeAt(_index);
  }

  List<double> _currentPrice = [];
  List<double> get currentPrice => _currentPrice;
  set currentPrice(List<double> _value) {
    _currentPrice = _value;
  }

  void addToCurrentPrice(double _value) {
    _currentPrice.add(_value);
  }

  void removeFromCurrentPrice(double _value) {
    _currentPrice.remove(_value);
  }

  void removeAtIndexFromCurrentPrice(int _index) {
    _currentPrice.removeAt(_index);
  }

  List<double> _averagePrice = [];
  List<double> get averagePrice => _averagePrice;
  set averagePrice(List<double> _value) {
    _averagePrice = _value;
  }

  void addToAveragePrice(double _value) {
    _averagePrice.add(_value);
  }

  void removeFromAveragePrice(double _value) {
    _averagePrice.remove(_value);
  }

  void removeAtIndexFromAveragePrice(int _index) {
    _averagePrice.removeAt(_index);
  }

  List<double> _equity = [];
  List<double> get equity => _equity;
  set equity(List<double> _value) {
    _equity = _value;
  }

  void addToEquity(double _value) {
    _equity.add(_value);
  }

  void removeFromEquity(double _value) {
    _equity.remove(_value);
  }

  void removeAtIndexFromEquity(int _index) {
    _equity.removeAt(_index);
  }

  List<int> _idportfolio = [0, 1, 2, 3, 4, 5];
  List<int> get idportfolio => _idportfolio;
  set idportfolio(List<int> _value) {
    _idportfolio = _value;
  }

  void addToIdportfolio(int _value) {
    _idportfolio.add(_value);
  }

  void removeFromIdportfolio(int _value) {
    _idportfolio.remove(_value);
  }

  void removeAtIndexFromIdportfolio(int _index) {
    _idportfolio.removeAt(_index);
  }

  dynamic _api;
  dynamic get api => _api;
  set api(dynamic _value) {
    _api = _value;
  }

  List<String> _xx = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  List<String> get xx => _xx;
  set xx(List<String> _value) {
    _xx = _value;
  }

  void addToXx(String _value) {
    _xx.add(_value);
  }

  void removeFromXx(String _value) {
    _xx.remove(_value);
  }

  void removeAtIndexFromXx(int _index) {
    _xx.removeAt(_index);
  }

  List<String> _yy = [
    '150',
    '180',
    '190',
    '170',
    '180',
    '190',
    '200',
    '170',
    '180',
    '210'
  ];
  List<String> get yy => _yy;
  set yy(List<String> _value) {
    _yy = _value;
  }

  void addToYy(String _value) {
    _yy.add(_value);
  }

  void removeFromYy(String _value) {
    _yy.remove(_value);
  }

  void removeAtIndexFromYy(int _index) {
    _yy.removeAt(_index);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
