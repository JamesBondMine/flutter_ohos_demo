// To parse this JSON data, do
//
//     final dialogueMessageListFon = dialogueMessageListFonFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:otc_app/app.dart';
import 'dart:convert';

import 'package:otc_app/app/modules/service_online/models/message.dart';

part 'dialogue_message_list_fon.freezed.dart';

part 'dialogue_message_list_fon.g.dart';

///trade.DialogueMessageListFon
@freezed
class DialogueMessageListFon with _$DialogueMessageListFon {
  const factory DialogueMessageListFon({
    String? content,
    String? CreatedAt,
    int? dialogueId,
    String? headerImg,
    int? id,
    String? nickName,
    String? thumb,
    int? type,
    String? updatedAt,
    int? userId,
    int? videoDuration,
  }) = _DialogueMessageListFon;

  factory DialogueMessageListFon.fromJson(Map<String, dynamic> json) =>
      _$DialogueMessageListFonFromJson(json);
}

extension ToMessage on DialogueMessageListFon {
  Message toMessage() {
    return Message(
      id: id!,
      dialogueId: dialogueId,
      senderAvatar: headerImg ?? '',
      senderNickname: nickName ?? '',
      senderUid: userId ?? -1,
      toUid: UserService.to.user.value.id ?? 0,
      messageType: MessageType.fromValue(type!),
      content: content!,
      duration: Duration(seconds: videoDuration ?? 0),
      thumbnail: thumb,
      createdAt: DateTime.parse(CreatedAt!),
    );
  }
}
