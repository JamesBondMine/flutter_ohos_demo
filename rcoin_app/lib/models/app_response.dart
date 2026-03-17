import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_response.freezed.dart';

part 'app_response.g.dart';

@Freezed(genericArgumentFactories: true)
class AppResponse<T> with _$AppResponse {
  const factory AppResponse({
    @Default(0) int code,
    T? data,
    @Default('') String msg,
  }) = _AppResponse;

  factory AppResponse.fromJson(
          Map<String, Object?> json, T Function(dynamic json) fromJsonT) =>
      _$AppResponseFromJson(json, fromJsonT);
}
