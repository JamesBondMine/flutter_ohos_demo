import 'package:get/get.dart';

import '../controllers/mine_controller.dart';

class MineBinding extends Bindings {
  @override
   dependencies() {
      Get.lazyPut<MineController>(
        () => MineController(),
      );
  }
}
