// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_by_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeByPaymentRequest _$TradeByPaymentRequestFromJson(
    Map<String, dynamic> json) {
  return _TradeByPaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$TradeByPaymentRequest {
  String get day => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get payMethod => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeByPaymentRequestCopyWith<TradeByPaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeByPaymentRequestCopyWith<$Res> {
  factory $TradeByPaymentRequestCopyWith(TradeByPaymentRequest value,
          $Res Function(TradeByPaymentRequest) then) =
      _$TradeByPaymentRequestCopyWithImpl<$Res, TradeByPaymentRequest>;
  @useResult
  $Res call({String day, int page, int pageSize, int payMethod});
}

/// @nodoc
class _$TradeByPaymentRequestCopyWithImpl<$Res,
        $Val extends TradeByPaymentRequest>
    implements $TradeByPaymentRequestCopyWith<$Res> {
  _$TradeByPaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? page = null,
    Object? pageSize = null,
    Object? payMethod = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeByPaymentRequestImplCopyWith<$Res>
    implements $TradeByPaymentRequestCopyWith<$Res> {
  factory _$$TradeByPaymentRequestImplCopyWith(
          _$TradeByPaymentRequestImpl value,
          $Res Function(_$TradeByPaymentRequestImpl) then) =
      __$$TradeByPaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, int page, int pageSize, int payMethod});
}

/// @nodoc
class __$$TradeByPaymentRequestImplCopyWithImpl<$Res>
    extends _$TradeByPaymentRequestCopyWithImpl<$Res,
        _$TradeByPaymentRequestImpl>
    implements _$$TradeByPaymentRequestImplCopyWith<$Res> {
  __$$TradeByPaymentRequestImplCopyWithImpl(_$TradeByPaymentRequestImpl _value,
      $Res Function(_$TradeByPaymentRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? page = null,
    Object? pageSize = null,
    Object? payMethod = null,
  }) {
    return _then(_$TradeByPaymentRequestImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeByPaymentRequestImpl implements _TradeByPaymentRequest {
  const _$TradeByPaymentRequestImpl(
      {required this.day,
      required this.page,
      required this.pageSize,
      required this.payMethod});

  factory _$TradeByPaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeByPaymentRequestImplFromJson(json);

  @override
  final String day;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int payMethod;

  @override
  String toString() {
    return 'TradeByPaymentRequest(day: $day, page: $page, pageSize: $pageSize, payMethod: $payMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeByPaymentRequestImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.payMethod, payMethod) ||
                other.payMethod == payMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, page, pageSize, payMethod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeByPaymentRequestImplCopyWith<_$TradeByPaymentRequestImpl>
      get copyWith => __$$TradeByPaymentRequestImplCopyWithImpl<
          _$TradeByPaymentRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeByPaymentRequestImplToJson(
      this,
    );
  }
}

abstract class _TradeByPaymentRequest implements TradeByPaymentRequest {
  const factory _TradeByPaymentRequest(
      {required final String day,
      required final int page,
      required final int pageSize,
      required final int payMethod}) = _$TradeByPaymentRequestImpl;

  factory _TradeByPaymentRequest.fromJson(Map<String, dynamic> json) =
      _$TradeByPaymentRequestImpl.fromJson;

  @override
  String get day;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get payMethod;
  @override
  @JsonKey(ignore: true)
  _$$TradeByPaymentRequestImplCopyWith<_$TradeByPaymentRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
