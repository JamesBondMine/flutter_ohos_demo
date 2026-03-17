// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publish_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PublishOrderRequest _$PublishOrderRequestFromJson(Map<String, dynamic> json) {
  return _PublishOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$PublishOrderRequest {
  int get coinId => throw _privateConstructorUsedError;
  double get maxMoney => throw _privateConstructorUsedError;
  double get minMoney => throw _privateConstructorUsedError;
  double get number => throw _privateConstructorUsedError;
  List<int> get paymentMethod => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get remark => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PublishOrderRequestCopyWith<PublishOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublishOrderRequestCopyWith<$Res> {
  factory $PublishOrderRequestCopyWith(
          PublishOrderRequest value, $Res Function(PublishOrderRequest) then) =
      _$PublishOrderRequestCopyWithImpl<$Res, PublishOrderRequest>;
  @useResult
  $Res call(
      {int coinId,
      double maxMoney,
      double minMoney,
      double number,
      List<int> paymentMethod,
      double price,
      String remark,
      int type});
}

/// @nodoc
class _$PublishOrderRequestCopyWithImpl<$Res, $Val extends PublishOrderRequest>
    implements $PublishOrderRequestCopyWith<$Res> {
  _$PublishOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinId = null,
    Object? maxMoney = null,
    Object? minMoney = null,
    Object? number = null,
    Object? paymentMethod = null,
    Object? price = null,
    Object? remark = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      coinId: null == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int,
      maxMoney: null == maxMoney
          ? _value.maxMoney
          : maxMoney // ignore: cast_nullable_to_non_nullable
              as double,
      minMoney: null == minMoney
          ? _value.minMoney
          : minMoney // ignore: cast_nullable_to_non_nullable
              as double,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as List<int>,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublishOrderRequestImplCopyWith<$Res>
    implements $PublishOrderRequestCopyWith<$Res> {
  factory _$$PublishOrderRequestImplCopyWith(_$PublishOrderRequestImpl value,
          $Res Function(_$PublishOrderRequestImpl) then) =
      __$$PublishOrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int coinId,
      double maxMoney,
      double minMoney,
      double number,
      List<int> paymentMethod,
      double price,
      String remark,
      int type});
}

/// @nodoc
class __$$PublishOrderRequestImplCopyWithImpl<$Res>
    extends _$PublishOrderRequestCopyWithImpl<$Res, _$PublishOrderRequestImpl>
    implements _$$PublishOrderRequestImplCopyWith<$Res> {
  __$$PublishOrderRequestImplCopyWithImpl(_$PublishOrderRequestImpl _value,
      $Res Function(_$PublishOrderRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinId = null,
    Object? maxMoney = null,
    Object? minMoney = null,
    Object? number = null,
    Object? paymentMethod = null,
    Object? price = null,
    Object? remark = null,
    Object? type = null,
  }) {
    return _then(_$PublishOrderRequestImpl(
      coinId: null == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int,
      maxMoney: null == maxMoney
          ? _value.maxMoney
          : maxMoney // ignore: cast_nullable_to_non_nullable
              as double,
      minMoney: null == minMoney
          ? _value.minMoney
          : minMoney // ignore: cast_nullable_to_non_nullable
              as double,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value._paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as List<int>,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublishOrderRequestImpl
    with DiagnosticableTreeMixin
    implements _PublishOrderRequest {
  const _$PublishOrderRequestImpl(
      {required this.coinId,
      required this.maxMoney,
      required this.minMoney,
      required this.number,
      required final List<int> paymentMethod,
      required this.price,
      required this.remark,
      required this.type})
      : _paymentMethod = paymentMethod;

  factory _$PublishOrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublishOrderRequestImplFromJson(json);

  @override
  final int coinId;
  @override
  final double maxMoney;
  @override
  final double minMoney;
  @override
  final double number;
  final List<int> _paymentMethod;
  @override
  List<int> get paymentMethod {
    if (_paymentMethod is EqualUnmodifiableListView) return _paymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethod);
  }

  @override
  final double price;
  @override
  final String remark;
  @override
  final int type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PublishOrderRequest(coinId: $coinId, maxMoney: $maxMoney, minMoney: $minMoney, number: $number, paymentMethod: $paymentMethod, price: $price, remark: $remark, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PublishOrderRequest'))
      ..add(DiagnosticsProperty('coinId', coinId))
      ..add(DiagnosticsProperty('maxMoney', maxMoney))
      ..add(DiagnosticsProperty('minMoney', minMoney))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('remark', remark))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublishOrderRequestImpl &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            (identical(other.maxMoney, maxMoney) ||
                other.maxMoney == maxMoney) &&
            (identical(other.minMoney, minMoney) ||
                other.minMoney == minMoney) &&
            (identical(other.number, number) || other.number == number) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethod, _paymentMethod) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      coinId,
      maxMoney,
      minMoney,
      number,
      const DeepCollectionEquality().hash(_paymentMethod),
      price,
      remark,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PublishOrderRequestImplCopyWith<_$PublishOrderRequestImpl> get copyWith =>
      __$$PublishOrderRequestImplCopyWithImpl<_$PublishOrderRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublishOrderRequestImplToJson(
      this,
    );
  }
}

abstract class _PublishOrderRequest implements PublishOrderRequest {
  const factory _PublishOrderRequest(
      {required final int coinId,
      required final double maxMoney,
      required final double minMoney,
      required final double number,
      required final List<int> paymentMethod,
      required final double price,
      required final String remark,
      required final int type}) = _$PublishOrderRequestImpl;

  factory _PublishOrderRequest.fromJson(Map<String, dynamic> json) =
      _$PublishOrderRequestImpl.fromJson;

  @override
  int get coinId;
  @override
  double get maxMoney;
  @override
  double get minMoney;
  @override
  double get number;
  @override
  List<int> get paymentMethod;
  @override
  double get price;
  @override
  String get remark;
  @override
  int get type;
  @override
  @JsonKey(ignore: true)
  _$$PublishOrderRequestImplCopyWith<_$PublishOrderRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
