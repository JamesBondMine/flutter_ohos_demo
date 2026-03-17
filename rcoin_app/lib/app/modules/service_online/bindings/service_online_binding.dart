import 'package:get/get.dart';

import '../controllers/service_online_controller.dart';

class ServiceOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceOnlineController>(
      () => ServiceOnlineController(),
    );
  }
}
