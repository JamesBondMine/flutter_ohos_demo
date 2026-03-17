
import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut<SignInController>(
          () => SignInController(),
    );
  }
}