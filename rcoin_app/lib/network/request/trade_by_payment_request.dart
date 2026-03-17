// To parse this JSON data, do
//
//     final tradeByPaymentRequest = tradeByPaymentRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_by_payment_request.freezed.dart';
part 'trade_by_payment_request.g.dart';


///request.CtcTradeByPaymentSearch
@freezed
class TradeByPaymentRequest with _$TradeByPaymentRequest {
  const factory TradeByPaymentRequest({
    required String day,
    required int page,
    required int pageSize,
    required int payMethod,
  }) = _TradeByPaymentRequest;

  factory TradeByPaymentRequest.fromJson(Map<String, dynamic> json) => _$TradeByPaymentRequestFromJson(json);
}