// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_log_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BillLogRequest _$BillLogRequestFromJson(Map<String, dynamic> json) {
  return _BillLogRequest.fromJson(json);
}

/// @nodoc
mixin _$BillLogRequest {
  int? get billTypeId => throw _privateConstructorUsedError;
  int? get coinId => throw _privateConstructorUsedError;
  String? get endCreatedAt => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  String? get startCreatedAt => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillLogRequestCopyWith<BillLogRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillLogRequestCopyWith<$Res> {
  factory $BillLogRequestCopyWith(
          BillLogRequest value, $Res Function(BillLogRequest) then) =
      _$BillLogRequestCopyWithImpl<$Res, BillLogRequest>;
  @useResult
  $Res call(
      {int? billTypeId,
      int? coinId,
      String? endCreatedAt,
      int? page,
      int? pageSize,
      String? startCreatedAt,
      int? type});
}

/// @nodoc
class _$BillLogRequestCopyWithImpl<$Res, $Val extends BillLogRequest>
    implements $BillLogRequestCopyWith<$Res> {
  _$BillLogRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billTypeId = freezed,
    Object? coinId = freezed,
    Object? endCreatedAt = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? startCreatedAt = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      billTypeId: freezed == billTypeId
          ? _value.billTypeId
          : billTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      endCreatedAt: freezed == endCreatedAt
          ? _value.endCreatedAt
          : endCreatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      startCreatedAt: freezed == startCreatedAt
          ? _value.startCreatedAt
          : startCreatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BillLogRequestImplCopyWith<$Res>
    implements $BillLogRequestCopyWith<$Res> {
  factory _$$BillLogRequestImplCopyWith(_$BillLogRequestImpl value,
          $Res Function(_$BillLogRequestImpl) then) =
      __$$BillLogRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? billTypeId,
      int? coinId,
      String? endCreatedAt,
      int? page,
      int? pageSize,
      String? startCreatedAt,
      int? type});
}

/// @nodoc
class __$$BillLogRequestImplCopyWithImpl<$Res>
    extends _$BillLogRequestCopyWithImpl<$Res, _$BillLogRequestImpl>
    implements _$$BillLogRequestImplCopyWith<$Res> {
  __$$BillLogRequestImplCopyWithImpl(
      _$BillLogRequestImpl _value, $Res Function(_$BillLogRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? billTypeId = freezed,
    Object? coinId = freezed,
    Object? endCreatedAt = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? startCreatedAt = freezed,
    Object? type = freezed,
  }) {
    return _then(_$BillLogRequestImpl(
      billTypeId: freezed == billTypeId
          ? _value.billTypeId
          : billTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      endCreatedAt: freezed == endCreatedAt
          ? _value.endCreatedAt
          : endCreatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      startCreatedAt: freezed == startCreatedAt
          ? _value.startCreatedAt
          : startCreatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BillLogRequestImpl implements _BillLogRequest {
  const _$BillLogRequestImpl(
      {this.billTypeId,
      this.coinId,
      this.endCreatedAt,
      this.page,
      this.pageSize,
      this.startCreatedAt,
      this.type});

  factory _$BillLogRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillLogRequestImplFromJson(json);

  @override
  final int? billTypeId;
  @override
  final int? coinId;
  @override
  final String? endCreatedAt;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final String? startCreatedAt;
  @override
  final int? type;

  @override
  String toString() {
    return 'BillLogRequest(billTypeId: $billTypeId, coinId: $coinId, endCreatedAt: $endCreatedAt, page: $page, pageSize: $pageSize, startCreatedAt: $startCreatedAt, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillLogRequestImpl &&
            (identical(other.billTypeId, billTypeId) ||
                other.billTypeId == billTypeId) &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            (identical(other.endCreatedAt, endCreatedAt) ||
                other.endCreatedAt == endCreatedAt) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.startCreatedAt, startCreatedAt) ||
                other.startCreatedAt == startCreatedAt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, billTypeId, coinId, endCreatedAt,
      page, pageSize, startCreatedAt, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillLogRequestImplCopyWith<_$BillLogRequestImpl> get copyWith =>
      __$$BillLogRequestImplCopyWithImpl<_$BillLogRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillLogRequestImplToJson(
      this,
    );
  }
}

abstract class _BillLogRequest implements BillLogRequest {
  const factory _BillLogRequest(
      {final int? billTypeId,
      final int? coinId,
      final String? endCreatedAt,
      final int? page,
      final int? pageSize,
      final String? startCreatedAt,
      final int? type}) = _$BillLogRequestImpl;

  factory _BillLogRequest.fromJson(Map<String, dynamic> json) =
      _$BillLogRequestImpl.fromJson;

  @override
  int? get billTypeId;
  @override
  int? get coinId;
  @override
  String? get endCreatedAt;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  String? get startCreatedAt;
  @override
  int? get type;
  @override
  @JsonKey(ignore: true)
  _$$BillLogRequestImplCopyWith<_$BillLogRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
