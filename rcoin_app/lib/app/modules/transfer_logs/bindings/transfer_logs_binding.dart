import 'package:get/get.dart';

import '../controllers/transfer_logs_controller.dart';

class TransferLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferLogsController>(
      () => TransferLogsController(),
    );
  }
}
