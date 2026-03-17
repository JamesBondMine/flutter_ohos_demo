import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'coin.freezed.dart';
part 'coin.g.dart';


///trade.Coin
@freezed
class Coin with _$Coin {
  const factory Coin({
    String? createdAt,
    String? description,
    String? enName,
    String? ext,
    String? fullName,
    int? id,
    bool? isAutoTrans,
    bool? isAutoWithdraw,
    bool? isRecharge,
    bool? isTrans,
    bool? isWithdraw,
    double? maxWithdraw,
    double? maxWithdrawFee,
    double? minRecharge,
    double? minWithdraw,
    double? minWithdrawFee,
    String? name,
    double? price,
    bool? priceType,
    int? protocol,
    String? rechargeInfo,
    int? sort,
    bool? state,
    double? transFee,
    bool? transFeeType,
    String? transInfo,
    double? transMax,
    double? transMaxFee,
    double? transMin,
    double? transMinFee,
    double? transRate,
    String? updatedAt,
    double? withdrawFee,
    bool? withdrawFeeType,
    String? withdrawInfo,
    double? withdrawRate,
  }) = _Coin;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}