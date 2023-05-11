import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class UserSignupCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    final body = '''
{
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UserSignup',
      apiUrl: 'https://ijmtyeoanabkleuldciw.supabase.co/auth/v1/signup',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class UserLoginCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    final body = '''
{
  "email": "${email}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UserLogin',
      apiUrl:
          'https://ijmtyeoanabkleuldciw.supabase.co/auth/v1/token?grant_type=password',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetUserDataCall {
  static Future<ApiCallResponse> call({
    String? accessToken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUserData',
      apiUrl: 'https://ijmtyeoanabkleuldciw.supabase.co/auth/v1/user',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
        'Authorization': 'Bearer ${accessToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class UpdateUserCall {
  static Future<ApiCallResponse> call({
    String? options = 'redirectTo',
    String? email = '',
  }) {
    final body = '''
{
  "email": "${email}",
  "options": "${options}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateUser',
      apiUrl: 'https://ijmtyeoanabkleuldciw.supabase.co/auth/v1/updateUser',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class LogoutCall {
  static Future<ApiCallResponse> call({
    String? authorization = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'logout',
      apiUrl: 'https://sgezgmgifqhzgxklkalo.supabase.co/auth/v1/signOut',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
        'Authorization': 'Bearer ${authorization}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ResetPasswordForEmailCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? oldpassword = '',
  }) {
    final body = '''
{
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'resetPasswordForEmail',
      apiUrl: 'https://ijmtyeoanabkleuldciw.supabase.co/auth/v1/update',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class FCall {
  static Future<ApiCallResponse> call({
    String? accessToken = '',
    String? idUser = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'f',
      apiUrl: 'https://ijmtyeoanabkleuldciw.supabase.co/rest/v1/client_info',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqbXR5ZW9hbmFia2xldWxkY2l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3ODY0ODU4MiwiZXhwIjoxOTk0MjI0NTgyfQ.au9F-gHh2lNOhbPmFYDg1skFRWBkYhgngEnzvvlJ-Tw',
        'Authorization': 'Bearer ${accessToken}',
      },
      params: {
        'id_user': idUser,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PortfolioCall {
  static Future<ApiCallResponse> call({
    String? clientId = '537529R6YZO',
    bool? contentIncludeCurrencies = true,
    bool? contentIncludePositions = true,
    bool? contentIncludeMaxBuySell = true,
    bool? contentIncludeMoney = true,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'portfolio',
      apiUrl: 'https://trade-api.finam.ru/api/v1/portfolio',
      callType: ApiCallType.GET,
      headers: {
        'x-Api-key': 'CAEQ3JACGhjB8IBFp4MX1G13FxVAecksz0939R6Jto0=',
      },
      params: {
        'ClientId': clientId,
        'Content.IncludeCurrencies': contentIncludeCurrencies,
        'Content.IncludePositions': contentIncludePositions,
        'Content.IncludeMaxBuySell': contentIncludeMaxBuySell,
        'Content.includeMoney': contentIncludeMoney,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic securityCode(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].securityCode''',
        true,
      );
  static dynamic balance(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].balance''',
        true,
      );
  static dynamic currentPrice(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].currentPrice''',
        true,
      );
  static dynamic equity(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].equity''',
        true,
      );
  static dynamic averagePrice(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].averagePrice''',
        true,
      );
  static dynamic unrealizedProfit(dynamic response) => getJsonField(
        response,
        r'''$.data.positions[:].unrealizedProfit''',
        true,
      );
  static dynamic balanceStock(dynamic response) => getJsonField(
        response,
        r'''$.data.currencies[:].balance''',
      );
  static dynamic profit(dynamic response) => getJsonField(
        response,
        r'''$.data.currencies[:].unrealizedProfit''',
      );
  static dynamic money(dynamic response) => getJsonField(
        response,
        r'''$.data.money''',
        true,
      );
  static dynamic balanceMoney(dynamic response) => getJsonField(
        response,
        r'''$.data.money[:].balance''',
      );
}

class NewsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'news',
      apiUrl: 'https://finnhub.io/api/v1/news?category=general&',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'token': "chd7hi1r01qk9rb2g1lgchd7hi1r01qk9rb2g1m0",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class StockCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'stock',
      apiUrl: 'https://trade-api.finam.ru/api/v1/securities',
      callType: ApiCallType.GET,
      headers: {
        'x-Api-key': 'CAEQ3JACGhjB8IBFp4MX1G13FxVAecksz0939R6Jto0=',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class KkkCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'kkk',
      apiUrl: 'kkk',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class KkkkCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'kkkk',
      apiUrl: 'kkkk',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
