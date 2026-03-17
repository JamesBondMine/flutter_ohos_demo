import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_commission.freezed.dart';

part 'trade_commission.g.dart';

///trade.FonPaymentChannel
@freezed
class TradeCommission with _$TradeCommission {
  const factory TradeCommission({
    double? commissionRate,
    String? icon,
    int? id,
    double? minAmount,
    double? maxAmount,
    double? minCommissionRate,
    double? minPayCommissionRate,
    String? name,
    double? payCommissionRate,
  }) = _TradeCommission;

  factory TradeCommission.fromJson(Map<String, dynamic> json) =>
      _$TradeCommissionFromJson(json);
}
