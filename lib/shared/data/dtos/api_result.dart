import 'dart:convert';

class ApiResult<T> {
  final ApiMeta meta;
  final T? data;
  final List<ApiError>? error;

  ApiResult({
    required this.meta,
    this.data,
    this.error,
  });

  ApiResult copyWith({
    ApiMeta? meta,
    T? data,
    List<ApiError>? error,
  }) =>
      ApiResult(
        meta: meta ?? this.meta,
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ApiResult.fromRawJson(String str) =>
      ApiResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResult.fromJson(
    Map<String, dynamic> json, {
    T Function(Object? json)? fromJsonT,
  }) =>
      ApiResult<T>(
        meta: ApiMeta.fromJson(json['meta']),
        data: fromJsonT != null ? fromJsonT(json['data']) : json['data'],
        error: json['error'] != null
            ? List<ApiError>.from(
                json['error'].map((x) => ApiError.fromJson(x)),
              )
            : null,
      );

  Map<String, dynamic> toJson({Object? Function(T value)? toJsonT}) => {
        'meta': meta.toJson(),
        'data': toJsonT != null ? toJsonT(data as T) : data,
        'error': error != null
            ? List<dynamic>.from(error!.map((x) => x.toJson()))
            : null,
      };
}

class ApiMeta {
  final int code;
  final String message;
  final bool status;

  ApiMeta({
    required this.code,
    required this.message,
    required this.status,
  });

  ApiMeta copyWith({
    int? code,
    String? message,
    bool? status,
  }) =>
      ApiMeta(
        code: code ?? this.code,
        message: message ?? this.message,
        status: status ?? this.status,
      );

  factory ApiMeta.fromRawJson(String str) => ApiMeta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiMeta.fromJson(Map<String, dynamic> json) => ApiMeta(
        code: json["code"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
      };
}

class ApiError {
  final String? key;
  final String? value;

  ApiError({
    this.key,
    this.value,
  });

  ApiError copyWith({
    String? key,
    String? value,
  }) =>
      ApiError(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory ApiError.fromRawJson(String str) =>
      ApiError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
