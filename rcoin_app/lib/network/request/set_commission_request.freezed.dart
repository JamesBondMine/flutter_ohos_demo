// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_commission_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SetCommissionRequest _$SetCommissionRequestFromJson(Map<String, dynamic> json) {
  return _SetCommissionRequest.fromJson(json);
}

/// @nodoc
mixin _$SetCommissionRequest {
  List<TradeUserCommission>? get commission =>
      throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetCommissionRequestCopyWith<SetCommissionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetCommissionRequestCopyWith<$Res> {
  factory $SetCommissionRequestCopyWith(SetCommissionRequest value,
          $Res Function(SetCommissionRequest) then) =
      _$SetCommissionRequestCopyWithImpl<$Res, SetCommissionRequest>;
  @useResult
  $Res call({List<TradeUserCommission>? commission, int? userId});
}

/// @nodoc
class _$SetCommissionRequestCopyWithImpl<$Res,
        $Val extends SetCommissionRequest>
    implements $SetCommissionRequestCopyWith<$Res> {
  _$SetCommissionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commission = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      commission: freezed == commission
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as List<TradeUserCommission>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetCommissionRequestImplCopyWith<$Res>
    implements $SetCommissionRequestCopyWith<$Res> {
  factory _$$SetCommissionRequestImplCopyWith(_$SetCommissionRequestImpl value,
          $Res Function(_$SetCommissionRequestImpl) then) =
      __$$SetCommissionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TradeUserCommission>? commission, int? userId});
}

/// @nodoc
class __$$SetCommissionRequestImplCopyWithImpl<$Res>
    extends _$SetCommissionRequestCopyWithImpl<$Res, _$SetCommissionRequestImpl>
    implements _$$SetCommissionRequestImplCopyWith<$Res> {
  __$$SetCommissionRequestImplCopyWithImpl(_$SetCommissionRequestImpl _value,
      $Res Function(_$SetCommissionRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commission = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$SetCommissionRequestImpl(
      commission: freezed == commission
          ? _value._commission
          : commission // ignore: cast_nullable_to_non_nullable
              as List<TradeUserCommission>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetCommissionRequestImpl implements _SetCommissionRequest {
  const _$SetCommissionRequestImpl(
      {final List<TradeUserCommission>? commission, this.userId})
      : _commission = commission;

  factory _$SetCommissionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetCommissionRequestImplFromJson(json);

  final List<TradeUserCommission>? _commission;
  @override
  List<TradeUserCommission>? get commission {
    final value = _commission;
    if (value == null) return null;
    if (_commission is EqualUnmodifiableListView) return _commission;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? userId;

  @override
  String toString() {
    return 'SetCommissionRequest(commission: $commission, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCommissionRequestImpl &&
            const DeepCollectionEquality()
                .equals(other._commission, _commission) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_commission), userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCommissionRequestImplCopyWith<_$SetCommissionRequestImpl>
      get copyWith =>
          __$$SetCommissionRequestImplCopyWithImpl<_$SetCommissionRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetCommissionRequestImplToJson(
      this,
    );
  }
}

abstract class _SetCommissionRequest implements SetCommissionRequest {
  const factory _SetCommissionRequest(
      {final List<TradeUserCommission>? commission,
      final int? userId}) = _$SetCommissionRequestImpl;

  factory _SetCommissionRequest.fromJson(Map<String, dynamic> json) =
      _$SetCommissionRequestImpl.fromJson;

  @override
  List<TradeUserCommission>? get commission;
  @override
  int? get userId;
  @override
  @JsonKey(ignore: true)
  _$$SetCommissionRequestImplCopyWith<_$SetCommissionRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
