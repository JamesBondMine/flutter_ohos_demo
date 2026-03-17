import 'package:get/get.dart';

import '../controllers/update_pay_password_controller.dart';

class UpdatePayPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePayPasswordController>(
      () => UpdatePayPasswordController(),
    );
  }
}
