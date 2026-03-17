import 'package:get/get.dart';

import '../controllers/bind_phone_email_controller.dart';

class BindPhoneEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindPhoneEmailController>(
      () => BindPhoneEmailController(),
    );
  }
}
