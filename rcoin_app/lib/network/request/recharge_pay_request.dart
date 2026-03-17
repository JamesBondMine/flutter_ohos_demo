// To parse this JSON data, do
//
//     final rechargePayRequest = rechargePayRequestFromJson(jsonString);

import 'dart:convert';


///request.RechargePay
class RechargePayRequest {
  RechargePayRequest({
    this.hash,
    this.id,
  });


  ///充值哈希
  String? hash;

  ///充值ID
  int? id;

  factory RechargePayRequest.fromRawJson(String str) => RechargePayRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RechargePayRequest.fromJson(Map<String, dynamic> json) => RechargePayRequest(
    hash: json["hash"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "id": id,
  };
}