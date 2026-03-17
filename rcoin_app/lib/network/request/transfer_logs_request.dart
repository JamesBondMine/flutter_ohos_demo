import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'transfer_logs_request.freezed.dart';
part 'transfer_logs_request.g.dart';


///server_model_fontend_request.TransSearch
@freezed
class TransferLogsRequest with _$TransferLogsRequest {
  const factory TransferLogsRequest({
    int? coinId,
    int? page,
    int? pageSize,
    int? type,
  }) = _TransferLogsRequest;

  factory TransferLogsRequest.fromJson(Map<String, dynamic> json) => _$TransferLogsRequestFromJson(json);
}