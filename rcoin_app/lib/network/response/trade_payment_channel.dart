// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_payment_channel.freezed.dart';
part 'trade_payment_channel.g.dart';

///trade.PaymentChannel
@freezed
class TradePaymentChannel with _$TradePaymentChannel {
  const factory TradePaymentChannel({
    String? channel,
    double? commissionRate,
    String? createdAt,
    double? feeRate,
    String? icon,
    @JsonKey(name: 'ID')
    int? id,
    double? maxAmount,
    double? minAmount,
    double? minCommissionRate,
    double? minPayCommissionRate,
    String? name,
    bool? pay,
    double? payCommissionRate,
    double? payFeeRate,
    int? payMethod,
    bool? receive,
    int? sort,
    bool? state,
    String? updatedAt,
  }) = _TradePaymentChannel;

  factory TradePaymentChannel.fromJson(Map<String, dynamic> json) => _$TradePaymentChannelFromJson(json);
}
