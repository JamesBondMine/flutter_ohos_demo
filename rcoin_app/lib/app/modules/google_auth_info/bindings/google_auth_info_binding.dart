import 'package:get/get.dart';

import '../controllers/google_auth_info_controller.dart';

class GoogleAuthInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleAuthInfoController>(
      () => GoogleAuthInfoController(),
    );
  }
}
