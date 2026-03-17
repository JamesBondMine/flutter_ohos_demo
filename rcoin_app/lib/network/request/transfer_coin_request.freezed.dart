// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_coin_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferCoinRequest _$TransferCoinRequestFromJson(Map<String, dynamic> json) {
  return _TransferCoinRequest.fromJson(json);
}

/// @nodoc
mixin _$TransferCoinRequest {
  String? get address => throw _privateConstructorUsedError;
  int? get coinId => throw _privateConstructorUsedError;
  double? get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferCoinRequestCopyWith<TransferCoinRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCoinRequestCopyWith<$Res> {
  factory $TransferCoinRequestCopyWith(
          TransferCoinRequest value, $Res Function(TransferCoinRequest) then) =
      _$TransferCoinRequestCopyWithImpl<$Res, TransferCoinRequest>;
  @useResult
  $Res call({String? address, int? coinId, double? number});
}

/// @nodoc
class _$TransferCoinRequestCopyWithImpl<$Res, $Val extends TransferCoinRequest>
    implements $TransferCoinRequestCopyWith<$Res> {
  _$TransferCoinRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? coinId = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferCoinRequestImplCopyWith<$Res>
    implements $TransferCoinRequestCopyWith<$Res> {
  factory _$$TransferCoinRequestImplCopyWith(_$TransferCoinRequestImpl value,
          $Res Function(_$TransferCoinRequestImpl) then) =
      __$$TransferCoinRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? address, int? coinId, double? number});
}

/// @nodoc
class __$$TransferCoinRequestImplCopyWithImpl<$Res>
    extends _$TransferCoinRequestCopyWithImpl<$Res, _$TransferCoinRequestImpl>
    implements _$$TransferCoinRequestImplCopyWith<$Res> {
  __$$TransferCoinRequestImplCopyWithImpl(_$TransferCoinRequestImpl _value,
      $Res Function(_$TransferCoinRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? coinId = freezed,
    Object? number = freezed,
  }) {
    return _then(_$TransferCoinRequestImpl(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferCoinRequestImpl implements _TransferCoinRequest {
  const _$TransferCoinRequestImpl({this.address, this.coinId, this.number});

  factory _$TransferCoinRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferCoinRequestImplFromJson(json);

  @override
  final String? address;
  @override
  final int? coinId;
  @override
  final double? number;

  @override
  String toString() {
    return 'TransferCoinRequest(address: $address, coinId: $coinId, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferCoinRequestImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, coinId, number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferCoinRequestImplCopyWith<_$TransferCoinRequestImpl> get copyWith =>
      __$$TransferCoinRequestImplCopyWithImpl<_$TransferCoinRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferCoinRequestImplToJson(
      this,
    );
  }
}

abstract class _TransferCoinRequest implements TransferCoinRequest {
  const factory _TransferCoinRequest(
      {final String? address,
      final int? coinId,
      final double? number}) = _$TransferCoinRequestImpl;

  factory _TransferCoinRequest.fromJson(Map<String, dynamic> json) =
      _$TransferCoinRequestImpl.fromJson;

  @override
  String? get address;
  @override
  int? get coinId;
  @override
  double? get number;
  @override
  @JsonKey(ignore: true)
  _$$TransferCoinRequestImplCopyWith<_$TransferCoinRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
