// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_history_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageHistoryRequest _$MessageHistoryRequestFromJson(
    Map<String, dynamic> json) {
  return _MessageHistoryRequest.fromJson(json);
}

/// @nodoc
mixin _$MessageHistoryRequest {
  int? get id => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  int? get targetId => throw _privateConstructorUsedError;
  int? get minId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageHistoryRequestCopyWith<MessageHistoryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageHistoryRequestCopyWith<$Res> {
  factory $MessageHistoryRequestCopyWith(MessageHistoryRequest value,
          $Res Function(MessageHistoryRequest) then) =
      _$MessageHistoryRequestCopyWithImpl<$Res, MessageHistoryRequest>;
  @useResult
  $Res call({int? id, int? page, int? pageSize, int? targetId, int? minId});
}

/// @nodoc
class _$MessageHistoryRequestCopyWithImpl<$Res,
        $Val extends MessageHistoryRequest>
    implements $MessageHistoryRequestCopyWith<$Res> {
  _$MessageHistoryRequestCopyWithImpl(this._value, this._then);

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
    Object? targetId = freezed,
    Object? minId = freezed,
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
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      minId: freezed == minId
          ? _value.minId
          : minId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageHistoryRequestImplCopyWith<$Res>
    implements $MessageHistoryRequestCopyWith<$Res> {
  factory _$$MessageHistoryRequestImplCopyWith(
          _$MessageHistoryRequestImpl value,
          $Res Function(_$MessageHistoryRequestImpl) then) =
      __$$MessageHistoryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? page, int? pageSize, int? targetId, int? minId});
}

/// @nodoc
class __$$MessageHistoryRequestImplCopyWithImpl<$Res>
    extends _$MessageHistoryRequestCopyWithImpl<$Res,
        _$MessageHistoryRequestImpl>
    implements _$$MessageHistoryRequestImplCopyWith<$Res> {
  __$$MessageHistoryRequestImplCopyWithImpl(_$MessageHistoryRequestImpl _value,
      $Res Function(_$MessageHistoryRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
    Object? targetId = freezed,
    Object? minId = freezed,
  }) {
    return _then(_$MessageHistoryRequestImpl(
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
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as int?,
      minId: freezed == minId
          ? _value.minId
          : minId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageHistoryRequestImpl implements _MessageHistoryRequest {
  const _$MessageHistoryRequestImpl(
      {this.id, this.page, this.pageSize, this.targetId, this.minId});

  factory _$MessageHistoryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageHistoryRequestImplFromJson(json);

  @override
  final int? id;
  @override
  final int? page;
  @override
  final int? pageSize;
  @override
  final int? targetId;
  @override
  final int? minId;

  @override
  String toString() {
    return 'MessageHistoryRequest(id: $id, page: $page, pageSize: $pageSize, targetId: $targetId, minId: $minId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageHistoryRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.minId, minId) || other.minId == minId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, page, pageSize, targetId, minId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageHistoryRequestImplCopyWith<_$MessageHistoryRequestImpl>
      get copyWith => __$$MessageHistoryRequestImplCopyWithImpl<
          _$MessageHistoryRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageHistoryRequestImplToJson(
      this,
    );
  }
}

abstract class _MessageHistoryRequest implements MessageHistoryRequest {
  const factory _MessageHistoryRequest(
      {final int? id,
      final int? page,
      final int? pageSize,
      final int? targetId,
      final int? minId}) = _$MessageHistoryRequestImpl;

  factory _MessageHistoryRequest.fromJson(Map<String, dynamic> json) =
      _$MessageHistoryRequestImpl.fromJson;

  @override
  int? get id;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  int? get targetId;
  @override
  int? get minId;
  @override
  @JsonKey(ignore: true)
  _$$MessageHistoryRequestImplCopyWith<_$MessageHistoryRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
