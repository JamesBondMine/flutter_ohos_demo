import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/app.dart';

class TradeController extends GetxController with GetTickerProviderStateMixin {
  static TradeController get to => Get.put(TradeController());

  late TabController tabController;
  Rx<double?> filterMoney = Rx<double?>(null);

  Rx<int?> filterIndex = Rx<int?>(null);

  StreamSubscription<OrderFilterEvent>? sub;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    sub = AppService.bus.on<OrderFilterEvent>().listen((event) {
      filterIndex.value = null;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
    sub?.cancel();
  }

  // 刷新
  String tradeChildRefreshId = 'tradeChildRefreshId';

  // 更新
  updateTradeChildPageRefresh() {
    update([tradeChildRefreshId]);
  }

  // 刷新
  String tradePageRefreshId = 'tradePageRefreshId';

  // 更新
  updateTradePageRefresh() {
    update([tradePageRefreshId]);
  }
}
