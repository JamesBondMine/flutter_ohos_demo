// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_pay_password_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SetPayPasswordRequest _$SetPayPasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _SetPayPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$SetPayPasswordRequest {
  String get account => throw _privateConstructorUsedError;
  String get captcha => throw _privateConstructorUsedError;
  String get confirmPayPassword => throw _privateConstructorUsedError;
  String get payPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetPayPasswordRequestCopyWith<SetPayPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetPayPasswordRequestCopyWith<$Res> {
  factory $SetPayPasswordRequestCopyWith(SetPayPasswordRequest value,
          $Res Function(SetPayPasswordRequest) then) =
      _$SetPayPasswordRequestCopyWithImpl<$Res, SetPayPasswordRequest>;
  @useResult
  $Res call(
      {String account,
      String captcha,
      String confirmPayPassword,
      String payPassword});
}

/// @nodoc
class _$SetPayPasswordRequestCopyWithImpl<$Res,
        $Val extends SetPayPasswordRequest>
    implements $SetPayPasswordRequestCopyWith<$Res> {
  _$SetPayPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? captcha = null,
    Object? confirmPayPassword = null,
    Object? payPassword = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      captcha: null == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPayPassword: null == confirmPayPassword
          ? _value.confirmPayPassword
          : confirmPayPassword // ignore: cast_nullable_to_non_nullable
              as String,
      payPassword: null == payPassword
          ? _value.payPassword
          : payPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetPayPasswordRequestImplCopyWith<$Res>
    implements $SetPayPasswordRequestCopyWith<$Res> {
  factory _$$SetPayPasswordRequestImplCopyWith(
          _$SetPayPasswordRequestImpl value,
          $Res Function(_$SetPayPasswordRequestImpl) then) =
      __$$SetPayPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String account,
      String captcha,
      String confirmPayPassword,
      String payPassword});
}

/// @nodoc
class __$$SetPayPasswordRequestImplCopyWithImpl<$Res>
    extends _$SetPayPasswordRequestCopyWithImpl<$Res,
        _$SetPayPasswordRequestImpl>
    implements _$$SetPayPasswordRequestImplCopyWith<$Res> {
  __$$SetPayPasswordRequestImplCopyWithImpl(_$SetPayPasswordRequestImpl _value,
      $Res Function(_$SetPayPasswordRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? captcha = null,
    Object? confirmPayPassword = null,
    Object? payPassword = null,
  }) {
    return _then(_$SetPayPasswordRequestImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      captcha: null == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPayPassword: null == confirmPayPassword
          ? _value.confirmPayPassword
          : confirmPayPassword // ignore: cast_nullable_to_non_nullable
              as String,
      payPassword: null == payPassword
          ? _value.payPassword
          : payPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetPayPasswordRequestImpl
    with DiagnosticableTreeMixin
    implements _SetPayPasswordRequest {
  const _$SetPayPasswordRequestImpl(
      {required this.account,
      required this.captcha,
      required this.confirmPayPassword,
      required this.payPassword});

  factory _$SetPayPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetPayPasswordRequestImplFromJson(json);

  @override
  final String account;
  @override
  final String captcha;
  @override
  final String confirmPayPassword;
  @override
  final String payPassword;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SetPayPasswordRequest(account: $account, captcha: $captcha, confirmPayPassword: $confirmPayPassword, payPassword: $payPassword)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SetPayPasswordRequest'))
      ..add(DiagnosticsProperty('account', account))
      ..add(DiagnosticsProperty('captcha', captcha))
      ..add(DiagnosticsProperty('confirmPayPassword', confirmPayPassword))
      ..add(DiagnosticsProperty('payPassword', payPassword));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPayPasswordRequestImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.captcha, captcha) || other.captcha == captcha) &&
            (identical(other.confirmPayPassword, confirmPayPassword) ||
                other.confirmPayPassword == confirmPayPassword) &&
            (identical(other.payPassword, payPassword) ||
                other.payPassword == payPassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, account, captcha, confirmPayPassword, payPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetPayPasswordRequestImplCopyWith<_$SetPayPasswordRequestImpl>
      get copyWith => __$$SetPayPasswordRequestImplCopyWithImpl<
          _$SetPayPasswordRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetPayPasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _SetPayPasswordRequest implements SetPayPasswordRequest {
  const factory _SetPayPasswordRequest(
      {required final String account,
      required final String captcha,
      required final String confirmPayPassword,
      required final String payPassword}) = _$SetPayPasswordRequestImpl;

  factory _SetPayPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$SetPayPasswordRequestImpl.fromJson;

  @override
  String get account;
  @override
  String get captcha;
  @override
  String get confirmPayPassword;
  @override
  String get payPassword;
  @override
  @JsonKey(ignore: true)
  _$$SetPayPasswordRequestImplCopyWith<_$SetPayPasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
