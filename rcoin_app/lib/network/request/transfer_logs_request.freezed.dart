// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_logs_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferLogsRequest _$TransferLogsRequestFromJson(Map<String, dynamic> json) {
  return _TransferLogsRequest.fromJson(json);
}

/// @nodoc
mixin _$TransferLogsRequest {
  int? get coinId => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferLogsRequestCopyWith<TransferLogsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferLogsRequestCopyWith<$Res> {
  factory $TransferLogsRequestCopyWith(
          TransferLogsRequest value, $Res Function(TransferLogsRequest) then) =
      _$TransferLogsRequestCopyWithImpl<$Res, TransferLogsRequest>;
  @useResult
  $Res call({int? coinId, int? page, int? pageSize, int? type});
}

/// @nodoc
class _$TransferLogsRequestCopyWithImpl<$Res, $Val extends TransferLogsRequest>
    implements $TransferLogsRequestCopyWith<$Res> {
  _$TransferLogsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinId = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferLogsRequestImplCopyWith<$Res>
    implements $TransferLogsRequestCopyWith<$Res> {
  factory _$$TransferLogsRequestImplCopyWith(_$TransferLogsRequestImpl value,
          $Res Function(_$TransferLogsRequestImpl) then) =
      __$$TransferLogsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? coinId, int? page, int? pageSize, int? type});
}

/// @nodoc
class __$$TransferLogsRequestImplCopyWithImpl<$Res>
    extends _$TransferLogsRequestCopyWithImpl<$Res, _$TransferLogsRequestImpl>
    implements _$$TransferLogsRequestImplCopyWith<$Res> {
  __$$TransferLogsRequestImplCopyWithImpl(_$TransferLogsRequestImpl _value,
      $Res Function(_$TransferLogsRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coinId = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? type = freezed,
  }) {
    return _then(_$TransferLogsRequestImpl(
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
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
class _$TransferLogsRequestImpl implements _TransferLogsRequest {
  const _$TransferLogsRequestImpl(
      {this.coinId, this.page, this.pageSize, this.type});

  factory _$TransferLogsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferLogsRequestImplFromJson(json);

  @override
  final int? coinId;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? type;

  @override
  String toString() {
    return 'TransferLogsRequest(coinId: $coinId, page: $page, pageSize: $pageSize, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferLogsRequestImpl &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, coinId, page, pageSize, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferLogsRequestImplCopyWith<_$TransferLogsRequestImpl> get copyWith =>
      __$$TransferLogsRequestImplCopyWithImpl<_$TransferLogsRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferLogsRequestImplToJson(
      this,
    );
  }
}

abstract class _TransferLogsRequest implements TransferLogsRequest {
  const factory _TransferLogsRequest(
      {final int? coinId,
      final int? page,
      final int? pageSize,
      final int? type}) = _$TransferLogsRequestImpl;

  factory _TransferLogsRequest.fromJson(Map<String, dynamic> json) =
      _$TransferLogsRequestImpl.fromJson;

  @override
  int? get coinId;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  int? get type;
  @override
  @JsonKey(ignore: true)
  _$$TransferLogsRequestImplCopyWith<_$TransferLogsRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
