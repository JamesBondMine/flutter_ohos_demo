// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_trades_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderTradesRequest _$OrderTradesRequestFromJson(Map<String, dynamic> json) {
  return _OrderTradesRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderTradesRequest {
  int? get id => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderTradesRequestCopyWith<OrderTradesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTradesRequestCopyWith<$Res> {
  factory $OrderTradesRequestCopyWith(
          OrderTradesRequest value, $Res Function(OrderTradesRequest) then) =
      _$OrderTradesRequestCopyWithImpl<$Res, OrderTradesRequest>;
  @useResult
  $Res call({int? id, int? page, int? pageSize});
}

/// @nodoc
class _$OrderTradesRequestCopyWithImpl<$Res, $Val extends OrderTradesRequest>
    implements $OrderTradesRequestCopyWith<$Res> {
  _$OrderTradesRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderTradesRequestImplCopyWith<$Res>
    implements $OrderTradesRequestCopyWith<$Res> {
  factory _$$OrderTradesRequestImplCopyWith(_$OrderTradesRequestImpl value,
          $Res Function(_$OrderTradesRequestImpl) then) =
      __$$OrderTradesRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? page, int? pageSize});
}

/// @nodoc
class __$$OrderTradesRequestImplCopyWithImpl<$Res>
    extends _$OrderTradesRequestCopyWithImpl<$Res, _$OrderTradesRequestImpl>
    implements _$$OrderTradesRequestImplCopyWith<$Res> {
  __$$OrderTradesRequestImplCopyWithImpl(_$OrderTradesRequestImpl _value,
      $Res Function(_$OrderTradesRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$OrderTradesRequestImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderTradesRequestImpl
    with DiagnosticableTreeMixin
    implements _OrderTradesRequest {
  const _$OrderTradesRequestImpl({this.id, this.page, this.pageSize});

  factory _$OrderTradesRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTradesRequestImplFromJson(json);

  @override
  final int? id;
  @override
  final int? page;
  @override
  final int? pageSize;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderTradesRequest(id: $id, page: $page, pageSize: $pageSize)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderTradesRequest'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTradesRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, page, pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTradesRequestImplCopyWith<_$OrderTradesRequestImpl> get copyWith =>
      __$$OrderTradesRequestImplCopyWithImpl<_$OrderTradesRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTradesRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderTradesRequest implements OrderTradesRequest {
  const factory _OrderTradesRequest(
      {final int? id,
      final int? page,
      final int? pageSize}) = _$OrderTradesRequestImpl;

  factory _OrderTradesRequest.fromJson(Map<String, dynamic> json) =
      _$OrderTradesRequestImpl.fromJson;

  @override
  int? get id;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$OrderTradesRequestImplCopyWith<_$OrderTradesRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
