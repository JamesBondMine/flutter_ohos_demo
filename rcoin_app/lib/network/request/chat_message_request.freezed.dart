// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessageRequest _$ChatMessageRequestFromJson(Map<String, dynamic> json) {
  return _ChatMessageRequest.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageRequest {
  String? get content => throw _privateConstructorUsedError;
  int? get dialogueId => throw _privateConstructorUsedError;
  int? get receiveId => throw _privateConstructorUsedError;
  String? get thumb => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  int? get videoDuration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageRequestCopyWith<ChatMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageRequestCopyWith<$Res> {
  factory $ChatMessageRequestCopyWith(
          ChatMessageRequest value, $Res Function(ChatMessageRequest) then) =
      _$ChatMessageRequestCopyWithImpl<$Res, ChatMessageRequest>;
  @useResult
  $Res call(
      {String? content,
      int? dialogueId,
      int? receiveId,
      String? thumb,
      int? type,
      int? videoDuration});
}

/// @nodoc
class _$ChatMessageRequestCopyWithImpl<$Res, $Val extends ChatMessageRequest>
    implements $ChatMessageRequestCopyWith<$Res> {
  _$ChatMessageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? dialogueId = freezed,
    Object? receiveId = freezed,
    Object? thumb = freezed,
    Object? type = freezed,
    Object? videoDuration = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      dialogueId: freezed == dialogueId
          ? _value.dialogueId
          : dialogueId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiveId: freezed == receiveId
          ? _value.receiveId
          : receiveId // ignore: cast_nullable_to_non_nullable
              as int?,
      thumb: freezed == thumb
          ? _value.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      videoDuration: freezed == videoDuration
          ? _value.videoDuration
          : videoDuration // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageRequestImplCopyWith<$Res>
    implements $ChatMessageRequestCopyWith<$Res> {
  factory _$$ChatMessageRequestImplCopyWith(_$ChatMessageRequestImpl value,
          $Res Function(_$ChatMessageRequestImpl) then) =
      __$$ChatMessageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? content,
      int? dialogueId,
      int? receiveId,
      String? thumb,
      int? type,
      int? videoDuration});
}

/// @nodoc
class __$$ChatMessageRequestImplCopyWithImpl<$Res>
    extends _$ChatMessageRequestCopyWithImpl<$Res, _$ChatMessageRequestImpl>
    implements _$$ChatMessageRequestImplCopyWith<$Res> {
  __$$ChatMessageRequestImplCopyWithImpl(_$ChatMessageRequestImpl _value,
      $Res Function(_$ChatMessageRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? dialogueId = freezed,
    Object? receiveId = freezed,
    Object? thumb = freezed,
    Object? type = freezed,
    Object? videoDuration = freezed,
  }) {
    return _then(_$ChatMessageRequestImpl(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      dialogueId: freezed == dialogueId
          ? _value.dialogueId
          : dialogueId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiveId: freezed == receiveId
          ? _value.receiveId
          : receiveId // ignore: cast_nullable_to_non_nullable
              as int?,
      thumb: freezed == thumb
          ? _value.thumb
          : thumb // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      videoDuration: freezed == videoDuration
          ? _value.videoDuration
          : videoDuration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageRequestImpl implements _ChatMessageRequest {
  const _$ChatMessageRequestImpl(
      {this.content,
      this.dialogueId,
      this.receiveId,
      this.thumb,
      this.type,
      this.videoDuration});

  factory _$ChatMessageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageRequestImplFromJson(json);

  @override
  final String? content;
  @override
  final int? dialogueId;
  @override
  final int? receiveId;
  @override
  final String? thumb;
  @override
  final int? type;
  @override
  final int? videoDuration;

  @override
  String toString() {
    return 'ChatMessageRequest(content: $content, dialogueId: $dialogueId, receiveId: $receiveId, thumb: $thumb, type: $type, videoDuration: $videoDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageRequestImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dialogueId, dialogueId) ||
                other.dialogueId == dialogueId) &&
            (identical(other.receiveId, receiveId) ||
                other.receiveId == receiveId) &&
            (identical(other.thumb, thumb) || other.thumb == thumb) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.videoDuration, videoDuration) ||
                other.videoDuration == videoDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, content, dialogueId, receiveId, thumb, type, videoDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageRequestImplCopyWith<_$ChatMessageRequestImpl> get copyWith =>
      __$$ChatMessageRequestImplCopyWithImpl<_$ChatMessageRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageRequestImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageRequest implements ChatMessageRequest {
  const factory _ChatMessageRequest(
      {final String? content,
      final int? dialogueId,
      final int? receiveId,
      final String? thumb,
      final int? type,
      final int? videoDuration}) = _$ChatMessageRequestImpl;

  factory _ChatMessageRequest.fromJson(Map<String, dynamic> json) =
      _$ChatMessageRequestImpl.fromJson;

  @override
  String? get content;
  @override
  int? get dialogueId;
  @override
  int? get receiveId;
  @override
  String? get thumb;
  @override
  int? get type;
  @override
  int? get videoDuration;
  @override
  @JsonKey(ignore: true)
  _$$ChatMessageRequestImplCopyWith<_$ChatMessageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
