import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
   dependencies() {
      Get.lazyPut<HomeController>(
        () => HomeController(),
      );
  }
}
     