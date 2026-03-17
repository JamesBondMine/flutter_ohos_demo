// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppResponseImpl<T> _$$AppResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$AppResponseImpl<T>(
      code: (json['code'] as num?)?.toInt() ?? 0,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      msg: json['msg'] as String? ?? '',
    );

Map<String, dynamic> _$$AppResponseImplToJson<T>(
  _$AppResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'msg': instance.msg,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
