// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_assets_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserAssetsResponse _$UserAssetsResponseFromJson(Map<String, dynamic> json) {
  return _UserAssetsResponse.fromJson(json);
}

/// @nodoc
mixin _$UserAssetsResponse {
  String? get address => throw _privateConstructorUsedError;
  double? get deposit => throw _privateConstructorUsedError;
  double? get money => throw _privateConstructorUsedError;
  double? get todayEarnings => throw _privateConstructorUsedError;
  double? get tradeAmount => throw _privateConstructorUsedError;
  double? get yesterdayEarnings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAssetsResponseCopyWith<UserAssetsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAssetsResponseCopyWith<$Res> {
  factory $UserAssetsResponseCopyWith(
          UserAssetsResponse value, $Res Function(UserAssetsResponse) then) =
      _$UserAssetsResponseCopyWithImpl<$Res, UserAssetsResponse>;
  @useResult
  $Res call(
      {String? address,
      double? deposit,
      double? money,
      double? todayEarnings,
      double? tradeAmount,
      double? yesterdayEarnings});
}

/// @nodoc
class _$UserAssetsResponseCopyWithImpl<$Res, $Val extends UserAssetsResponse>
    implements $UserAssetsResponseCopyWith<$Res> {
  _$UserAssetsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? deposit = freezed,
    Object? money = freezed,
    Object? todayEarnings = freezed,
    Object? tradeAmount = freezed,
    Object? yesterdayEarnings = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      deposit: freezed == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as double?,
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as double?,
      todayEarnings: freezed == todayEarnings
          ? _value.todayEarnings
          : todayEarnings // ignore: cast_nullable_to_non_nullable
              as double?,
      tradeAmount: freezed == tradeAmount
          ? _value.tradeAmount
          : tradeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      yesterdayEarnings: freezed == yesterdayEarnings
          ? _value.yesterdayEarnings
          : yesterdayEarnings // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAssetsResponseImplCopyWith<$Res>
    implements $UserAssetsResponseCopyWith<$Res> {
  factory _$$UserAssetsResponseImplCopyWith(_$UserAssetsResponseImpl value,
          $Res Function(_$UserAssetsResponseImpl) then) =
      __$$UserAssetsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? address,
      double? deposit,
      double? money,
      double? todayEarnings,
      double? tradeAmount,
      double? yesterdayEarnings});
}

/// @nodoc
class __$$UserAssetsResponseImplCopyWithImpl<$Res>
    extends _$UserAssetsResponseCopyWithImpl<$Res, _$UserAssetsResponseImpl>
    implements _$$UserAssetsResponseImplCopyWith<$Res> {
  __$$UserAssetsResponseImplCopyWithImpl(_$UserAssetsResponseImpl _value,
      $Res Function(_$UserAssetsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? deposit = freezed,
    Object? money = freezed,
    Object? todayEarnings = freezed,
    Object? tradeAmount = freezed,
    Object? yesterdayEarnings = freezed,
  }) {
    return _then(_$UserAssetsResponseImpl(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      deposit: freezed == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as double?,
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as double?,
      todayEarnings: freezed == todayEarnings
          ? _value.todayEarnings
          : todayEarnings // ignore: cast_nullable_to_non_nullable
              as double?,
      tradeAmount: freezed == tradeAmount
          ? _value.tradeAmount
          : tradeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      yesterdayEarnings: freezed == yesterdayEarnings
          ? _value.yesterdayEarnings
          : yesterdayEarnings // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAssetsResponseImpl
    with DiagnosticableTreeMixin
    implements _UserAssetsResponse {
  const _$UserAssetsResponseImpl(
      {this.address,
      this.deposit,
      this.money,
      this.todayEarnings,
      this.tradeAmount,
      this.yesterdayEarnings});

  factory _$UserAssetsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAssetsResponseImplFromJson(json);

  @override
  final String? address;
  @override
  final double? deposit;
  @override
  final double? money;
  @override
  final double? todayEarnings;
  @override
  final double? tradeAmount;
  @override
  final double? yesterdayEarnings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserAssetsResponse(address: $address, deposit: $deposit, money: $money, todayEarnings: $todayEarnings, tradeAmount: $tradeAmount, yesterdayEarnings: $yesterdayEarnings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserAssetsResponse'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('deposit', deposit))
      ..add(DiagnosticsProperty('money', money))
      ..add(DiagnosticsProperty('todayEarnings', todayEarnings))
      ..add(DiagnosticsProperty('tradeAmount', tradeAmount))
      ..add(DiagnosticsProperty('yesterdayEarnings', yesterdayEarnings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAssetsResponseImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.money, money) || other.money == money) &&
            (identical(other.todayEarnings, todayEarnings) ||
                other.todayEarnings == todayEarnings) &&
            (identical(other.tradeAmount, tradeAmount) ||
                other.tradeAmount == tradeAmount) &&
            (identical(other.yesterdayEarnings, yesterdayEarnings) ||
                other.yesterdayEarnings == yesterdayEarnings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, deposit, money,
      todayEarnings, tradeAmount, yesterdayEarnings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAssetsResponseImplCopyWith<_$UserAssetsResponseImpl> get copyWith =>
      __$$UserAssetsResponseImplCopyWithImpl<_$UserAssetsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAssetsResponseImplToJson(
      this,
    );
  }
}

abstract class _UserAssetsResponse implements UserAssetsResponse {
  const factory _UserAssetsResponse(
      {final String? address,
      final double? deposit,
      final double? money,
      final double? todayEarnings,
      final double? tradeAmount,
      final double? yesterdayEarnings}) = _$UserAssetsResponseImpl;

  factory _UserAssetsResponse.fromJson(Map<String, dynamic> json) =
      _$UserAssetsResponseImpl.fromJson;

  @override
  String? get address;
  @override
  double? get deposit;
  @override
  double? get money;
  @override
  double? get todayEarnings;
  @override
  double? get tradeAmount;
  @override
  double? get yesterdayEarnings;
  @override
  @JsonKey(ignore: true)
  _$$UserAssetsResponseImplCopyWith<_$UserAssetsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
