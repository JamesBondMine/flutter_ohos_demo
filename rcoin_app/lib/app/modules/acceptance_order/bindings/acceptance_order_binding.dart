import 'package:get/get.dart';

import '../controllers/acceptance_order_controller.dart';

class AcceptanceOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceptanceOrderController>(
      () => AcceptanceOrderController(),
    );
  }
}
