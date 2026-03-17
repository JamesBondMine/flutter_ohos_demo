import 'package:get/get.dart';

import '../controllers/set_pay_password_controller.dart';

class SetPayPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPayPasswordController>(
      () => SetPayPasswordController(),
    );
  }
}
