import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_by_payment.freezed.dart';

part 'trade_by_payment.g.dart';

///response.CtcTradeByPaymentListRes
@freezed
class ResponseCtcTradeByPaymentListRes with _$ResponseCtcTradeByPaymentListRes {
  const factory ResponseCtcTradeByPaymentListRes({
   @JsonKey(defaultValue: []) List<TradeCtcTradeByPaymentFon>? list,
    required int page,
    required int pageSize,
    required int total,
    required double totalAmount,
  }) = _ResponseCtcTradeByPaymentListRes;

  factory ResponseCtcTradeByPaymentListRes.fromJson(
          Map<String, dynamic> json) =>
      _$ResponseCtcTradeByPaymentListResFromJson(json);
}

///trade.CtcTradeByPaymentFon
@freezed
class TradeCtcTradeByPaymentFon with _$TradeCtcTradeByPaymentFon {
  const factory TradeCtcTradeByPaymentFon({
    required double amount,
    @JsonKey(name: 'CreatedAt') required String createdAt,
    required int id,
    required String orderSn,
    required String name,
    required int payMethod,
    required int receiveOrPay,
  }) = _TradeCtcTradeByPaymentFon;

  factory TradeCtcTradeByPaymentFon.fromJson(Map<String, dynamic> json) =>
      _$TradeCtcTradeByPaymentFonFromJson(json);
}
