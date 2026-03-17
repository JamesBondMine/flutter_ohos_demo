import 'package:get/get.dart';

import '../controllers/recharge_logs_controller.dart';

class RechargeLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeLogsController>(
      () => RechargeLogsController(),
    );
  }
}
