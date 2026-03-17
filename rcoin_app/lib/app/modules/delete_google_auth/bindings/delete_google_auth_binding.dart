import 'package:get/get.dart';

import '../controllers/delete_google_auth_controller.dart';

class DeleteGoogleAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteGoogleAuthController>(
      () => DeleteGoogleAuthController(),
    );
  }
}
