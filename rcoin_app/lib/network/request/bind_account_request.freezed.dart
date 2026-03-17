// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bind_account_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BindAccountRequest _$BindAccountRequestFromJson(Map<String, dynamic> json) {
  return _BindAccountRequest.fromJson(json);
}

/// @nodoc
mixin _$BindAccountRequest {
  String? get account => throw _privateConstructorUsedError;
  String? get areaCode => throw _privateConstructorUsedError;
  int? get bindType => throw _privateConstructorUsedError;
  String? get captcha => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BindAccountRequestCopyWith<BindAccountRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BindAccountRequestCopyWith<$Res> {
  factory $BindAccountRequestCopyWith(
          BindAccountRequest value, $Res Function(BindAccountRequest) then) =
      _$BindAccountRequestCopyWithImpl<$Res, BindAccountRequest>;
  @useResult
  $Res call(
      {String? account, String? areaCode, int? bindType, String? captcha});
}

/// @nodoc
class _$BindAccountRequestCopyWithImpl<$Res, $Val extends BindAccountRequest>
    implements $BindAccountRequestCopyWith<$Res> {
  _$BindAccountRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = freezed,
    Object? areaCode = freezed,
    Object? bindType = freezed,
    Object? captcha = freezed,
  }) {
    return _then(_value.copyWith(
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bindType: freezed == bindType
          ? _value.bindType
          : bindType // ignore: cast_nullable_to_non_nullable
              as int?,
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BindAccountRequestImplCopyWith<$Res>
    implements $BindAccountRequestCopyWith<$Res> {
  factory _$$BindAccountRequestImplCopyWith(_$BindAccountRequestImpl value,
          $Res Function(_$BindAccountRequestImpl) then) =
      __$$BindAccountRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? account, String? areaCode, int? bindType, String? captcha});
}

/// @nodoc
class __$$BindAccountRequestImplCopyWithImpl<$Res>
    extends _$BindAccountRequestCopyWithImpl<$Res, _$BindAccountRequestImpl>
    implements _$$BindAccountRequestImplCopyWith<$Res> {
  __$$BindAccountRequestImplCopyWithImpl(_$BindAccountRequestImpl _value,
      $Res Function(_$BindAccountRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = freezed,
    Object? areaCode = freezed,
    Object? bindType = freezed,
    Object? captcha = freezed,
  }) {
    return _then(_$BindAccountRequestImpl(
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bindType: freezed == bindType
          ? _value.bindType
          : bindType // ignore: cast_nullable_to_non_nullable
              as int?,
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BindAccountRequestImpl
    with DiagnosticableTreeMixin
    implements _BindAccountRequest {
  const _$BindAccountRequestImpl(
      {this.account, this.areaCode, this.bindType, this.captcha});

  factory _$BindAccountRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BindAccountRequestImplFromJson(json);

  @override
  final String? account;
  @override
  final String? areaCode;
  @override
  final int? bindType;
  @override
  final String? captcha;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BindAccountRequest(account: $account, areaCode: $areaCode, bindType: $bindType, captcha: $captcha)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BindAccountRequest'))
      ..add(DiagnosticsProperty('account', account))
      ..add(DiagnosticsProperty('areaCode', areaCode))
      ..add(DiagnosticsProperty('bindType', bindType))
      ..add(DiagnosticsProperty('captcha', captcha));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BindAccountRequestImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode) &&
            (identical(other.bindType, bindType) ||
                other.bindType == bindType) &&
            (identical(other.captcha, captcha) || other.captcha == captcha));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, account, areaCode, bindType, captcha);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BindAccountRequestImplCopyWith<_$BindAccountRequestImpl> get copyWith =>
      __$$BindAccountRequestImplCopyWithImpl<_$BindAccountRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BindAccountRequestImplToJson(
      this,
    );
  }
}

abstract class _BindAccountRequest implements BindAccountRequest {
  const factory _BindAccountRequest(
      {final String? account,
      final String? areaCode,
      final int? bindType,
      final String? captcha}) = _$BindAccountRequestImpl;

  factory _BindAccountRequest.fromJson(Map<String, dynamic> json) =
      _$BindAccountRequestImpl.fromJson;

  @override
  String? get account;
  @override
  String? get areaCode;
  @override
  int? get bindType;
  @override
  String? get captcha;
  @override
  @JsonKey(ignore: true)
  _$$BindAccountRequestImplCopyWith<_$BindAccountRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
