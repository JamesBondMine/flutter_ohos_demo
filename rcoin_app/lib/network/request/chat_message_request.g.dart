// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageRequestImpl _$$ChatMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageRequestImpl(
      content: json['content'] as String?,
      dialogueId: (json['dialogueId'] as num?)?.toInt(),
      receiveId: (json['receiveId'] as num?)?.toInt(),
      thumb: json['thumb'] as String?,
      type: (json['type'] as num?)?.toInt(),
      videoDuration: (json['videoDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ChatMessageRequestImplToJson(
        _$ChatMessageRequestImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'dialogueId': instance.dialogueId,
      'receiveId': instance.receiveId,
      'thumb': instance.thumb,
      'type': instance.type,
      'videoDuration': instance.videoDuration,
    };
