// To parse this JSON data, do
//
//     final dialogueListFon = dialogueListFonFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:otc_app/services/chat_service.dart';
import 'dart:convert';

import './dialogue_message_list_fon.dart';

part 'dialogue_list_fon.freezed.dart';
part 'dialogue_list_fon.g.dart';


///trade.DialogueListFon
@freezed
class DialogueListFon with _$DialogueListFon {
  const factory DialogueListFon({
    String? createdAt,
    String? headerImg,
    int? id,
    int? maxMessageId,
    String? name,
    DialogueMessageListFon? newMessage,
    String? nickName,
    String? targetHeaderImg,
    int? targetId,
    String? targetNickName,
    String? thumb,
    int? unread,
    String? updatedAt,
    int? userId,
  }) = _DialogueListFon;

  factory DialogueListFon.fromJson(Map<String, dynamic> json) => _$DialogueListFonFromJson(json);
}

extension ToChatDialogue on DialogueListFon {
  ChatDialogue toChatDialogue() {
    return ChatDialogue(
      groupId: id!,
      groupName: name!.tr,
      groupAvatar: thumb!,
      unreadCount: RxInt(unread ?? 0),
      msg: newMessage?.toMessage(),
    );
  }

}