// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_fast_number_fon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeFastNumberFon _$TradeFastNumberFonFromJson(Map<String, dynamic> json) {
  return _TradeFastNumberFon.fromJson(json);
}

/// @nodoc
mixin _$TradeFastNumberFon {
  int? get amount => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  int? get sort => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeFastNumberFonCopyWith<TradeFastNumberFon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeFastNumberFonCopyWith<$Res> {
  factory $TradeFastNumberFonCopyWith(
          TradeFastNumberFon value, $Res Function(TradeFastNumberFon) then) =
      _$TradeFastNumberFonCopyWithImpl<$Res, TradeFastNumberFon>;
  @useResult
  $Res call(
      {int? amount,
      String? createdAt,
      int? id,
      int? sort,
      String? tag,
      String? updatedAt});
}

/// @nodoc
class _$TradeFastNumberFonCopyWithImpl<$Res, $Val extends TradeFastNumberFon>
    implements $TradeFastNumberFonCopyWith<$Res> {
  _$TradeFastNumberFonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? sort = freezed,
    Object? tag = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeFastNumberFonImplCopyWith<$Res>
    implements $TradeFastNumberFonCopyWith<$Res> {
  factory _$$TradeFastNumberFonImplCopyWith(_$TradeFastNumberFonImpl value,
          $Res Function(_$TradeFastNumberFonImpl) then) =
      __$$TradeFastNumberFonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? createdAt,
      int? id,
      int? sort,
      String? tag,
      String? updatedAt});
}

/// @nodoc
class __$$TradeFastNumberFonImplCopyWithImpl<$Res>
    extends _$TradeFastNumberFonCopyWithImpl<$Res, _$TradeFastNumberFonImpl>
    implements _$$TradeFastNumberFonImplCopyWith<$Res> {
  __$$TradeFastNumberFonImplCopyWithImpl(_$TradeFastNumberFonImpl _value,
      $Res Function(_$TradeFastNumberFonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? sort = freezed,
    Object? tag = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TradeFastNumberFonImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sort: freezed == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
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
class _$TradeFastNumberFonImpl implements _TradeFastNumberFon {
  const _$TradeFastNumberFonImpl(
      {this.amount,
      this.createdAt,
      this.id,
      this.sort,
      this.tag,
      this.updatedAt});

  factory _$TradeFastNumberFonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeFastNumberFonImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? createdAt;
  @override
  final int? id;
  @override
  final int? sort;
  @override
  final String? tag;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'TradeFastNumberFon(amount: $amount, createdAt: $createdAt, id: $id, sort: $sort, tag: $tag, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeFastNumberFonImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, createdAt, id, sort, tag, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeFastNumberFonImplCopyWith<_$TradeFastNumberFonImpl> get copyWith =>
      __$$TradeFastNumberFonImplCopyWithImpl<_$TradeFastNumberFonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeFastNumberFonImplToJson(
      this,
    );
  }
}

abstract class _TradeFastNumberFon implements TradeFastNumberFon {
  const factory _TradeFastNumberFon(
      {final int? amount,
      final String? createdAt,
      final int? id,
      final int? sort,
      final String? tag,
      final String? updatedAt}) = _$TradeFastNumberFonImpl;

  factory _TradeFastNumberFon.fromJson(Map<String, dynamic> json) =
      _$TradeFastNumberFonImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get createdAt;
  @override
  int? get id;
  @override
  int? get sort;
  @override
  String? get tag;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TradeFastNumberFonImplCopyWith<_$TradeFastNumberFonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
