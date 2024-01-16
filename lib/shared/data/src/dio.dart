import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_mock_interceptor/dio_mock_interceptor.dart';
import 'package:flutter/foundation.dart';

import '../../../env.dart';
import '../dto/api_result.dart';
import 'fss.dart';

class HttpClient {
  static final _instance = Dio(
    BaseOptions(
      baseUrl: Env.apiUrl,
      contentType: 'application/json',
      headers: {
        'Accept': 'application/vnd.promedia+json; version=1.0',
      },
    ),
  );
  static Dio get instance => _instance;

  /// **Must be called on void main() {}**
  static Future<void> init() async {
    if (Env.dataSource == 'mock') {
      instance.interceptors.add(MockInterceptor());
    }

    if (kDebugMode) {
      instance.interceptors.add(LogInterceptor());
    }

    await requestToken(instance, forced: true);
    instance.interceptors.add(TokenInterceptor());
  }
}

Future<String?> requestToken(Dio dio, {bool forced = false}) async {
  String? token = await SecureStorage.read('x-access-token');

  if (!forced && token != null) {
    return token;
  }

  final res = await dio.post(
    '/oauth/token/',
    data: {
      'grant_type': 'password',
      'api_key': Env.apiKey,
      'secret_key': Env.apiSecretKey,
    },
  );

  final tokens = ApiResult<_RequestTokenData>.fromJson(
    res.data,
    fromJsonT: _RequestTokenData.fromJson,
  );

  token = tokens.data?.detail.accessToken;
  await SecureStorage.write('x-access-token', token!);

  return token;
}

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await requestToken(HttpClient.instance);
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final unauthorized = err.response?.statusCode == 401 ||
        err.response?.statusCode == 403 ||
        err.response?.data['meta']['message'] == "'grant_type'";

    if (unauthorized) {
      final token = await requestToken(HttpClient.instance, forced: true);
      err.requestOptions.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(err);
  }
}

class _RequestTokenData {
  final _RequestTokenDetail detail;

  _RequestTokenData({
    required this.detail,
  });

  String toRawJson() => json.encode(toJson());

  factory _RequestTokenData.fromJson(Map<String, dynamic> json) =>
      _RequestTokenData(
        detail: _RequestTokenDetail.fromJson(json['detail']),
      );

  Map<String, dynamic> toJson() => {
        'detail': detail.toJson(),
      };
}

class _RequestTokenDetail {
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final String tokenType;

  _RequestTokenDetail({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.tokenType,
  });

  String toRawJson() => json.encode(toJson());

  factory _RequestTokenDetail.fromJson(Map<String, dynamic> json) =>
      _RequestTokenDetail(
        accessToken: json['access_token'],
        expiresIn: json['expires_in'],
        refreshToken: json['refresh_token'],
        tokenType: json['token_type'],
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'expires_in': expiresIn,
        'refresh_token': refreshToken,
        'token_type': tokenType,
      };
}
