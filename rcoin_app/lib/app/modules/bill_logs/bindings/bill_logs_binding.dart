import 'package:get/get.dart';

import '../controllers/bill_logs_controller.dart';

class BillLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillLogsController>(
      () => BillLogsController(),
    );
  }
}
