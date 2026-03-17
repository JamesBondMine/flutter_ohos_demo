import 'package:get/get.dart';

import '../controllers/bind_google_auth_next_controller.dart';

class BindGoogleAuthNextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindGoogleAuthNextController>(
      () => BindGoogleAuthNextController(),
    );
  }
}
