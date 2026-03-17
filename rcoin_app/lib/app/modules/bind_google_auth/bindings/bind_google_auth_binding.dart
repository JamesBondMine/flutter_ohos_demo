import 'package:get/get.dart';

import '../controllers/bind_google_auth_controller.dart';

class BindGoogleAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindGoogleAuthController>(
      () => BindGoogleAuthController(),
    );
  }
}
