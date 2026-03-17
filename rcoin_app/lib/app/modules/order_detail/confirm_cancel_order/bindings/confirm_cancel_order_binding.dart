import 'package:get/get.dart';

import '../controllers/confirm_cancel_order_controller.dart';

class ConfirmCancelOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmCancelOrderController>(
      () => ConfirmCancelOrderController(),
    );
  }
}
