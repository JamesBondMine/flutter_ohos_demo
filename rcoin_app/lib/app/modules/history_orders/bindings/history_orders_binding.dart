import 'package:get/get.dart';

import '../controllers/all_order_controller.dart';
import '../controllers/canceled_order_controller.dart';
import '../controllers/complete_order_controller.dart';
import '../controllers/ongoing_order_controller.dart';
import '../controllers/history_orders_controller.dart';

class HistoryOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryOrdersController>(
      () => HistoryOrdersController(),
    );
    Get.lazyPut<AllOrderController>(
      () => AllOrderController(),
      tag: 'history',
    );
    Get.lazyPut<OngoingOrderController>(
      () => OngoingOrderController(),
      tag: 'history',
    );
    Get.lazyPut<CompleteOrderController>(
      () => CompleteOrderController(),
      tag: 'history',
    );
    Get.lazyPut<CanceledOrderController>(
      () => CanceledOrderController(),
      tag: 'history',
    );
  }
}
