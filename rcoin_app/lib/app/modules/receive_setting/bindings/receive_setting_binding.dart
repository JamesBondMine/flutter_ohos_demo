import 'package:get/get.dart';

import '../controllers/receive_setting_controller.dart';

class ReceiveSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveSettingController>(
      () => ReceiveSettingController(),
    );
  }
}
