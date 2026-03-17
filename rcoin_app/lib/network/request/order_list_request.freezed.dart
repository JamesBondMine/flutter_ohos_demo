// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderListRequest _$OrderListRequestFromJson(Map<String, dynamic> json) {
  return _OrderListRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderListRequest {
  int? get amount => throw _privateConstructorUsedError;
  String? get keyword => throw _privateConstructorUsedError;
  int? get maxAmount => throw _privateConstructorUsedError;
  int? get minAmount => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  List<int>? get paymentMethod => throw _privateConstructorUsedError;
  int? get cooperated => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderListRequestCopyWith<OrderListRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderListRequestCopyWith<$Res> {
  factory $OrderListRequestCopyWith(
          OrderListRequest value, $Res Function(OrderListRequest) then) =
      _$OrderListRequestCopyWithImpl<$Res, OrderListRequest>;
  @useResult
  $Res call(
      {int? amount,
      String? keyword,
      int? maxAmount,
      int? minAmount,
      int page,
      int pageSize,
      List<int>? paymentMethod,
      int? cooperated,
      int type});
}

/// @nodoc
class _$OrderListRequestCopyWithImpl<$Res, $Val extends OrderListRequest>
    implements $OrderListRequestCopyWith<$Res> {
  _$OrderListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? keyword = freezed,
    Object? maxAmount = freezed,
    Object? minAmount = freezed,
    Object? page = null,
    Object? pageSize = null,
    Object? paymentMethod = freezed,
    Object? cooperated = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      keyword: freezed == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      cooperated: freezed == cooperated
          ? _value.cooperated
          : cooperated // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderListRequestImplCopyWith<$Res>
    implements $OrderListRequestCopyWith<$Res> {
  factory _$$OrderListRequestImplCopyWith(_$OrderListRequestImpl value,
          $Res Function(_$OrderListRequestImpl) then) =
      __$$OrderListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? keyword,
      int? maxAmount,
      int? minAmount,
      int page,
      int pageSize,
      List<int>? paymentMethod,
      int? cooperated,
      int type});
}

/// @nodoc
class __$$OrderListRequestImplCopyWithImpl<$Res>
    extends _$OrderListRequestCopyWithImpl<$Res, _$OrderListRequestImpl>
    implements _$$OrderListRequestImplCopyWith<$Res> {
  __$$OrderListRequestImplCopyWithImpl(_$OrderListRequestImpl _value,
      $Res Function(_$OrderListRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? keyword = freezed,
    Object? maxAmount = freezed,
    Object? minAmount = freezed,
    Object? page = null,
    Object? pageSize = null,
    Object? paymentMethod = freezed,
    Object? cooperated = freezed,
    Object? type = null,
  }) {
    return _then(_$OrderListRequestImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      keyword: freezed == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: freezed == paymentMethod
          ? _value._paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      cooperated: freezed == cooperated
          ? _value.cooperated
          : cooperated // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderListRequestImpl
    with DiagnosticableTreeMixin
    implements _OrderListRequest {
  const _$OrderListRequestImpl(
      {this.amount,
      this.keyword,
      this.maxAmount,
      this.minAmount,
      required this.page,
      required this.pageSize,
      final List<int>? paymentMethod,
      this.cooperated,
      required this.type})
      : _paymentMethod = paymentMethod;

  factory _$OrderListRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderListRequestImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? keyword;
  @override
  final int? maxAmount;
  @override
  final int? minAmount;
  @override
  final int page;
  @override
  final int pageSize;
  final List<int>? _paymentMethod;
  @override
  List<int>? get paymentMethod {
    final value = _paymentMethod;
    if (value == null) return null;
    if (_paymentMethod is EqualUnmodifiableListView) return _paymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? cooperated;
  @override
  final int type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderListRequest(amount: $amount, keyword: $keyword, maxAmount: $maxAmount, minAmount: $minAmount, page: $page, pageSize: $pageSize, paymentMethod: $paymentMethod, cooperated: $cooperated, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderListRequest'))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('keyword', keyword))
      ..add(DiagnosticsProperty('maxAmount', maxAmount))
      ..add(DiagnosticsProperty('minAmount', minAmount))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('cooperated', cooperated))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderListRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethod, _paymentMethod) &&
            (identical(other.cooperated, cooperated) ||
                other.cooperated == cooperated) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      amount,
      keyword,
      maxAmount,
      minAmount,
      page,
      pageSize,
      const DeepCollectionEquality().hash(_paymentMethod),
      cooperated,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderListRequestImplCopyWith<_$OrderListRequestImpl> get copyWith =>
      __$$OrderListRequestImplCopyWithImpl<_$OrderListRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderListRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderListRequest implements OrderListRequest {
  const factory _OrderListRequest(
      {final int? amount,
      final String? keyword,
      final int? maxAmount,
      final int? minAmount,
      required final int page,
      required final int pageSize,
      final List<int>? paymentMethod,
      final int? cooperated,
      required final int type}) = _$OrderListRequestImpl;

  factory _OrderListRequest.fromJson(Map<String, dynamic> json) =
      _$OrderListRequestImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get keyword;
  @override
  int? get maxAmount;
  @override
  int? get minAmount;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  List<int>? get paymentMethod;
  @override
  int? get cooperated;
  @override
  int get type;
  @override
  @JsonKey(ignore: true)
  _$$OrderListRequestImplCopyWith<_$OrderListRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
