// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bind_google_auth_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BindGoogleAuthRequest _$BindGoogleAuthRequestFromJson(
    Map<String, dynamic> json) {
  return _BindGoogleAuthRequest.fromJson(json);
}

/// @nodoc
mixin _$BindGoogleAuthRequest {
  String? get captcha => throw _privateConstructorUsedError;
  String? get secret => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BindGoogleAuthRequestCopyWith<BindGoogleAuthRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BindGoogleAuthRequestCopyWith<$Res> {
  factory $BindGoogleAuthRequestCopyWith(BindGoogleAuthRequest value,
          $Res Function(BindGoogleAuthRequest) then) =
      _$BindGoogleAuthRequestCopyWithImpl<$Res, BindGoogleAuthRequest>;
  @useResult
  $Res call({String? captcha, String? secret});
}

/// @nodoc
class _$BindGoogleAuthRequestCopyWithImpl<$Res,
        $Val extends BindGoogleAuthRequest>
    implements $BindGoogleAuthRequestCopyWith<$Res> {
  _$BindGoogleAuthRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? captcha = freezed,
    Object? secret = freezed,
  }) {
    return _then(_value.copyWith(
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BindGoogleAuthRequestImplCopyWith<$Res>
    implements $BindGoogleAuthRequestCopyWith<$Res> {
  factory _$$BindGoogleAuthRequestImplCopyWith(
          _$BindGoogleAuthRequestImpl value,
          $Res Function(_$BindGoogleAuthRequestImpl) then) =
      __$$BindGoogleAuthRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? captcha, String? secret});
}

/// @nodoc
class __$$BindGoogleAuthRequestImplCopyWithImpl<$Res>
    extends _$BindGoogleAuthRequestCopyWithImpl<$Res,
        _$BindGoogleAuthRequestImpl>
    implements _$$BindGoogleAuthRequestImplCopyWith<$Res> {
  __$$BindGoogleAuthRequestImplCopyWithImpl(_$BindGoogleAuthRequestImpl _value,
      $Res Function(_$BindGoogleAuthRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? captcha = freezed,
    Object? secret = freezed,
  }) {
    return _then(_$BindGoogleAuthRequestImpl(
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BindGoogleAuthRequestImpl
    with DiagnosticableTreeMixin
    implements _BindGoogleAuthRequest {
  const _$BindGoogleAuthRequestImpl({this.captcha, this.secret});

  factory _$BindGoogleAuthRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BindGoogleAuthRequestImplFromJson(json);

  @override
  final String? captcha;
  @override
  final String? secret;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BindGoogleAuthRequest(captcha: $captcha, secret: $secret)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BindGoogleAuthRequest'))
      ..add(DiagnosticsProperty('captcha', captcha))
      ..add(DiagnosticsProperty('secret', secret));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BindGoogleAuthRequestImpl &&
            (identical(other.captcha, captcha) || other.captcha == captcha) &&
            (identical(other.secret, secret) || other.secret == secret));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, captcha, secret);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BindGoogleAuthRequestImplCopyWith<_$BindGoogleAuthRequestImpl>
      get copyWith => __$$BindGoogleAuthRequestImplCopyWithImpl<
          _$BindGoogleAuthRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BindGoogleAuthRequestImplToJson(
      this,
    );
  }
}

abstract class _BindGoogleAuthRequest implements BindGoogleAuthRequest {
  const factory _BindGoogleAuthRequest(
      {final String? captcha,
      final String? secret}) = _$BindGoogleAuthRequestImpl;

  factory _BindGoogleAuthRequest.fromJson(Map<String, dynamic> json) =
      _$BindGoogleAuthRequestImpl.fromJson;

  @override
  String? get captcha;
  @override
  String? get secret;
  @override
  @JsonKey(ignore: true)
  _$$BindGoogleAuthRequestImplCopyWith<_$BindGoogleAuthRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
