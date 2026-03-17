import 'package:get/get.dart';

import '../controllers/bind_phone_email_next_controller.dart';

class BindPhoneEmailNextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindPhoneEmailNextController>(
      () => BindPhoneEmailNextController(),
    );
  }
}
