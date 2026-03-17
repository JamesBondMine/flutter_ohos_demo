import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'list_response.freezed.dart';
part 'list_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ListResponse<T> with _$ListResponse {
  const factory ListResponse({
    @Default([])  List<T> list,
  }) = _ListResponse;

  factory ListResponse.fromJson(Map<String, Object?> json, T Function(dynamic json) fromJsonT) =>
      _$ListResponseFromJson(json, fromJsonT);
}
