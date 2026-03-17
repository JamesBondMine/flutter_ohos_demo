import 'package:get/get.dart';

import '../controllers/acceptance_controller.dart';
import '../controllers/all_order_controller.dart';
import '../controllers/canceled_order_controller.dart';
import '../controllers/complete_order_controller.dart';
import '../controllers/ongoing_order_controller.dart';

class AcceptanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptanceAllOrderController>(
          () => AcceptanceAllOrderController(),
    );
    Get.lazyPut<AcceptanceOngoingOrderController>(
          () => AcceptanceOngoingOrderController(),
    );
    Get.lazyPut<AcceptanceCompleteOrderController>(
          () => AcceptanceCompleteOrderController(),
    );
    Get.lazyPut<AcceptanceCanceledOrderController>(
          () => AcceptanceCanceledOrderController(),
    );
    Get.lazyPut<AcceptanceController>(
      () => AcceptanceController(),
    );
  }
}
