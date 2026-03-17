import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/income_statistics.dart';

class IncomeRecordPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Rx<TradeCtcTradeStatistic> data = Rx(TradeCtcTradeStatistic());

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    fetchData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  fetchData({String day = 'today'}) async {
    final res = await NetRepository.client.tradeStatistic(day: day);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    data(res.data);
  }
}
