// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeListRequest _$TradeListRequestFromJson(Map<String, dynamic> json) {
  return _TradeListRequest.fromJson(json);
}

/// @nodoc
mixin _$TradeListRequest {
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  int? get sourceType => throw _privateConstructorUsedError; //0全部 1承兑接单
  int? get state => throw _privateConstructorUsedError; //-1全部 1进行中 2已完成 3已取消
  int? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeListRequestCopyWith<TradeListRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeListRequestCopyWith<$Res> {
  factory $TradeListRequestCopyWith(
          TradeListRequest value, $Res Function(TradeListRequest) then) =
      _$TradeListRequestCopyWithImpl<$Res, TradeListRequest>;
  @useResult
  $Res call({int? page, int? pageSize, int? sourceType, int? state, int? type});
}

/// @nodoc
class _$TradeListRequestCopyWithImpl<$Res, $Val extends TradeListRequest>
    implements $TradeListRequestCopyWith<$Res> {
  _$TradeListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? sourceType = freezed,
    Object? state = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceType: freezed == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as int?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeListRequestImplCopyWith<$Res>
    implements $TradeListRequestCopyWith<$Res> {
  factory _$$TradeListRequestImplCopyWith(_$TradeListRequestImpl value,
          $Res Function(_$TradeListRequestImpl) then) =
      __$$TradeListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? page, int? pageSize, int? sourceType, int? state, int? type});
}

/// @nodoc
class __$$TradeListRequestImplCopyWithImpl<$Res>
    extends _$TradeListRequestCopyWithImpl<$Res, _$TradeListRequestImpl>
    implements _$$TradeListRequestImplCopyWith<$Res> {
  __$$TradeListRequestImplCopyWithImpl(_$TradeListRequestImpl _value,
      $Res Function(_$TradeListRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? sourceType = freezed,
    Object? state = freezed,
    Object? type = freezed,
  }) {
    return _then(_$TradeListRequestImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceType: freezed == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as int?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeListRequestImpl
    with DiagnosticableTreeMixin
    implements _TradeListRequest {
  const _$TradeListRequestImpl(
      {this.page, this.pageSize, this.sourceType = 0, this.state, this.type});

  factory _$TradeListRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeListRequestImplFromJson(json);

  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  @JsonKey()
  final int? sourceType;
//0全部 1承兑接单
  @override
  final int? state;
//-1全部 1进行中 2已完成 3已取消
  @override
  final int? type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TradeListRequest(page: $page, pageSize: $pageSize, sourceType: $sourceType, state: $state, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TradeListRequest'))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('pageSize', pageSize))
      ..add(DiagnosticsProperty('sourceType', sourceType))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeListRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, page, pageSize, sourceType, state, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeListRequestImplCopyWith<_$TradeListRequestImpl> get copyWith =>
      __$$TradeListRequestImplCopyWithImpl<_$TradeListRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeListRequestImplToJson(
      this,
    );
  }
}

abstract class _TradeListRequest implements TradeListRequest {
  const factory _TradeListRequest(
      {final int? page,
      final int? pageSize,
      final int? sourceType,
      final int? state,
      final int? type}) = _$TradeListRequestImpl;

  factory _TradeListRequest.fromJson(Map<String, dynamic> json) =
      _$TradeListRequestImpl.fromJson;

  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  int? get sourceType;
  @override //0全部 1承兑接单
  int? get state;
  @override //-1全部 1进行中 2已完成 3已取消
  int? get type;
  @override
  @JsonKey(ignore: true)
  _$$TradeListRequestImplCopyWith<_$TradeListRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
