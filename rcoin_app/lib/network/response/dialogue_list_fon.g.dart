// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_list_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DialogueListFonImpl _$$DialogueListFonImplFromJson(
        Map<String, dynamic> json) =>
    _$DialogueListFonImpl(
      createdAt: json['createdAt'] as String?,
      headerImg: json['headerImg'] as String?,
      id: (json['id'] as num?)?.toInt(),
      maxMessageId: (json['maxMessageId'] as num?)?.toInt(),
      name: json['name'] as String?,
      newMessage: json['newMessage'] == null
          ? null
          : DialogueMessageListFon.fromJson(
              json['newMessage'] as Map<String, dynamic>),
      nickName: json['nickName'] as String?,
      targetHeaderImg: json['targetHeaderImg'] as String?,
      targetId: (json['targetId'] as num?)?.toInt(),
      targetNickName: json['targetNickName'] as String?,
      thumb: json['thumb'] as String?,
      unread: (json['unread'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DialogueListFonImplToJson(
        _$DialogueListFonImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'headerImg': instance.headerImg,
      'id': instance.id,
      'maxMessageId': instance.maxMessageId,
      'name': instance.name,
      'newMessage': instance.newMessage,
      'nickName': instance.nickName,
      'targetHeaderImg': instance.targetHeaderImg,
      'targetId': instance.targetId,
      'targetNickName': instance.targetNickName,
      'thumb': instance.thumb,
      'unread': instance.unread,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
