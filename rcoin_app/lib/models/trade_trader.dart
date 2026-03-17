import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_trader.freezed.dart';

part 'trade_trader.g.dart';

@freezed

class TradeTrader with _$TradeTrader {
  const factory TradeTrader({
    String? email,
    String? headerImg,
    String? nickName,
  }) = _TradeTrader;

  factory TradeTrader.fromJson(Map<String, dynamic> json) => _$TradeTraderFromJson(json);
}