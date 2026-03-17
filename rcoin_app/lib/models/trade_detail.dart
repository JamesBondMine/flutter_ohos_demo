import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/trade_trader.dart';

import '../services/user.dart';

part 'trade_detail.freezed.dart';

part 'trade_detail.g.dart';

@freezed
class TradeDetail with _$TradeDetail {
  const factory TradeDetail({
    double? amount,
    int? appealState,
    TradeTrader? buyer,
    int? callback,
    int? callbackTimes,
    int? coinId,
    int? countDown,
    String? CreatedAt,
    Payment? ctcTradePay,
    double? deposit,
    double? fee,
    String? finishTime,
    int? fourChannelId,
    String? fourChannelSn,
    int? id,
    String? imgs,
    String? notifyUrl,
    double? number,
    int? orderId,
    String? orderSn,
    int? orderUserId,
    String? outNickname,
    String? outOrderId,
    String? outUid,
    int? paymentState,
    int? payMethod,
    String? payTime,
    double? price,
    int? receiveConfirm,
    int? receiveOrPay,
    double? recvFee,
    String? remark,
    String? remarkCode,
    TradeTrader? seller,
    int? sourceType,
    int? state,
    int? tradePayId,
    int? type,
    String? updatedAt,
    double? usdtAmount,
    int? userId,
    int? userPaymentMethodId,
  }) = _TradeDetail;

  factory TradeDetail.fromJson(Map<String, Object?> json) =>
      _$TradeDetailFromJson(json);
}

extension Attrs on TradeDetail {
  int get buyerUid => (type! == 1) ? userId! : orderUserId!;

  bool get isBuyer => UserService.to.user.value.id == buyerUid;

  String get stateDesc {
    return switch ((isBuyer, state!)) {
      (_, 0) => '待确认'.tr,
      (true, 1) => '待付款'.tr,
      (false, 1) => '待付款'.tr,
      (true, 2) => '待确认'.tr, //已付款/待确认
      (false, 2) => '待确认'.tr, //已付款/待确认

      (true, 3) => '已完成'.tr, //完成
      (false, 3) => '已完成'.tr, //完成

      (true, 4) => '已取消'.tr, //取消
      (false, 4) => '已取消'.tr, //取消
      (_, 5) => '已取消'.tr, //取消

      _ => '',
    };
  }

  List<String> get imgList {
    return imgs?.split(',') ?? [];
  }
}
