import 'package:get/get.dart';

import '../controllers/recharge_detail_controller.dart';

class RechargeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeDetailController>(
      () => RechargeDetailController(),
    );
  }
}
