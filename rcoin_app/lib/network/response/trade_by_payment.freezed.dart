// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_by_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResponseCtcTradeByPaymentListRes _$ResponseCtcTradeByPaymentListResFromJson(
    Map<String, dynamic> json) {
  return _ResponseCtcTradeByPaymentListRes.fromJson(json);
}

/// @nodoc
mixin _$ResponseCtcTradeByPaymentListRes {
  @JsonKey(defaultValue: [])
  List<TradeCtcTradeByPaymentFon>? get list =>
      throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseCtcTradeByPaymentListResCopyWith<ResponseCtcTradeByPaymentListRes>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCtcTradeByPaymentListResCopyWith<$Res> {
  factory $ResponseCtcTradeByPaymentListResCopyWith(
          ResponseCtcTradeByPaymentListRes value,
          $Res Function(ResponseCtcTradeByPaymentListRes) then) =
      _$ResponseCtcTradeByPaymentListResCopyWithImpl<$Res,
          ResponseCtcTradeByPaymentListRes>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: []) List<TradeCtcTradeByPaymentFon>? list,
      int page,
      int pageSize,
      int total,
      double totalAmount});
}

/// @nodoc
class _$ResponseCtcTradeByPaymentListResCopyWithImpl<$Res,
        $Val extends ResponseCtcTradeByPaymentListRes>
    implements $ResponseCtcTradeByPaymentListResCopyWith<$Res> {
  _$ResponseCtcTradeByPaymentListResCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TradeCtcTradeByPaymentFon>?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseCtcTradeByPaymentListResImplCopyWith<$Res>
    implements $ResponseCtcTradeByPaymentListResCopyWith<$Res> {
  factory _$$ResponseCtcTradeByPaymentListResImplCopyWith(
          _$ResponseCtcTradeByPaymentListResImpl value,
          $Res Function(_$ResponseCtcTradeByPaymentListResImpl) then) =
      __$$ResponseCtcTradeByPaymentListResImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: []) List<TradeCtcTradeByPaymentFon>? list,
      int page,
      int pageSize,
      int total,
      double totalAmount});
}

