import 'package:get/get.dart';

import '../controllers/accout_binding_controller.dart';

class AccoutBindingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccoutBindingController>(
      () => AccoutBindingController(),
    );
  }
}
