import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/trade/controllers/buy_orders_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/sale_orders_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/trade_controller.dart';

class OrderFilterController extends GetxController {
  static OrderFilterController get to => Get.put(OrderFilterController());
  final cooperation = false.obs;
  final RxList<int> payMethods = RxList([]);
  final Rx<int> minAmountIndex = Rx(-1);
  final Rx<int> maxAmountIndex = Rx(-1);
  //
  // TextEditingController minController = TextEditingController();
  // TextEditingController maxController = TextEditingController();

  Rx<double?> filterMin = Rx<double?>(null);
  Rx<double?> filterMax = Rx<double?>(null);

  @override
  void onClose() {
    // minController.dispose();
    // maxController.dispose();
    super.onClose();
  }

  reset() {
    cooperation.value = false;
    payMethods.value = [];
    // minAmountIndex.value = -1;
    // maxAmountIndex.value = -1;
    // minController.clear();
    // maxController.clear();
  }

  confirmOptions() {
    AppService.bus.fire(OrderFilterEvent(
      cooperated: cooperation.value ? 1 : null,
      paymentMethods: payMethods.toList(),
      minAmount: filterMin.value,
      maxAmount: filterMax.value,
    ));
    TradeController.to.updateTradeChildPageRefresh();
    // Get.back();
  }
}
