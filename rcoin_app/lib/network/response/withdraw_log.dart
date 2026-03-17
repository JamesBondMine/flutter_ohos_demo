import 'dart:convert';

import 'package:get/get.dart';

class WithdrawLog {
  WithdrawLog({
    required this.account,
    required this.accountType,
    required this.amount,
    required this.authRemark,
    required this.coinId,
    required this.coinName,
    required this.createdAt,
    required this.fee,
    required this.id,
    required this.number,
    required this.orderSn,
    required this.price,
    required this.remark,
    required this.state,
    required this.usdtPrice,
    required this.userId,
    required this.username,
  });

  String? account;
  int? accountType;
  double? amount;
  String? authRemark;
  int? coinId;
  String? coinName;

  ///创建时间
  String? createdAt;
  double? fee;

  ///主键ID
  int? id;
  double? number;
  String? orderSn;
  double? price;
  String? remark;
  int? state;

  ///更新时间
  double? usdtPrice;
  int? userId;
  String? username;

  WithdrawLog copyWith({
    String? account,
    int? accountType,
    double? amount,
    String? authRemark,
    int? coinId,
    String? coinName,
    String? createdAt,
    double? fee,
    int? id,
    double? number,
    String? orderSn,
    double? price,
    String? remark,
    int? state,
    double? usdtPrice,
    int? userId,
    String? username,
  }) =>
      WithdrawLog(
        account: account ?? this.account,
        accountType: accountType ?? this.accountType,
        amount: amount ?? this.amount,
        authRemark: authRemark ?? this.authRemark,
        coinId: coinId ?? this.coinId,
        coinName: coinName ?? this.coinName,
        createdAt: createdAt ?? this.createdAt,
        fee: fee ?? this.fee,
        id: id ?? this.id,
        number: number ?? this.number,
        orderSn: orderSn ?? this.orderSn,
        price: price ?? this.price,
        remark: remark ?? this.remark,
        state: state ?? this.state,
        usdtPrice: usdtPrice ?? this.usdtPrice,
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  factory WithdrawLog.fromRawJson(String str) =>
      WithdrawLog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawLog.fromJson(Map<String, dynamic> json) => WithdrawLog(
        account: json["account"],
        accountType: json["accountType"],
        amount: json["amount"].toDouble(),
        authRemark: json["authRemark"],
        coinId: json["coinId"],
        coinName: json["coinName"],
        createdAt: json["CreatedAt"],
        fee: json["fee"].toDouble(),
        id: json["id"],
        number: json["number"].toDouble(),
        orderSn: json["orderSn"],
        price: json["price"].toDouble(),
        remark: json["remark"],
        state: json["state"],
        usdtPrice: json["USDTPrice"].toDouble(),
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "accountType": accountType,
        "amount": amount,
        "authRemark": authRemark,
        "coinId": coinId,
        "coinName": coinName,
        "createdAt": createdAt,
        "fee": fee,
        "id": id,
        "number": number,
        "orderSn": orderSn,
        "price": price,
        "remark": remark,
        "state": state,
        "USDTPrice": usdtPrice,
        "userId": userId,
        "username": username,
      };

  String stateDesc() {
    switch (state) {
      case 0:
        return "未处理".tr;
      case 1:
        return "已通过".tr;
      case 2:
        return "已拒绝".tr;
      default:
        return "未知".tr;
    }
  }
}
