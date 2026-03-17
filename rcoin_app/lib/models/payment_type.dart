import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/assets.dart';

enum PaymentType {
  bank(1),
  wechat(2),
  alipay(3),
  usdt(4),
  upi(5),
  paytm(6),
  gpay(7),
  phonepe(8),
  amazonPay(9),
  digitalRupees(10),
  ;

  final int value;

  const PaymentType(this.value);

  factory PaymentType.fromValue(int value) {
    return PaymentType.values
        .firstWhere((element) => element.value == value, orElse: () => bank);
  }

  String get text => switch (this) {
        bank => '银行卡'.tr,
        wechat => '微信'.tr,
        alipay => '支付宝'.tr,
        usdt => 'USDT',
        upi => 'UPI',
        paytm => 'Paytm',
        gpay => 'Gpay',
        phonepe => 'Phonepe',
        amazonPay => 'Amazon Pay',
        digitalRupees => 'Digital Rupees',
      };

  Color get color => switch (this) {
        bank => const Color(0xffF5A623),
        wechat => const Color(0xff04C2AD),
        alipay => const Color(0xff4791FF),
        usdt => const Color(0xff349872),
        upi => Colors.transparent,
        paytm => Colors.transparent,
        gpay => Colors.transparent,
        phonepe => Colors.transparent,
        amazonPay => Colors.transparent,
        digitalRupees => Colors.transparent,
      };

  String get icon => switch (this) {
        alipay => Assets.imagesAlipay,
        wechat => Assets.imagesWechat,
        bank => Assets.imagesBank,
        usdt => Assets.imagesUsdt,
        upi => '',
        paytm => '',
        gpay => '',
        phonepe => '',
        amazonPay => '',
        digitalRupees => '',
      };
}

class PaymentTypeModel {
  late String id;
  late String payment;
  late String paymentMark;
  late String paymentText;
  late String paymentIcon;
  late String paymentAppear;
  late String paymentClick;
  late String paymentColor;

  PaymentTypeModel();

  PaymentTypeModel.fromjson(Map data) {
    id = data["id"] ?? "";
    payment = data["payment"] ?? "";
    paymentText = data["paymentText"] ?? "";
    paymentIcon = data["paymentIcon"] ?? "";
    paymentAppear = data["paymentAppear"] ?? "";
    paymentClick = data["paymentClick"] ?? "";
    paymentColor = data["paymentColor"] ?? "";
    paymentMark = paymentMap[payment] ?? "";
  }

  Map<String, String> paymentMap = {
    "upi": "UPI",
    "paytm": "Paytm",
    "gpay": "Gpay",
    "phonepe": "Phonepe",
    "amazonPay": "Amazon Pay",
    "digitalRupees": "Digital Rupees",
    "bank": "Bank",
    "wechat": "Wechat",
    "alipay": "Alipay",
    "usdt": "Usdt"
  };
}