/// @nodoc
class __$$ResponseCtcTradeByPaymentListResImplCopyWithImpl<$Res>
    extends _$ResponseCtcTradeByPaymentListResCopyWithImpl<$Res,
        _$ResponseCtcTradeByPaymentListResImpl>
    implements _$$ResponseCtcTradeByPaymentListResImplCopyWith<$Res> {
  __$$ResponseCtcTradeByPaymentListResImplCopyWithImpl(
      _$ResponseCtcTradeByPaymentListResImpl _value,
      $Res Function(_$ResponseCtcTradeByPaymentListResImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
    Object? totalAmount = null,
  }) {
    return _then(_$ResponseCtcTradeByPaymentListResImpl(
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TradeCtcTradeByPaymentFon>?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseCtcTradeByPaymentListResImpl
    implements _ResponseCtcTradeByPaymentListRes {
  const _$ResponseCtcTradeByPaymentListResImpl(
      {@JsonKey(defaultValue: []) final List<TradeCtcTradeByPaymentFon>? list,
      required this.page,
      required this.pageSize,
      required this.total,
      required this.totalAmount})
      : _list = list;

  factory _$ResponseCtcTradeByPaymentListResImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ResponseCtcTradeByPaymentListResImplFromJson(json);

  final List<TradeCtcTradeByPaymentFon>? _list;
  @override
  @JsonKey(defaultValue: [])
  List<TradeCtcTradeByPaymentFon>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;
  @override
  final double totalAmount;

  @override
  String toString() {
    return 'ResponseCtcTradeByPaymentListRes(list: $list, page: $page, pageSize: $pageSize, total: $total, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseCtcTradeByPaymentListResImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      page,
      pageSize,
      total,
      totalAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseCtcTradeByPaymentListResImplCopyWith<
          _$ResponseCtcTradeByPaymentListResImpl>
      get copyWith => __$$ResponseCtcTradeByPaymentListResImplCopyWithImpl<
          _$ResponseCtcTradeByPaymentListResImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseCtcTradeByPaymentListResImplToJson(
      this,
    );
  }
}

abstract class _ResponseCtcTradeByPaymentListRes
    implements ResponseCtcTradeByPaymentListRes {
  const factory _ResponseCtcTradeByPaymentListRes(
      {@JsonKey(defaultValue: []) final List<TradeCtcTradeByPaymentFon>? list,
      required final int page,
      required final int pageSize,
      required final int total,
      required final double
          totalAmount}) = _$ResponseCtcTradeByPaymentListResImpl;

  factory _ResponseCtcTradeByPaymentListRes.fromJson(
          Map<String, dynamic> json) =
      _$ResponseCtcTradeByPaymentListResImpl.fromJson;

  @override
  @JsonKey(defaultValue: [])
  List<TradeCtcTradeByPaymentFon>? get list;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get total;
  @override
  double get totalAmount;
  @override
  @JsonKey(ignore: true)
  _$$ResponseCtcTradeByPaymentListResImplCopyWith<
          _$ResponseCtcTradeByPaymentListResImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TradeCtcTradeByPaymentFon _$TradeCtcTradeByPaymentFonFromJson(
    Map<String, dynamic> json) {
  return _TradeCtcTradeByPaymentFon.fromJson(json);
}

/// @nodoc
mixin _$TradeCtcTradeByPaymentFon {
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  String get createdAt => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get orderSn => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get payMethod => throw _privateConstructorUsedError;
  int get receiveOrPay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeCtcTradeByPaymentFonCopyWith<TradeCtcTradeByPaymentFon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeCtcTradeByPaymentFonCopyWith<$Res> {
  factory $TradeCtcTradeByPaymentFonCopyWith(TradeCtcTradeByPaymentFon value,
          $Res Function(TradeCtcTradeByPaymentFon) then) =
      _$TradeCtcTradeByPaymentFonCopyWithImpl<$Res, TradeCtcTradeByPaymentFon>;
  @useResult
  $Res call(
      {double amount,
      @JsonKey(name: 'CreatedAt') String createdAt,
      int id,
      String orderSn,
      String name,
      int payMethod,
      int receiveOrPay});
}

/// @nodoc
class _$TradeCtcTradeByPaymentFonCopyWithImpl<$Res,
        $Val extends TradeCtcTradeByPaymentFon>
    implements $TradeCtcTradeByPaymentFonCopyWith<$Res> {
  _$TradeCtcTradeByPaymentFonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? createdAt = null,
    Object? id = null,
    Object? orderSn = null,
    Object? name = null,
    Object? payMethod = null,
    Object? receiveOrPay = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderSn: null == orderSn
          ? _value.orderSn
          : orderSn // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
      receiveOrPay: null == receiveOrPay
          ? _value.receiveOrPay
          : receiveOrPay // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeCtcTradeByPaymentFonImplCopyWith<$Res>
    implements $TradeCtcTradeByPaymentFonCopyWith<$Res> {
  factory _$$TradeCtcTradeByPaymentFonImplCopyWith(
          _$TradeCtcTradeByPaymentFonImpl value,
          $Res Function(_$TradeCtcTradeByPaymentFonImpl) then) =
      __$$TradeCtcTradeByPaymentFonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      @JsonKey(name: 'CreatedAt') String createdAt,
      int id,
      String orderSn,
      String name,
      int payMethod,
      int receiveOrPay});
}

/// @nodoc
class __$$TradeCtcTradeByPaymentFonImplCopyWithImpl<$Res>
    extends _$TradeCtcTradeByPaymentFonCopyWithImpl<$Res,
        _$TradeCtcTradeByPaymentFonImpl>
    implements _$$TradeCtcTradeByPaymentFonImplCopyWith<$Res> {
  __$$TradeCtcTradeByPaymentFonImplCopyWithImpl(
      _$TradeCtcTradeByPaymentFonImpl _value,
      $Res Function(_$TradeCtcTradeByPaymentFonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? createdAt = null,
    Object? id = null,
    Object? orderSn = null,
    Object? name = null,
    Object? payMethod = null,
    Object? receiveOrPay = null,
  }) {
    return _then(_$TradeCtcTradeByPaymentFonImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderSn: null == orderSn
          ? _value.orderSn
          : orderSn // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
      receiveOrPay: null == receiveOrPay
          ? _value.receiveOrPay
          : receiveOrPay // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeCtcTradeByPaymentFonImpl implements _TradeCtcTradeByPaymentFon {
  const _$TradeCtcTradeByPaymentFonImpl(
      {required this.amount,
      @JsonKey(name: 'CreatedAt') required this.createdAt,
      required this.id,
      required this.orderSn,
      required this.name,
      required this.payMethod,
      required this.receiveOrPay});

  factory _$TradeCtcTradeByPaymentFonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeCtcTradeByPaymentFonImplFromJson(json);

  @override
  final double amount;
  @override
  @JsonKey(name: 'CreatedAt')
  final String createdAt;
  @override
  final int id;
  @override
  final String orderSn;
  @override
  final String name;
  @override
  final int payMethod;
  @override
  final int receiveOrPay;

  @override
  String toString() {
    return 'TradeCtcTradeByPaymentFon(amount: $amount, createdAt: $createdAt, id: $id, orderSn: $orderSn, name: $name, payMethod: $payMethod, receiveOrPay: $receiveOrPay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeCtcTradeByPaymentFonImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderSn, orderSn) || other.orderSn == orderSn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.payMethod, payMethod) ||
                other.payMethod == payMethod) &&
            (identical(other.receiveOrPay, receiveOrPay) ||
                other.receiveOrPay == receiveOrPay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, createdAt, id, orderSn,
      name, payMethod, receiveOrPay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeCtcTradeByPaymentFonImplCopyWith<_$TradeCtcTradeByPaymentFonImpl>
      get copyWith => __$$TradeCtcTradeByPaymentFonImplCopyWithImpl<
          _$TradeCtcTradeByPaymentFonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeCtcTradeByPaymentFonImplToJson(
      this,
    );
  }
}

abstract class _TradeCtcTradeByPaymentFon implements TradeCtcTradeByPaymentFon {
  const factory _TradeCtcTradeByPaymentFon(
      {required final double amount,
      @JsonKey(name: 'CreatedAt') required final String createdAt,
      required final int id,
      required final String orderSn,
      required final String name,
      required final int payMethod,
      required final int receiveOrPay}) = _$TradeCtcTradeByPaymentFonImpl;

  factory _TradeCtcTradeByPaymentFon.fromJson(Map<String, dynamic> json) =
      _$TradeCtcTradeByPaymentFonImpl.fromJson;

  @override
  double get amount;
  @override
  @JsonKey(name: 'CreatedAt')
  String get createdAt;
  @override
  int get id;
  @override
  String get orderSn;
  @override
  String get name;
  @override
  int get payMethod;
  @override
  int get receiveOrPay;
  @override
  @JsonKey(ignore: true)
  _$$TradeCtcTradeByPaymentFonImplCopyWith<_$TradeCtcTradeByPaymentFonImpl>
      get copyWith => throw _privateConstructorUsedError;
}
