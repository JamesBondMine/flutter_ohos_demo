// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_types_fon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BillTypesFon _$BillTypesFonFromJson(Map<String, dynamic> json) {
  return _BillTypesFon.fromJson(json);
}

/// @nodoc
mixin _$BillTypesFon {
  String? get code => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillTypesFonCopyWith<BillTypesFon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillTypesFonCopyWith<$Res> {
  factory $BillTypesFonCopyWith(
          BillTypesFon value, $Res Function(BillTypesFon) then) =
      _$BillTypesFonCopyWithImpl<$Res, BillTypesFon>;
  @useResult
  $Res call(
      {String? code,
      String? createdAt,
      int? id,
      String? name,
      int? status,
      String? updatedAt});
}

/// @nodoc
class _$BillTypesFonCopyWithImpl<$Res, $Val extends BillTypesFon>
    implements $BillTypesFonCopyWith<$Res> {
  _$BillTypesFonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillTypesFonImplCopyWith<$Res>
    implements $BillTypesFonCopyWith<$Res> {
  factory _$$BillTypesFonImplCopyWith(
          _$BillTypesFonImpl value, $Res Function(_$BillTypesFonImpl) then) =
      __$$BillTypesFonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? createdAt,
      int? id,
      String? name,
      int? status,
      String? updatedAt});
}

/// @nodoc
class __$$BillTypesFonImplCopyWithImpl<$Res>
    extends _$BillTypesFonCopyWithImpl<$Res, _$BillTypesFonImpl>
    implements _$$BillTypesFonImplCopyWith<$Res> {
  __$$BillTypesFonImplCopyWithImpl(
      _$BillTypesFonImpl _value, $Res Function(_$BillTypesFonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BillTypesFonImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
class _$BillTypesFonImpl implements _BillTypesFon {
  const _$BillTypesFonImpl(
      {this.code,
      this.createdAt,
      this.id,
      this.name,
      this.status,
      this.updatedAt});

  factory _$BillTypesFonImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillTypesFonImplFromJson(json);

  @override
  final String? code;
  @override
  final String? createdAt;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? status;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'BillTypesFon(code: $code, createdAt: $createdAt, id: $id, name: $name, status: $status, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillTypesFonImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, createdAt, id, name, status, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillTypesFonImplCopyWith<_$BillTypesFonImpl> get copyWith =>
      __$$BillTypesFonImplCopyWithImpl<_$BillTypesFonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillTypesFonImplToJson(
      this,
    );
  }
}

abstract class _BillTypesFon implements BillTypesFon {
  const factory _BillTypesFon(
      {final String? code,
      final String? createdAt,
      final int? id,
      final String? name,
      final int? status,
      final String? updatedAt}) = _$BillTypesFonImpl;

  factory _BillTypesFon.fromJson(Map<String, dynamic> json) =
      _$BillTypesFonImpl.fromJson;

  @override
  String? get code;
  @override
  String? get createdAt;
  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get status;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$BillTypesFonImplCopyWith<_$BillTypesFonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
