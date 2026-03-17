import 'package:get/get.dart';

import '../controllers/withdraw_logs_controller.dart';

class WithdrawLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawLogsController>(
      () => WithdrawLogsController(),
    );
  }
}
