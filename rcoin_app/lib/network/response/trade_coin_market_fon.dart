import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_coin_market_fon.freezed.dart';
part 'trade_coin_market_fon.g.dart';


///trade.CoinMarketFon
@freezed
class TradeCoinMarketFon with _$TradeCoinMarketFon {
  const factory TradeCoinMarketFon({
    String? coinName,
    String? img,
    String? createdAt,
    int? id,
    double? price,
    int? sort,
    bool? state,
    String? symbol,
    double? ud,
    String? updatedAt,
  }) = _TradeCoinMarketFon;

  factory TradeCoinMarketFon.fromJson(Map<String, dynamic> json) => _$TradeCoinMarketFonFromJson(json);
}