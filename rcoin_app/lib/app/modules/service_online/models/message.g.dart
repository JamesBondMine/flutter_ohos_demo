// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num).toInt(),
      senderAvatar: json['senderAvatar'] as String,
      senderNickname: json['senderNickname'] as String,
      senderUid: (json['senderUid'] as num).toInt(),
      toUid: (json['toUid'] as num).toInt(),
      messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
      content: json['content'] as String,
      thumbnail: json['thumbnail'] as String?,
      dialogueId: (json['dialogueId'] as num?)?.toInt(),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderAvatar': instance.senderAvatar,
      'senderNickname': instance.senderNickname,
      'senderUid': instance.senderUid,
      'toUid': instance.toUid,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'content': instance.content,
      'thumbnail': instance.thumbnail,
      'dialogueId': instance.dialogueId,
      'duration': instance.duration?.inMicroseconds,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.picture: 'picture',
  MessageType.video: 'video',
  MessageType.order: 'order',
};
