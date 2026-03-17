// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_info_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateUserInfoRequest _$UpdateUserInfoRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateUserInfoRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateUserInfoRequest {
  String? get headerImg => throw _privateConstructorUsedError;
  String? get nickName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateUserInfoRequestCopyWith<UpdateUserInfoRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateUserInfoRequestCopyWith<$Res> {
  factory $UpdateUserInfoRequestCopyWith(UpdateUserInfoRequest value,
          $Res Function(UpdateUserInfoRequest) then) =
      _$UpdateUserInfoRequestCopyWithImpl<$Res, UpdateUserInfoRequest>;
  @useResult
  $Res call({String? headerImg, String? nickName});
}

/// @nodoc
class _$UpdateUserInfoRequestCopyWithImpl<$Res,
        $Val extends UpdateUserInfoRequest>
    implements $UpdateUserInfoRequestCopyWith<$Res> {
  _$UpdateUserInfoRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerImg = freezed,
    Object? nickName = freezed,
  }) {
    return _then(_value.copyWith(
      headerImg: freezed == headerImg
          ? _value.headerImg
          : headerImg // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateUserInfoRequestImplCopyWith<$Res>
    implements $UpdateUserInfoRequestCopyWith<$Res> {
  factory _$$UpdateUserInfoRequestImplCopyWith(
          _$UpdateUserInfoRequestImpl value,
          $Res Function(_$UpdateUserInfoRequestImpl) then) =
      __$$UpdateUserInfoRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? headerImg, String? nickName});
}

/// @nodoc
class __$$UpdateUserInfoRequestImplCopyWithImpl<$Res>
    extends _$UpdateUserInfoRequestCopyWithImpl<$Res,
        _$UpdateUserInfoRequestImpl>
    implements _$$UpdateUserInfoRequestImplCopyWith<$Res> {
  __$$UpdateUserInfoRequestImplCopyWithImpl(_$UpdateUserInfoRequestImpl _value,
      $Res Function(_$UpdateUserInfoRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerImg = freezed,
    Object? nickName = freezed,
  }) {
    return _then(_$UpdateUserInfoRequestImpl(
      headerImg: freezed == headerImg
          ? _value.headerImg
          : headerImg // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateUserInfoRequestImpl
    with DiagnosticableTreeMixin
    implements _UpdateUserInfoRequest {
  const _$UpdateUserInfoRequestImpl({this.headerImg, this.nickName});

  factory _$UpdateUserInfoRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateUserInfoRequestImplFromJson(json);

  @override
  final String? headerImg;
  @override
  final String? nickName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateUserInfoRequest(headerImg: $headerImg, nickName: $nickName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdateUserInfoRequest'))
      ..add(DiagnosticsProperty('headerImg', headerImg))
      ..add(DiagnosticsProperty('nickName', nickName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserInfoRequestImpl &&
            (identical(other.headerImg, headerImg) ||
                other.headerImg == headerImg) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, headerImg, nickName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserInfoRequestImplCopyWith<_$UpdateUserInfoRequestImpl>
      get copyWith => __$$UpdateUserInfoRequestImplCopyWithImpl<
          _$UpdateUserInfoRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateUserInfoRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateUserInfoRequest implements UpdateUserInfoRequest {
  const factory _UpdateUserInfoRequest(
      {final String? headerImg,
      final String? nickName}) = _$UpdateUserInfoRequestImpl;

  factory _UpdateUserInfoRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateUserInfoRequestImpl.fromJson;

  @override
  String? get headerImg;
  @override
  String? get nickName;
  @override
  @JsonKey(ignore: true)
  _$$UpdateUserInfoRequestImplCopyWith<_$UpdateUserInfoRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
