import 'package:get/get.dart';

import '../controllers/google_auth_controller.dart';

class GoogleAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleAuthController>(
      () => GoogleAuthController(),
    );
  }
}
