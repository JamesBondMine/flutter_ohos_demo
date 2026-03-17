// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../../models/trade_user_commission.dart';

part 'set_commission_request.freezed.dart';
part 'set_commission_request.g.dart';


///request.SetUserCommissionNew
@freezed
class SetCommissionRequest with _$SetCommissionRequest {
  const factory SetCommissionRequest({
    List<TradeUserCommission>? commission,
    int? userId,
  }) = _SetCommissionRequest;

  factory SetCommissionRequest.fromJson(Map<String, dynamic> json) => _$SetCommissionRequestFromJson(json);
}
