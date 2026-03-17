import 'package:get/get.dart';

import '../controllers/set_nickname_controller.dart';

class SetNicknameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetNicknameController>(
      () => SetNicknameController(),
    );
  }
}
