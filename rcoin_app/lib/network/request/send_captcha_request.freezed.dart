// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_captcha_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendCaptchaRequest _$SendCaptchaRequestFromJson(Map<String, dynamic> json) {
  return _SendCaptchaRequest.fromJson(json);
}

/// @nodoc
mixin _$SendCaptchaRequest {
  String get account => throw _privateConstructorUsedError;
  String? get areaCode => throw _privateConstructorUsedError;
  int get captchaType => throw _privateConstructorUsedError; //验证码类型 1短信 2邮箱
  int get scene => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendCaptchaRequestCopyWith<SendCaptchaRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendCaptchaRequestCopyWith<$Res> {
  factory $SendCaptchaRequestCopyWith(
          SendCaptchaRequest value, $Res Function(SendCaptchaRequest) then) =
      _$SendCaptchaRequestCopyWithImpl<$Res, SendCaptchaRequest>;
  @useResult
  $Res call({String account, String? areaCode, int captchaType, int scene});
}

/// @nodoc
class _$SendCaptchaRequestCopyWithImpl<$Res, $Val extends SendCaptchaRequest>
    implements $SendCaptchaRequestCopyWith<$Res> {
  _$SendCaptchaRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? areaCode = freezed,
    Object? captchaType = null,
    Object? scene = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      captchaType: null == captchaType
          ? _value.captchaType
          : captchaType // ignore: cast_nullable_to_non_nullable
              as int,
      scene: null == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendCaptchaRequestImplCopyWith<$Res>
    implements $SendCaptchaRequestCopyWith<$Res> {
  factory _$$SendCaptchaRequestImplCopyWith(_$SendCaptchaRequestImpl value,
          $Res Function(_$SendCaptchaRequestImpl) then) =
      __$$SendCaptchaRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String account, String? areaCode, int captchaType, int scene});
}

/// @nodoc
class __$$SendCaptchaRequestImplCopyWithImpl<$Res>
    extends _$SendCaptchaRequestCopyWithImpl<$Res, _$SendCaptchaRequestImpl>
    implements _$$SendCaptchaRequestImplCopyWith<$Res> {
  __$$SendCaptchaRequestImplCopyWithImpl(_$SendCaptchaRequestImpl _value,
      $Res Function(_$SendCaptchaRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? areaCode = freezed,
    Object? captchaType = null,
    Object? scene = null,
  }) {
    return _then(_$SendCaptchaRequestImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      areaCode: freezed == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String?,
      captchaType: null == captchaType
          ? _value.captchaType
          : captchaType // ignore: cast_nullable_to_non_nullable
              as int,
      scene: null == scene
          ? _value.scene
          : scene // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendCaptchaRequestImpl
    with DiagnosticableTreeMixin
    implements _SendCaptchaRequest {
  const _$SendCaptchaRequestImpl(
      {required this.account,
      this.areaCode,
      required this.captchaType,
      required this.scene});

  factory _$SendCaptchaRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendCaptchaRequestImplFromJson(json);

  @override
  final String account;
  @override
  final String? areaCode;
  @override
  final int captchaType;
//验证码类型 1短信 2邮箱
  @override
  final int scene;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SendCaptchaRequest(account: $account, areaCode: $areaCode, captchaType: $captchaType, scene: $scene)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SendCaptchaRequest'))
      ..add(DiagnosticsProperty('account', account))
      ..add(DiagnosticsProperty('areaCode', areaCode))
      ..add(DiagnosticsProperty('captchaType', captchaType))
      ..add(DiagnosticsProperty('scene', scene));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendCaptchaRequestImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode) &&
            (identical(other.captchaType, captchaType) ||
                other.captchaType == captchaType) &&
            (identical(other.scene, scene) || other.scene == scene));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, account, areaCode, captchaType, scene);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendCaptchaRequestImplCopyWith<_$SendCaptchaRequestImpl> get copyWith =>
      __$$SendCaptchaRequestImplCopyWithImpl<_$SendCaptchaRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendCaptchaRequestImplToJson(
      this,
    );
  }
}

abstract class _SendCaptchaRequest implements SendCaptchaRequest {
  const factory _SendCaptchaRequest(
      {required final String account,
      final String? areaCode,
      required final int captchaType,
      required final int scene}) = _$SendCaptchaRequestImpl;

  factory _SendCaptchaRequest.fromJson(Map<String, dynamic> json) =
      _$SendCaptchaRequestImpl.fromJson;

  @override
  String get account;
  @override
  String? get areaCode;
  @override
  int get captchaType;
  @override //验证码类型 1短信 2邮箱
  int get scene;
  @override
  @JsonKey(ignore: true)
  _$$SendCaptchaRequestImplCopyWith<_$SendCaptchaRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
