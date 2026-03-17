// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_trade_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuickTradeRequest _$QuickTradeRequestFromJson(Map<String, dynamic> json) {
  return _QuickTradeRequest.fromJson(json);
}

/// @nodoc
mixin _$QuickTradeRequest {
  double? get amount => throw _privateConstructorUsedError;
  double? get number => throw _privateConstructorUsedError;
  int? get payMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuickTradeRequestCopyWith<QuickTradeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickTradeRequestCopyWith<$Res> {
  factory $QuickTradeRequestCopyWith(
          QuickTradeRequest value, $Res Function(QuickTradeRequest) then) =
      _$QuickTradeRequestCopyWithImpl<$Res, QuickTradeRequest>;
  @useResult
  $Res call({double? amount, double? number, int? payMethod});
}

/// @nodoc
class _$QuickTradeRequestCopyWithImpl<$Res, $Val extends QuickTradeRequest>
    implements $QuickTradeRequestCopyWith<$Res> {
  _$QuickTradeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? number = freezed,
    Object? payMethod = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
      payMethod: freezed == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickTradeRequestImplCopyWith<$Res>
    implements $QuickTradeRequestCopyWith<$Res> {
  factory _$$QuickTradeRequestImplCopyWith(_$QuickTradeRequestImpl value,
          $Res Function(_$QuickTradeRequestImpl) then) =
      __$$QuickTradeRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? amount, double? number, int? payMethod});
}

/// @nodoc
class __$$QuickTradeRequestImplCopyWithImpl<$Res>
    extends _$QuickTradeRequestCopyWithImpl<$Res, _$QuickTradeRequestImpl>
    implements _$$QuickTradeRequestImplCopyWith<$Res> {
  __$$QuickTradeRequestImplCopyWithImpl(_$QuickTradeRequestImpl _value,
      $Res Function(_$QuickTradeRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? number = freezed,
    Object? payMethod = freezed,
  }) {
    return _then(_$QuickTradeRequestImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double?,
      payMethod: freezed == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickTradeRequestImpl
    with DiagnosticableTreeMixin
    implements _QuickTradeRequest {
  const _$QuickTradeRequestImpl({this.amount, this.number, this.payMethod});

  factory _$QuickTradeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickTradeRequestImplFromJson(json);

  @override
  final double? amount;
  @override
  final double? number;
  @override
  final int? payMethod;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuickTradeRequest(amount: $amount, number: $number, payMethod: $payMethod)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuickTradeRequest'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('payMethod', payMethod));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickTradeRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.payMethod, payMethod) ||
                other.payMethod == payMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, number, payMethod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickTradeRequestImplCopyWith<_$QuickTradeRequestImpl> get copyWith =>
      __$$QuickTradeRequestImplCopyWithImpl<_$QuickTradeRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickTradeRequestImplToJson(
      this,
    );
  }
}

abstract class _QuickTradeRequest implements QuickTradeRequest {
  const factory _QuickTradeRequest(
      {final double? amount,
      final double? number,
      final int? payMethod}) = _$QuickTradeRequestImpl;

  factory _QuickTradeRequest.fromJson(Map<String, dynamic> json) =
      _$QuickTradeRequestImpl.fromJson;

  @override
  double? get amount;
  @override
  double? get number;
  @override
  int? get payMethod;
  @override
  @JsonKey(ignore: true)
  _$$QuickTradeRequestImplCopyWith<_$QuickTradeRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
