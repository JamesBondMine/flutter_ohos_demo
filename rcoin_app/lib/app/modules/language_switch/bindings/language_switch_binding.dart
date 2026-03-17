import 'package:get/get.dart';

import '../controllers/language_switch_controller.dart';

class LanguageSwitchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageSwitchController>(
      () => LanguageSwitchController(),
    );
  }
}
