// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppResponse<T> _$AppResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _AppResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$AppResponse<T> {
  int get code => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppResponseCopyWith<T, AppResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppResponseCopyWith<T, $Res> {
  factory $AppResponseCopyWith(
          AppResponse<T> value, $Res Function(AppResponse<T>) then) =
      _$AppResponseCopyWithImpl<T, $Res, AppResponse<T>>;
  @useResult
  $Res call({int code, T? data, String msg});
}

/// @nodoc
class _$AppResponseCopyWithImpl<T, $Res, $Val extends AppResponse<T>>
    implements $AppResponseCopyWith<T, $Res> {
  _$AppResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? data = freezed,
    Object? msg = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppResponseImplCopyWith<T, $Res>
    implements $AppResponseCopyWith<T, $Res> {
  factory _$$AppResponseImplCopyWith(_$AppResponseImpl<T> value,
          $Res Function(_$AppResponseImpl<T>) then) =
      __$$AppResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int code, T? data, String msg});
}

/// @nodoc
class __$$AppResponseImplCopyWithImpl<T, $Res>
    extends _$AppResponseCopyWithImpl<T, $Res, _$AppResponseImpl<T>>
    implements _$$AppResponseImplCopyWith<T, $Res> {
  __$$AppResponseImplCopyWithImpl(
      _$AppResponseImpl<T> _value, $Res Function(_$AppResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? data = freezed,
    Object? msg = null,
  }) {
    return _then(_$AppResponseImpl<T>(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$AppResponseImpl<T>
    with DiagnosticableTreeMixin
    implements _AppResponse<T> {
  const _$AppResponseImpl({this.code = 0, this.data, this.msg = ''});

  factory _$AppResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$AppResponseImplFromJson(json, fromJsonT);

  @override
  @JsonKey()
  final int code;
  @override
  final T? data;
  @override
  @JsonKey()
  final String msg;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppResponse<$T>(code: $code, data: $data, msg: $msg)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppResponse<$T>'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('msg', msg));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppResponseImpl<T> &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, const DeepCollectionEquality().hash(data), msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppResponseImplCopyWith<T, _$AppResponseImpl<T>> get copyWith =>
      __$$AppResponseImplCopyWithImpl<T, _$AppResponseImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$AppResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _AppResponse<T> implements AppResponse<T> {
  const factory _AppResponse(
      {final int code, final T? data, final String msg}) = _$AppResponseImpl<T>;

  factory _AppResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$AppResponseImpl<T>.fromJson;

  @override
  int get code;
  @override
  T? get data;
  @override
  String get msg;
  @override
  @JsonKey(ignore: true)
  _$$AppResponseImplCopyWith<T, _$AppResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
