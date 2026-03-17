import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'chat_message_request.freezed.dart';
part 'chat_message_request.g.dart';


///request.SendMessage
@freezed
class ChatMessageRequest with _$ChatMessageRequest {
  const factory ChatMessageRequest({
    String? content,
    int? dialogueId,
    int? receiveId,
    String? thumb,
    int? type,
    int? videoDuration,
  }) = _ChatMessageRequest;

  factory ChatMessageRequest.fromJson(Map<String, dynamic> json) => _$ChatMessageRequestFromJson(json);
}