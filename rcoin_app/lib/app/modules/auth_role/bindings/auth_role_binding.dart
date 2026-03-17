import 'package:get/get.dart';

import '../controllers/auth_role_controller.dart';

class AuthRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRoleController>(
      () => AuthRoleController(),
    );
  }
}
