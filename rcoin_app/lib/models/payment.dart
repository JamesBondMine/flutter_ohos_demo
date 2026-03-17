// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

import 'package:otc_app/models/payment_type.dart';

///trade.UserPaymentMethod
class Payment {
  Payment({
    this.address,
    this.addressProtocol,
    this.bankAccount,
    this.bankName,
    this.createdAt,
    this.dayMaxAmount,
    this.dayMaxCount,
    this.dayMinAmount,
    this.state,
    this.enable,
    this.id,
    this.name,
    this.account,
    this.img,
    this.payMethod,
    this.updatedAt,
    this.userId,
    this.wechatAccount,
    this.wechatImg,
    this.zfbAccount,
    this.zfbImg,
    this.paymentChannelIds,
  });

  ///钱包地址
  String? address;

  ///钱包地址协议erc20/trc20
  String? addressProtocol;

  ///银行账户
  String? bankAccount;

  ///开户行
  String? bankName;

  ///创建时间
  String? createdAt;

  ///单笔最大接单金额
  double? dayMaxAmount;

  ///每天收款金额
  double? dayMaxCount;

  ///单笔最小接单金额
  double? dayMinAmount;

  ///是否不可用 1不可用 2否
  int? state;

  ///是否启用 1启用 2关闭
  int? enable;

  ///主键ID
  int? id;

  ///收款人姓名
  String? name;

  ///收款人账户
  String? account;

  ///收款人二维码
  String? img;

  ///支付方式 1银行卡 2微信 3支付宝
  int? payMethod;

  ///更新时间
  String? updatedAt;
  int? userId;

  ///微信账户
  String? wechatAccount;

  ///微信收款码
  String? wechatImg;

  ///支付宝账户
  String? zfbAccount;
  String? zfbImg;

  String? paymentChannelIds;

  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        address: json["address"],
        addressProtocol: json["addressProtocol"],
        bankAccount: json["bankAccount"],
        bankName: json["bankName"],
        createdAt: json["createdAt"],
        dayMaxAmount: json["dayMaxAmount"].toDouble(),
        dayMaxCount: json["dayMaxCount"].toDouble(),
        dayMinAmount: json["dayMinAmount"].toDouble(),
        state: json["state"],
        enable: json["enable"],
        id: json["id"],
        name: json["name"],
        account: json["account"],
        img: json["img"],
        payMethod: json["payMethod"],
        updatedAt: json["updatedAt"],
        userId: json["userId"],
        wechatAccount: json["wechatAccount"],
        wechatImg: json["wechatImg"],
        zfbAccount: json["zfbAccount"],
        zfbImg: json["zfbImg"],
        paymentChannelIds: json["paymentChannelIds"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "addressProtocol": addressProtocol,
        "bankAccount": bankAccount,
        "bankName": bankName,
        "createdAt": createdAt,
        "dayMaxAmount": dayMaxAmount,
        "dayMaxCount": dayMaxCount,
        "dayMinAmount": dayMinAmount,
        "state": state,
        "enable": enable,
        "id": id,
        "name": name,
        "account": account,
         "img": img,
        "payMethod": payMethod,
        "updatedAt": updatedAt,
        "userId": userId,
        "wechatAccount": wechatAccount,
        "wechatImg": wechatImg,
        "zfbAccount": zfbAccount,
        "zfbImg": zfbImg,
        "paymentChannelIds": paymentChannelIds,
      };

  PaymentType get payType => PaymentType.fromValue(payMethod!);

  String? get img1 => switch (payType) {
        PaymentType.wechat => wechatImg,
        PaymentType.alipay => zfbImg,
        PaymentType.bank => null,
        PaymentType.usdt => null,
        _ => null,
      };
}
