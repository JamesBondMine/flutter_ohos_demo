// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'withdraw_fee_res.freezed.dart';
part 'withdraw_fee_res.g.dart';



///response.CoinWithdrawFeeRes
@freezed
class WithdrawFeeRes with _$WithdrawFeeRes {
  const factory WithdrawFeeRes({
    double? fee,
    double? USDTAmount,
  }) = _WithdrawFeeRes;

  factory WithdrawFeeRes.fromJson(Map<String, dynamic> json) => _$WithdrawFeeResFromJson(json);
}
