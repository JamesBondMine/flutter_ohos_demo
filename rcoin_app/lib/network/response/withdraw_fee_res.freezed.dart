// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdraw_fee_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WithdrawFeeRes _$WithdrawFeeResFromJson(Map<String, dynamic> json) {
  return _WithdrawFeeRes.fromJson(json);
}

/// @nodoc
mixin _$WithdrawFeeRes {
  double? get fee => throw _privateConstructorUsedError;
  double? get USDTAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawFeeResCopyWith<WithdrawFeeRes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawFeeResCopyWith<$Res> {
  factory $WithdrawFeeResCopyWith(
          WithdrawFeeRes value, $Res Function(WithdrawFeeRes) then) =
      _$WithdrawFeeResCopyWithImpl<$Res, WithdrawFeeRes>;
  @useResult
  $Res call({double? fee, double? USDTAmount});
}

/// @nodoc
class _$WithdrawFeeResCopyWithImpl<$Res, $Val extends WithdrawFeeRes>
    implements $WithdrawFeeResCopyWith<$Res> {
  _$WithdrawFeeResCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = freezed,
    Object? USDTAmount = freezed,
  }) {
    return _then(_value.copyWith(
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      USDTAmount: freezed == USDTAmount
          ? _value.USDTAmount
          : USDTAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawFeeResImplCopyWith<$Res>
    implements $WithdrawFeeResCopyWith<$Res> {
  factory _$$WithdrawFeeResImplCopyWith(_$WithdrawFeeResImpl value,
          $Res Function(_$WithdrawFeeResImpl) then) =
      __$$WithdrawFeeResImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? fee, double? USDTAmount});
}

/// @nodoc
class __$$WithdrawFeeResImplCopyWithImpl<$Res>
    extends _$WithdrawFeeResCopyWithImpl<$Res, _$WithdrawFeeResImpl>
    implements _$$WithdrawFeeResImplCopyWith<$Res> {
  __$$WithdrawFeeResImplCopyWithImpl(
      _$WithdrawFeeResImpl _value, $Res Function(_$WithdrawFeeResImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = freezed,
    Object? USDTAmount = freezed,
  }) {
    return _then(_$WithdrawFeeResImpl(
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      USDTAmount: freezed == USDTAmount
          ? _value.USDTAmount
          : USDTAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawFeeResImpl implements _WithdrawFeeRes {
  const _$WithdrawFeeResImpl({this.fee, this.USDTAmount});

  factory _$WithdrawFeeResImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawFeeResImplFromJson(json);

  @override
  final double? fee;
  @override
  final double? USDTAmount;

  @override
  String toString() {
    return 'WithdrawFeeRes(fee: $fee, USDTAmount: $USDTAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawFeeResImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.USDTAmount, USDTAmount) ||
                other.USDTAmount == USDTAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fee, USDTAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawFeeResImplCopyWith<_$WithdrawFeeResImpl> get copyWith =>
      __$$WithdrawFeeResImplCopyWithImpl<_$WithdrawFeeResImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawFeeResImplToJson(
      this,
    );
  }
}

abstract class _WithdrawFeeRes implements WithdrawFeeRes {
  const factory _WithdrawFeeRes({final double? fee, final double? USDTAmount}) =
      _$WithdrawFeeResImpl;

  factory _WithdrawFeeRes.fromJson(Map<String, dynamic> json) =
      _$WithdrawFeeResImpl.fromJson;

  @override
  double? get fee;
  @override
  double? get USDTAmount;
  @override
  @JsonKey(ignore: true)
  _$$WithdrawFeeResImplCopyWith<_$WithdrawFeeResImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
