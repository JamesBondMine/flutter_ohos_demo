// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckUpdateResponse _$CheckUpdateResponseFromJson(Map<String, dynamic> json) {
  return _CheckUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$CheckUpdateResponse {
  String? get device => throw _privateConstructorUsedError;
  String? get log => throw _privateConstructorUsedError;
  bool? get must => throw _privateConstructorUsedError;
  bool? get needUpgrade => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get versionType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckUpdateResponseCopyWith<CheckUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckUpdateResponseCopyWith<$Res> {
  factory $CheckUpdateResponseCopyWith(
          CheckUpdateResponse value, $Res Function(CheckUpdateResponse) then) =
      _$CheckUpdateResponseCopyWithImpl<$Res, CheckUpdateResponse>;
  @useResult
  $Res call(
      {String? device,
      String? log,
      bool? must,
      bool? needUpgrade,
      String? url,
      String? version,
      String? versionType});
}

/// @nodoc
class _$CheckUpdateResponseCopyWithImpl<$Res, $Val extends CheckUpdateResponse>
    implements $CheckUpdateResponseCopyWith<$Res> {
  _$CheckUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? device = freezed,
    Object? log = freezed,
    Object? must = freezed,
    Object? needUpgrade = freezed,
    Object? url = freezed,
    Object? version = freezed,
    Object? versionType = freezed,
  }) {
    return _then(_value.copyWith(
      device: freezed == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as String?,
      log: freezed == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
      must: freezed == must
          ? _value.must
          : must // ignore: cast_nullable_to_non_nullable
              as bool?,
      needUpgrade: freezed == needUpgrade
          ? _value.needUpgrade
          : needUpgrade // ignore: cast_nullable_to_non_nullable
              as bool?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      versionType: freezed == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckUpdateResponseImplCopyWith<$Res>
    implements $CheckUpdateResponseCopyWith<$Res> {
  factory _$$CheckUpdateResponseImplCopyWith(_$CheckUpdateResponseImpl value,
          $Res Function(_$CheckUpdateResponseImpl) then) =
      __$$CheckUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? device,
      String? log,
      bool? must,
      bool? needUpgrade,
      String? url,
      String? version,
      String? versionType});
}

/// @nodoc
class __$$CheckUpdateResponseImplCopyWithImpl<$Res>
    extends _$CheckUpdateResponseCopyWithImpl<$Res, _$CheckUpdateResponseImpl>
    implements _$$CheckUpdateResponseImplCopyWith<$Res> {
  __$$CheckUpdateResponseImplCopyWithImpl(_$CheckUpdateResponseImpl _value,
      $Res Function(_$CheckUpdateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? device = freezed,
    Object? log = freezed,
    Object? must = freezed,
    Object? needUpgrade = freezed,
    Object? url = freezed,
    Object? version = freezed,
    Object? versionType = freezed,
  }) {
    return _then(_$CheckUpdateResponseImpl(
      device: freezed == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as String?,
      log: freezed == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
      must: freezed == must
          ? _value.must
          : must // ignore: cast_nullable_to_non_nullable
              as bool?,
      needUpgrade: freezed == needUpgrade
          ? _value.needUpgrade
          : needUpgrade // ignore: cast_nullable_to_non_nullable
              as bool?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      versionType: freezed == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckUpdateResponseImpl implements _CheckUpdateResponse {
  const _$CheckUpdateResponseImpl(
      {this.device,
      this.log,
      this.must,
      this.needUpgrade,
      this.url,
      this.version,
      this.versionType});

  factory _$CheckUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckUpdateResponseImplFromJson(json);

  @override
  final String? device;
  @override
  final String? log;
  @override
  final bool? must;
  @override
  final bool? needUpgrade;
  @override
  final String? url;
  @override
  final String? version;
  @override
  final String? versionType;

  @override
  String toString() {
    return 'CheckUpdateResponse(device: $device, log: $log, must: $must, needUpgrade: $needUpgrade, url: $url, version: $version, versionType: $versionType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckUpdateResponseImpl &&
            (identical(other.device, device) || other.device == device) &&
            (identical(other.log, log) || other.log == log) &&
            (identical(other.must, must) || other.must == must) &&
            (identical(other.needUpgrade, needUpgrade) ||
                other.needUpgrade == needUpgrade) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.versionType, versionType) ||
                other.versionType == versionType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, device, log, must, needUpgrade, url, version, versionType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckUpdateResponseImplCopyWith<_$CheckUpdateResponseImpl> get copyWith =>
      __$$CheckUpdateResponseImplCopyWithImpl<_$CheckUpdateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckUpdateResponseImplToJson(
      this,
    );
  }
}

abstract class _CheckUpdateResponse implements CheckUpdateResponse {
  const factory _CheckUpdateResponse(
      {final String? device,
      final String? log,
      final bool? must,
      final bool? needUpgrade,
      final String? url,
      final String? version,
      final String? versionType}) = _$CheckUpdateResponseImpl;

  factory _CheckUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$CheckUpdateResponseImpl.fromJson;

  @override
  String? get device;
  @override
  String? get log;
  @override
  bool? get must;
  @override
  bool? get needUpgrade;
  @override
  String? get url;
  @override
  String? get version;
  @override
  String? get versionType;
  @override
  @JsonKey(ignore: true)
  _$$CheckUpdateResponseImplCopyWith<_$CheckUpdateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
