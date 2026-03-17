// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

///trade.CtcTradeStatistic
class TradeCtcTradeStatistic {
  TradeCtcTradeStatistic({
    this.ctcTradeStatistic,
    this.tradeFinishAmount,
    this.tradingAmount,
  });

  ///按支付方式统计
  List<TradeCtcTradeStatisticByPayment?>? ctcTradeStatistic;

  ///交易完成金额
  double? tradeFinishAmount;

  ///交易进行中金额
  double? tradingAmount;

  factory TradeCtcTradeStatistic.fromRawJson(String str) =>
      TradeCtcTradeStatistic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TradeCtcTradeStatistic.fromJson(Map<String, dynamic> json) =>
      TradeCtcTradeStatistic(
        ctcTradeStatistic: List<TradeCtcTradeStatisticByPayment>.from(
            json["CtcTradeStatistic"]
                .map((x) => TradeCtcTradeStatisticByPayment.fromJson(x))),
        tradeFinishAmount: json["tradeFinishAmount"].toDouble(),
        tradingAmount: json["tradingAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ctcTradeStatistic":
            List<dynamic>.from(ctcTradeStatistic?.map((x) => x?.toJson()) ?? []),
        "tradeFinishAmount": tradeFinishAmount,
        "tradingAmount": tradingAmount,
      };
}

///trade.CtcTradeStatisticByPayment
class TradeCtcTradeStatisticByPayment {
  TradeCtcTradeStatisticByPayment({
    this.name,
    this.payWay,
    this.payAmount,
    this.payMethod,
    this.receiveAmount,
    this.totalAmount,
  });

  String? name;
  int? payWay;
  ///代付金额
  double? payAmount;

  ///支付方式 1银行卡 2支付宝 3微信 4USDT
  int? payMethod;

  ///代收金额
  double? receiveAmount;

  ///总金额
  double? totalAmount;

  factory TradeCtcTradeStatisticByPayment.fromRawJson(String str) =>
      TradeCtcTradeStatisticByPayment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TradeCtcTradeStatisticByPayment.fromJson(Map<String, dynamic> json) =>
      TradeCtcTradeStatisticByPayment(
        name: json["name"].toString(),
        payWay: json["payWay"],
        payAmount: json["payAmount"].toDouble(),
        payMethod: json["payMethod"],
        receiveAmount: json["receiveAmount"].toDouble(),
        totalAmount: json["totalAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "payWay": payWay,
        "payAmount": payAmount,
        "payMethod": payMethod,
        "receiveAmount": receiveAmount,
        "totalAmount": totalAmount,
      };
}
