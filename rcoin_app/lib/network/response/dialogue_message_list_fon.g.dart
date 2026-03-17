// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_message_list_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DialogueMessageListFonImpl _$$DialogueMessageListFonImplFromJson(
        Map<String, dynamic> json) =>
    _$DialogueMessageListFonImpl(
      content: json['content'] as String?,
      CreatedAt: json['CreatedAt'] as String?,
      dialogueId: (json['dialogueId'] as num?)?.toInt(),
      headerImg: json['headerImg'] as String?,
      id: (json['id'] as num?)?.toInt(),
      nickName: json['nickName'] as String?,
      thumb: json['thumb'] as String?,
      type: (json['type'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      videoDuration: (json['videoDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DialogueMessageListFonImplToJson(
        _$DialogueMessageListFonImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'CreatedAt': instance.CreatedAt,
      'dialogueId': instance.dialogueId,
      'headerImg': instance.headerImg,
      'id': instance.id,
      'nickName': instance.nickName,
      'thumb': instance.thumb,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'videoDuration': instance.videoDuration,
    };
