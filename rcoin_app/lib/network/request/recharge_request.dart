// To parse this JSON data, do
//
//     final rechangeRequest = rechangeRequestFromJson(jsonString);

import 'dart:convert';


///request.Recharge
class RechargeRequest {
  RechargeRequest({
    this.addressId,
    this.amount,
  });


  ///平台充值地址ID
  int? addressId;

  ///充值金额
  double? amount;

  factory RechargeRequest.fromRawJson(String str) => RechargeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RechargeRequest.fromJson(Map<String, dynamic> json) => RechargeRequest(
    addressId: json["addressId"],
    amount: json["amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "addressId": addressId,
    "amount": amount,
  };
}