import 'package:get/get.dart';

import '../controllers/receipt_logs_controller.dart';

class ReceiptLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptLogsController>(
      () => ReceiptLogsController(),
    );
  }
}
