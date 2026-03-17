// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_notice_fon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeNoticeFon _$TradeNoticeFonFromJson(Map<String, dynamic> json) {
  return _TradeNoticeFon.fromJson(json);
}

/// @nodoc
mixin _$TradeNoticeFon {
  String? get content => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get synopsis => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeNoticeFonCopyWith<TradeNoticeFon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeNoticeFonCopyWith<$Res> {
  factory $TradeNoticeFonCopyWith(
          TradeNoticeFon value, $Res Function(TradeNoticeFon) then) =
      _$TradeNoticeFonCopyWithImpl<$Res, TradeNoticeFon>;
  @useResult
  $Res call(
      {String? content,
      String? createdAt,
      int? id,
      String? synopsis,
      String? title,
      String? updatedAt});
}

/// @nodoc
class _$TradeNoticeFonCopyWithImpl<$Res, $Val extends TradeNoticeFon>
    implements $TradeNoticeFonCopyWith<$Res> {
  _$TradeNoticeFonCopyWithImpl(this._value, this._then);

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
    Object? synopsis = freezed,
    Object? title = freezed,
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
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeNoticeFonImplCopyWith<$Res>
    implements $TradeNoticeFonCopyWith<$Res> {
  factory _$$TradeNoticeFonImplCopyWith(_$TradeNoticeFonImpl value,
          $Res Function(_$TradeNoticeFonImpl) then) =
      __$$TradeNoticeFonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? content,
      String? createdAt,
      int? id,
      String? synopsis,
      String? title,
      String? updatedAt});
}

/// @nodoc
class __$$TradeNoticeFonImplCopyWithImpl<$Res>
    extends _$TradeNoticeFonCopyWithImpl<$Res, _$TradeNoticeFonImpl>
    implements _$$TradeNoticeFonImplCopyWith<$Res> {
  __$$TradeNoticeFonImplCopyWithImpl(
      _$TradeNoticeFonImpl _value, $Res Function(_$TradeNoticeFonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? synopsis = freezed,
    Object? title = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TradeNoticeFonImpl(
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
      synopsis: freezed == synopsis
          ? _value.synopsis
          : synopsis // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeNoticeFonImpl implements _TradeNoticeFon {
  const _$TradeNoticeFonImpl(
      {this.content,
      this.createdAt,
      this.id,
      this.synopsis,
      this.title,
      this.updatedAt});

  factory _$TradeNoticeFonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeNoticeFonImplFromJson(json);

  @override
  final String? content;
  @override
  final String? createdAt;
  @override
  final int? id;
  @override
  final String? synopsis;
  @override
  final String? title;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'TradeNoticeFon(content: $content, createdAt: $createdAt, id: $id, synopsis: $synopsis, title: $title, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeNoticeFonImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.synopsis, synopsis) ||
                other.synopsis == synopsis) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, content, createdAt, id, synopsis, title, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeNoticeFonImplCopyWith<_$TradeNoticeFonImpl> get copyWith =>
      __$$TradeNoticeFonImplCopyWithImpl<_$TradeNoticeFonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeNoticeFonImplToJson(
      this,
    );
  }
}

abstract class _TradeNoticeFon implements TradeNoticeFon {
  const factory _TradeNoticeFon(
      {final String? content,
      final String? createdAt,
      final int? id,
      final String? synopsis,
      final String? title,
      final String? updatedAt}) = _$TradeNoticeFonImpl;

  factory _TradeNoticeFon.fromJson(Map<String, dynamic> json) =
      _$TradeNoticeFonImpl.fromJson;

  @override
  String? get content;
  @override
  String? get createdAt;
  @override
  int? get id;
  @override
  String? get synopsis;
  @override
  String? get title;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TradeNoticeFonImplCopyWith<_$TradeNoticeFonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
