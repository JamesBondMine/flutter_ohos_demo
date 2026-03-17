// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

class TradeUserCommission {
  TradeUserCommission({
    required this.commissionRate,
    required this.icon,
    required this.id,
    required this.name,
    required this.payCommissionRate,
  });


  ///代收佣金比例
  double? commissionRate;

  ///图标地址
  String? icon;

  ///通道ID payMethod
  int? id;

  ///通道名称
  String? name;

  ///代付佣金比例
  double? payCommissionRate;

  factory TradeUserCommission.fromRawJson(String str) => TradeUserCommission.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TradeUserCommission.fromJson(Map<String, dynamic> json) => TradeUserCommission(
    commissionRate: json["commissionRate"].toDouble(),
    icon: json["icon"],
    id: json["id"],
    name: json["name"],
    payCommissionRate: json["payCommissionRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "commissionRate": commissionRate,
    "icon": icon,
    "id": id,
    "name": name,
    "payCommissionRate": payCommissionRate,
  };
}