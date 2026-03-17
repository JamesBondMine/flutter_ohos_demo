import 'package:get/get.dart';

import '../controllers/auth_result_controller.dart';

class AuthResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthResultController>(
      () => AuthResultController(),
    );
  }
}
