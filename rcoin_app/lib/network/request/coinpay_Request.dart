// To parse this JSON data, do
//
//     final coinPayRequest = coinPayRequestFromJson(jsonString);

import 'dart:convert';

CoinPayRequest coinPayRequestFromJson(String str) => CoinPayRequest.fromJson(json.decode(str));

String coinPayRequestToJson(CoinPayRequest data) => json.encode(data.toJson());

class CoinPayRequest {
  double? money;
  String? orderSn;
  String? pwd;

  CoinPayRequest({
    this.money,
    this.orderSn,
    this.pwd,
  });

  factory CoinPayRequest.fromJson(Map<String, dynamic> json) => CoinPayRequest(
    money: json["money"],
    orderSn: json["orderSn"],
    pwd: json["pwd"],
  );

  Map<String, dynamic> toJson() => {
    "money": money,
    "orderSn": orderSn,
    "pwd": pwd,
  };
}
