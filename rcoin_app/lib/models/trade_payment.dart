// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_payment.freezed.dart';
part 'trade_payment.g.dart';

///trade.PaymentChannel
@freezed
class TradePayment with _$TradePayment {
  const factory TradePayment({
    String? channel,
    String? createdAt,
    double? feeRate,
    String? icon,
    @JsonKey(name: 'ID')
    int? id,
    double? maxAmount,
    double? minAmount,
    String? name,
    double? payFeeRate,
    int? sort,
    bool? state,
    String? updatedAt,
  }) = _TradePayment;

  factory TradePayment.fromJson(Map<String, dynamic> json) => _$TradePaymentFromJson(json);
}
