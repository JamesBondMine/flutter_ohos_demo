// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appeal_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppealRequest _$AppealRequestFromJson(Map<String, dynamic> json) {
  return _AppealRequest.fromJson(json);
}

/// @nodoc
mixin _$AppealRequest {
  String? get content => throw _privateConstructorUsedError;
  String? get imgs => throw _privateConstructorUsedError;
  int? get reasonId => throw _privateConstructorUsedError;
  int? get tradeId => throw _privateConstructorUsedError;
  String? get videoUrls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppealRequestCopyWith<AppealRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppealRequestCopyWith<$Res> {
  factory $AppealRequestCopyWith(
          AppealRequest value, $Res Function(AppealRequest) then) =
      _$AppealRequestCopyWithImpl<$Res, AppealRequest>;
  @useResult
  $Res call(
      {String? content,
      String? imgs,
      int? reasonId,
      int? tradeId,
      String? videoUrls});
}

/// @nodoc
class _$AppealRequestCopyWithImpl<$Res, $Val extends AppealRequest>
    implements $AppealRequestCopyWith<$Res> {
  _$AppealRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? imgs = freezed,
    Object? reasonId = freezed,
    Object? tradeId = freezed,
    Object? videoUrls = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imgs: freezed == imgs
          ? _value.imgs
          : imgs // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonId: freezed == reasonId
          ? _value.reasonId
          : reasonId // ignore: cast_nullable_to_non_nullable
              as int?,
      tradeId: freezed == tradeId
          ? _value.tradeId
          : tradeId // ignore: cast_nullable_to_non_nullable
              as int?,
      videoUrls: freezed == videoUrls
          ? _value.videoUrls
          : videoUrls // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppealRequestImplCopyWith<$Res>
    implements $AppealRequestCopyWith<$Res> {
  factory _$$AppealRequestImplCopyWith(
          _$AppealRequestImpl value, $Res Function(_$AppealRequestImpl) then) =
      __$$AppealRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? content,
      String? imgs,
      int? reasonId,
      int? tradeId,
      String? videoUrls});
}

/// @nodoc
class __$$AppealRequestImplCopyWithImpl<$Res>
    extends _$AppealRequestCopyWithImpl<$Res, _$AppealRequestImpl>
    implements _$$AppealRequestImplCopyWith<$Res> {
  __$$AppealRequestImplCopyWithImpl(
      _$AppealRequestImpl _value, $Res Function(_$AppealRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? imgs = freezed,
    Object? reasonId = freezed,
    Object? tradeId = freezed,
    Object? videoUrls = freezed,
  }) {
    return _then(_$AppealRequestImpl(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imgs: freezed == imgs
          ? _value.imgs
          : imgs // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonId: freezed == reasonId
          ? _value.reasonId
          : reasonId // ignore: cast_nullable_to_non_nullable
              as int?,
      tradeId: freezed == tradeId
          ? _value.tradeId
          : tradeId // ignore: cast_nullable_to_non_nullable
              as int?,
      videoUrls: freezed == videoUrls
          ? _value.videoUrls
          : videoUrls // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppealRequestImpl implements _AppealRequest {
  const _$AppealRequestImpl(
      {this.content, this.imgs, this.reasonId, this.tradeId, this.videoUrls});

  factory _$AppealRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppealRequestImplFromJson(json);

  @override
  final String? content;
  @override
  final String? imgs;
  @override
  final int? reasonId;
  @override
  final int? tradeId;
  @override
  final String? videoUrls;

  @override
  String toString() {
    return 'AppealRequest(content: $content, imgs: $imgs, reasonId: $reasonId, tradeId: $tradeId, videoUrls: $videoUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppealRequestImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imgs, imgs) || other.imgs == imgs) &&
            (identical(other.reasonId, reasonId) ||
                other.reasonId == reasonId) &&
            (identical(other.tradeId, tradeId) || other.tradeId == tradeId) &&
            (identical(other.videoUrls, videoUrls) ||
                other.videoUrls == videoUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, content, imgs, reasonId, tradeId, videoUrls);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppealRequestImplCopyWith<_$AppealRequestImpl> get copyWith =>
      __$$AppealRequestImplCopyWithImpl<_$AppealRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppealRequestImplToJson(
      this,
    );
  }
}

abstract class _AppealRequest implements AppealRequest {
  const factory _AppealRequest(
      {final String? content,
      final String? imgs,
      final int? reasonId,
      final int? tradeId,
      final String? videoUrls}) = _$AppealRequestImpl;

  factory _AppealRequest.fromJson(Map<String, dynamic> json) =
      _$AppealRequestImpl.fromJson;

  @override
  String? get content;
  @override
  String? get imgs;
  @override
  int? get reasonId;
  @override
  int? get tradeId;
  @override
  String? get videoUrls;
  @override
  @JsonKey(ignore: true)
  _$$AppealRequestImplCopyWith<_$AppealRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
