import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/widgets/bottom_select.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/list_response.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/request/match_order_request.dart';
import 'package:otc_app/network/response/trade_fast_number_fon.dart';

class ConfirmOrderController extends GetxController {
  static ConfirmOrderController get to => Get.put(ConfirmOrderController());
  PublishOrder order = Get.arguments['order'];

  Rx<int> tradeType = 0.obs; //交易方式  0 按金额  1 按数量

  Rx<double> equivalentQuantity = 0.0.obs; //折合数量
  Rx<double> equivalentAmount = 0.0.obs; //折合金额
  double get price => order.price;

  RxList<int> options = RxList();

  TextEditingController inputController = TextEditingController();

  final RxInt optionIndex = (-1).obs;

  @override
  void onInit() {
    logger.e('获取订单信息', error: order);
    super.onInit();
    tradeType.listen((p0) {
      inputController.clear();
      equivalentQuantity.value = 0;
      equivalentAmount.value = 0;
    });

    inputController.addListener(() {
      if (tradeType.value == 0) {
        equivalentAmount.value = double.tryParse(inputController.text) ?? 0;
        equivalentQuantity.value = (equivalentAmount.value / price).fixed();
      } else {
        equivalentQuantity.value = double.tryParse(inputController.text) ?? 0;
        (equivalentAmount.value = equivalentQuantity.value * price).fixed();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getFastOptions();
    ApplicationController.to.fetchAssets();
  }

  @override
  void onClose() {
    super.onClose();
    inputController.dispose();
    tradeType.close();
  }

  // 当前支付方式
  late String payMethod;
  // 刷新支付方式
  String orderConfirmPaymentRefreshId = "orderConfirmPaymentRefreshId";
  updateOrderConfirmPaymentRefresh() {
    update([orderConfirmPaymentRefreshId]);
  }

  inputMax() {
    final double money = ApplicationController.to.assets.value!.money!;
    if (tradeType.value == 0) {
      inputController.text = min(money, order.maxMoney).toString();
    } else {
      inputController.text = (min(money, order.maxMoney) / price).toString();
    }
  }

  // 支付
  send() async {
    int payMethodValue = int.tryParse(payMethod) ?? 0;
    if (payMethodValue == 0) {
      Toast.showError("payment error");
      return;
    }
    if (equivalentAmount.value == 0) {
      Toast.showError("amount error");
      return;
    }
    if (equivalentQuantity.value == 0) {
      Toast.showError("number error");
      return;
    }
    Get.toNamed(Routes.ENTER_PIN_black, arguments: {
      'paySide': PaySide.fromValue(order.type),
      'onCompleted': (String pin) async {
        AppResponse<TradeDetail> res;

        MatchOrderRequest params = MatchOrderRequest(
          amount: tradeType.value == 1 ? null : equivalentAmount.value,
          number: tradeType.value == 1 ? equivalentQuantity.value : null,
          orderId: order.id,
          payMethod: payMethodValue,
          pwd: pin,
        );

        if (order.type == PaySide.sell.value) {
          res = await NetRepository.client.tradeBuy(params);
        } else {
          res = await NetRepository.client.tradeSell(params);
        }
        if (res.code != 0) {
          Toast.showError(res.msg);
          return;
        }
        Get.offNamed(Routes.ORDER_DETAIL, arguments: {
          'id': (res.data as TradeDetail).id,
        });
      },
    });
  }

  getFastOptions() async {
    final res = await NetRepository.client.fastNumbers();
    if (res.code == 0) {
      var list = (res.data as ListResponse<TradeFastNumberFon>).list;
      options.clear();
      options.addAll(list.map((e) => e.amount!));
    }
  }
}
