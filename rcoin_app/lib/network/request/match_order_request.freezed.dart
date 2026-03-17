// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchOrderRequest _$MatchOrderRequestFromJson(Map<String, dynamic> json) {
  return _MatchOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$MatchOrderRequest {
  double? get number => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  int get orderId => throw _privateConstructorUsedError;
  int get payMethod => throw _privateConstructorUsedError;
  String get pwd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchOrderRequestCopyWith<MatchOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchOrderRequestCopyWith<$Res> {
  factory $MatchOrderRequestCopyWith(
          MatchOrderRequest value, $Res Function(MatchOrderRequest) then) =
      _$MatchOrderRequestCopyWithImpl<$Res, MatchOrderRequest>;
  @useResult
  $Res call(
      {double? number, double? amount, int orderId, int payMethod, String pwd});
}

/// @nodoc
class _$MatchOrderRequestCopyWithImpl<$Res, $Val extends MatchOrderRequest>
    implements $MatchOrderRequestCopyWith<$Res> {
  _$MatchOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? amount = freezed,
    Object? orderId = null,
    Object? payMethod = null,
    Object? pwd = null,
  }) {
    return _then(_value.copyWith(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
      pwd: null == pwd
          ? _value.pwd
          : pwd // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchOrderRequestImplCopyWith<$Res>
    implements $MatchOrderRequestCopyWith<$Res> {
  factory _$$MatchOrderRequestImplCopyWith(_$MatchOrderRequestImpl value,
          $Res Function(_$MatchOrderRequestImpl) then) =
      __$$MatchOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? number, double? amount, int orderId, int payMethod, String pwd});
}

/// @nodoc
class __$$MatchOrderRequestImplCopyWithImpl<$Res>
    extends _$MatchOrderRequestCopyWithImpl<$Res, _$MatchOrderRequestImpl>
    implements _$$MatchOrderRequestImplCopyWith<$Res> {
  __$$MatchOrderRequestImplCopyWithImpl(_$MatchOrderRequestImpl _value,
      $Res Function(_$MatchOrderRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = freezed,
    Object? amount = freezed,
    Object? orderId = null,
    Object? payMethod = null,
    Object? pwd = null,
  }) {
    return _then(_$MatchOrderRequestImpl(
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
      pwd: null == pwd
          ? _value.pwd
          : pwd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchOrderRequestImpl
    with DiagnosticableTreeMixin
    implements _MatchOrderRequest {
  const _$MatchOrderRequestImpl(
      {this.number,
      this.amount,
      required this.orderId,
      required this.payMethod,
      required this.pwd});

  factory _$MatchOrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchOrderRequestImplFromJson(json);

  @override
  final double? number;
  @override
  final double? amount;
  @override
  final int orderId;
  @override
  final int payMethod;
  @override
  final String pwd;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MatchOrderRequest(number: $number, amount: $amount, orderId: $orderId, payMethod: $payMethod, pwd: $pwd)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MatchOrderRequest'))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('payMethod', payMethod))
      ..add(DiagnosticsProperty('pwd', pwd));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchOrderRequestImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.payMethod, payMethod) ||
                other.payMethod == payMethod) &&
            (identical(other.pwd, pwd) || other.pwd == pwd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, number, amount, orderId, payMethod, pwd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchOrderRequestImplCopyWith<_$MatchOrderRequestImpl> get copyWith =>
      __$$MatchOrderRequestImplCopyWithImpl<_$MatchOrderRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _MatchOrderRequest implements MatchOrderRequest {
  const factory _MatchOrderRequest(
      {final double? number,
      final double? amount,
      required final int orderId,
      required final int payMethod,
      required final String pwd}) = _$MatchOrderRequestImpl;

  factory _MatchOrderRequest.fromJson(Map<String, dynamic> json) =
      _$MatchOrderRequestImpl.fromJson;

  @override
  double? get number;
  @override
  double? get amount;
  @override
  int get orderId;
  @override
  int get payMethod;
  @override
  String get pwd;
  @override
  @JsonKey(ignore: true)
  _$$MatchOrderRequestImplCopyWith<_$MatchOrderRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
