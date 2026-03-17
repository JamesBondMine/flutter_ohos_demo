import 'package:get/get.dart';

import 'package:otc_app/app/modules/merchant/controllers/all_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/canceled_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/complete_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/ongoing_order_controller.dart';

import '../controllers/merchant_controller.dart';

class MerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllOrderController>(
      () => AllOrderController(),
    );
    Get.lazyPut<OngoingOrderController>(
          () => OngoingOrderController(),
    );
    Get.lazyPut<CompleteOrderController>(
          () => CompleteOrderController(),
    );
    Get.lazyPut<CanceledOrderController>(
          () => CanceledOrderController(),
    );
    Get.lazyPut<MerchantController>(
      () => MerchantController(),
    );
  }
}
