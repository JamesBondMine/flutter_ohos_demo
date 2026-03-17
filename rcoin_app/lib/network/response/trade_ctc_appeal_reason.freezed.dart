// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_ctc_appeal_reason.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeCtcAppealReason _$TradeCtcAppealReasonFromJson(Map<String, dynamic> json) {
  return _TradeCtcAppealReason.fromJson(json);
}

/// @nodoc
mixin _$TradeCtcAppealReason {
  String? get content => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeCtcAppealReasonCopyWith<TradeCtcAppealReason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeCtcAppealReasonCopyWith<$Res> {
  factory $TradeCtcAppealReasonCopyWith(TradeCtcAppealReason value,
          $Res Function(TradeCtcAppealReason) then) =
      _$TradeCtcAppealReasonCopyWithImpl<$Res, TradeCtcAppealReason>;
  @useResult
  $Res call({String? content, String? createdAt, int? id, String? updatedAt});
}

/// @nodoc
class _$TradeCtcAppealReasonCopyWithImpl<$Res,
        $Val extends TradeCtcAppealReason>
    implements $TradeCtcAppealReasonCopyWith<$Res> {
  _$TradeCtcAppealReasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeCtcAppealReasonImplCopyWith<$Res>
    implements $TradeCtcAppealReasonCopyWith<$Res> {
  factory _$$TradeCtcAppealReasonImplCopyWith(_$TradeCtcAppealReasonImpl value,
          $Res Function(_$TradeCtcAppealReasonImpl) then) =
      __$$TradeCtcAppealReasonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? content, String? createdAt, int? id, String? updatedAt});
}

/// @nodoc
class __$$TradeCtcAppealReasonImplCopyWithImpl<$Res>
    extends _$TradeCtcAppealReasonCopyWithImpl<$Res, _$TradeCtcAppealReasonImpl>
    implements _$$TradeCtcAppealReasonImplCopyWith<$Res> {
  __$$TradeCtcAppealReasonImplCopyWithImpl(_$TradeCtcAppealReasonImpl _value,
      $Res Function(_$TradeCtcAppealReasonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TradeCtcAppealReasonImpl(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeCtcAppealReasonImpl implements _TradeCtcAppealReason {
  const _$TradeCtcAppealReasonImpl(
      {this.content, this.createdAt, this.id, this.updatedAt});

  factory _$TradeCtcAppealReasonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeCtcAppealReasonImplFromJson(json);

  @override
  final String? content;
  @override
  final String? createdAt;
  @override
  final int? id;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'TradeCtcAppealReason(content: $content, createdAt: $createdAt, id: $id, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeCtcAppealReasonImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, content, createdAt, id, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeCtcAppealReasonImplCopyWith<_$TradeCtcAppealReasonImpl>
      get copyWith =>
          __$$TradeCtcAppealReasonImplCopyWithImpl<_$TradeCtcAppealReasonImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeCtcAppealReasonImplToJson(
      this,
    );
  }
}

abstract class _TradeCtcAppealReason implements TradeCtcAppealReason {
  const factory _TradeCtcAppealReason(
      {final String? content,
      final String? createdAt,
      final int? id,
      final String? updatedAt}) = _$TradeCtcAppealReasonImpl;

  factory _TradeCtcAppealReason.fromJson(Map<String, dynamic> json) =
      _$TradeCtcAppealReasonImpl.fromJson;

  @override
  String? get content;
  @override
  String? get createdAt;
  @override
  int? get id;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TradeCtcAppealReasonImplCopyWith<_$TradeCtcAppealReasonImpl>
      get copyWith => throw _privateConstructorUsedError;
}
