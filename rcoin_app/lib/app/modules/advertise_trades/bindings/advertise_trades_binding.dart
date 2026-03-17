import 'package:get/get.dart';

import '../controllers/advertise_trades_controller.dart';

class AdvertiseTradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertiseTradesController>(
      () => AdvertiseTradesController(Get.arguments['id']),
    );
  }
}
