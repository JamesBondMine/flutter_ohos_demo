// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckUpdateRequest _$CheckUpdateRequestFromJson(Map<String, dynamic> json) {
  return _CheckUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$CheckUpdateRequest {
  String get currentVersion => throw _privateConstructorUsedError;
  String get device => throw _privateConstructorUsedError;
  String get versionType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckUpdateRequestCopyWith<CheckUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckUpdateRequestCopyWith<$Res> {
  factory $CheckUpdateRequestCopyWith(
          CheckUpdateRequest value, $Res Function(CheckUpdateRequest) then) =
      _$CheckUpdateRequestCopyWithImpl<$Res, CheckUpdateRequest>;
  @useResult
  $Res call({String currentVersion, String device, String versionType});
}

/// @nodoc
class _$CheckUpdateRequestCopyWithImpl<$Res, $Val extends CheckUpdateRequest>
    implements $CheckUpdateRequestCopyWith<$Res> {
  _$CheckUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVersion = null,
    Object? device = null,
    Object? versionType = null,
  }) {
    return _then(_value.copyWith(
      currentVersion: null == currentVersion
          ? _value.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String,
      device: null == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as String,
      versionType: null == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckUpdateRequestImplCopyWith<$Res>
    implements $CheckUpdateRequestCopyWith<$Res> {
  factory _$$CheckUpdateRequestImplCopyWith(_$CheckUpdateRequestImpl value,
          $Res Function(_$CheckUpdateRequestImpl) then) =
      __$$CheckUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentVersion, String device, String versionType});
}

/// @nodoc
class __$$CheckUpdateRequestImplCopyWithImpl<$Res>
    extends _$CheckUpdateRequestCopyWithImpl<$Res, _$CheckUpdateRequestImpl>
    implements _$$CheckUpdateRequestImplCopyWith<$Res> {
  __$$CheckUpdateRequestImplCopyWithImpl(_$CheckUpdateRequestImpl _value,
      $Res Function(_$CheckUpdateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVersion = null,
    Object? device = null,
    Object? versionType = null,
  }) {
    return _then(_$CheckUpdateRequestImpl(
      currentVersion: null == currentVersion
          ? _value.currentVersion
          : currentVersion // ignore: cast_nullable_to_non_nullable
              as String,
      device: null == device
          ? _value.device
          : device // ignore: cast_nullable_to_non_nullable
              as String,
      versionType: null == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckUpdateRequestImpl implements _CheckUpdateRequest {
  const _$CheckUpdateRequestImpl(
      {required this.currentVersion,
      required this.device,
      required this.versionType});

  factory _$CheckUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckUpdateRequestImplFromJson(json);

  @override
  final String currentVersion;
  @override
  final String device;
  @override
  final String versionType;

  @override
  String toString() {
    return 'CheckUpdateRequest(currentVersion: $currentVersion, device: $device, versionType: $versionType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckUpdateRequestImpl &&
            (identical(other.currentVersion, currentVersion) ||
                other.currentVersion == currentVersion) &&
            (identical(other.device, device) || other.device == device) &&
            (identical(other.versionType, versionType) ||
                other.versionType == versionType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentVersion, device, versionType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckUpdateRequestImplCopyWith<_$CheckUpdateRequestImpl> get copyWith =>
      __$$CheckUpdateRequestImplCopyWithImpl<_$CheckUpdateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _CheckUpdateRequest implements CheckUpdateRequest {
  const factory _CheckUpdateRequest(
      {required final String currentVersion,
      required final String device,
      required final String versionType}) = _$CheckUpdateRequestImpl;

  factory _CheckUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$CheckUpdateRequestImpl.fromJson;

  @override
  String get currentVersion;
  @override
  String get device;
  @override
  String get versionType;
  @override
  @JsonKey(ignore: true)
  _$$CheckUpdateRequestImplCopyWith<_$CheckUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
