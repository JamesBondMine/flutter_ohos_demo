// To parse this JSON data, do
//
//     final rechargeResDetail = rechargeResDetailFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';

///trade.RechargeListFon
class RechargeResDetail {
  RechargeResDetail({
    this.address,
    this.block,
    this.coinId,
    this.confirms,
    this.createdAt,
    this.hash,
    this.id,
    this.intoState,
    this.isCollection,
    this.money,
    this.nConfirms,
    this.orderSn,
    this.payTime,
    this.protocol,
    this.rate,
    this.receivedAmount,
    this.state,
    this.updatedAt,
    this.userId,
  });

  String? address;
  int? block;
  int? coinId;
  int? confirms;

  ///创建时间
  String? createdAt;
  String? hash;

  ///主键ID
  int? id;
  int? intoState;
  int? isCollection;

  ///支付金额
  double? money;
  int? nConfirms;
  String? orderSn;
  String? payTime;

  ///协议类型TRC20/ERC20
  String? protocol;
  double? rate;

  ///到账金额
  double? receivedAmount;
  int? state;

  ///更新时间
  String? updatedAt;
  int? userId;

  factory RechargeResDetail.fromRawJson(String str) =>
      RechargeResDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RechargeResDetail.fromJson(Map<String, dynamic> json) =>
      RechargeResDetail(
        address: json["address"],
        block: json["block"],
        coinId: json["coinId"],
        confirms: json["confirms"],
        createdAt: json["CreatedAt"],
        hash: json["hash"],
        id: json["id"],
        intoState: json["intoState"],
        isCollection: json["isCollection"],
        money: json["money"].toDouble(),
        nConfirms: json["nConfirms"],
        orderSn: json["orderSn"],
        payTime: json["payTime"],
        protocol: json["protocol"],
        rate: json["rate"].toDouble(),
        receivedAmount: json["receivedAmount"].toDouble(),
        state: json["state"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "block": block,
        "coinId": coinId,
        "confirms": confirms,
        "createdAt": createdAt,
        "hash": hash,
        "id": id,
        "intoState": intoState,
        "isCollection": isCollection,
        "money": money,
        "nConfirms": nConfirms,
        "orderSn": orderSn,
        "payTime": payTime,
        "protocol": protocol,
        "rate": rate,
        "receivedAmount": receivedAmount,
        "state": state,
        "updatedAt": updatedAt,
        "userId": userId,
      };

  String stateDesc() {
    return switch (state) {
      1 => '进行中'.tr,
      2 => '已完成'.tr,
      3 => '失败'.tr,
      _ => '未知'.tr,
    };
  }

  Color getColor() {
    return switch (state) {
      1 => Color(0xff2AC769),
      2 => Color(0xffffffff),
      3 => Color(0xffE73463),
      _ => Color(0xff6d6d6d),
    };
  }
}
