import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'appeal_request.freezed.dart';
part 'appeal_request.g.dart';


///request.CtcAppealApply
@freezed
class AppealRequest with _$AppealRequest {
  const factory AppealRequest({
    String? content,
    String? imgs,
    int? reasonId,
    int? tradeId,
    String? videoUrls,
  }) = _AppealRequest;

  factory AppealRequest.fromJson(Map<String, dynamic> json) => _$AppealRequestFromJson(json);
}