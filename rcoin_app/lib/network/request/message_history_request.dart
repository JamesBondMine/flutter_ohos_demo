// To parse this JSON data, do
//
//     final messageHistoryRequest = messageHistoryRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'message_history_request.freezed.dart';
part 'message_history_request.g.dart';


///request.DialogueMessageSearch
@freezed
class MessageHistoryRequest with _$MessageHistoryRequest {
  const factory MessageHistoryRequest({
    int? id,
    int? page,
    int? pageSize,
    int? targetId,
    int? minId,
  }) = _MessageHistoryRequest;

  factory MessageHistoryRequest.fromJson(Map<String, dynamic> json) => _$MessageHistoryRequestFromJson(json);
}