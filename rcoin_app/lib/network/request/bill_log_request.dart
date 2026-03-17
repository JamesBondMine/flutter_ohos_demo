// To parse this JSON data, do
//
//     final billLogRequest = billLogRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'bill_log_request.freezed.dart';
part 'bill_log_request.g.dart';


///server_model_fontend_request.CoinBillsSearch
@freezed
class BillLogRequest with _$BillLogRequest {
  const factory BillLogRequest({
    int? billTypeId,
    int? coinId,
    String? endCreatedAt,
    int? page,
    int? pageSize,
    String? startCreatedAt,
    int? type,
  }) = _BillLogRequest;

  factory BillLogRequest.fromJson(Map<String, dynamic> json) => _$BillLogRequestFromJson(json);
}