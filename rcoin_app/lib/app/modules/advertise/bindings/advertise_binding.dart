import 'package:get/get.dart';

import '../controllers/advertise_buy_controller.dart';
import '../controllers/advertise_controller.dart';
import '../controllers/advertise_sell_controller.dart';

class AdvertiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertiseController>(
      () => AdvertiseController(),
    );
    Get.lazyPut<AdvertiseBuyController>(
      () => AdvertiseBuyController(),
    );
    Get.lazyPut<AdvertiseSellController>(
      () => AdvertiseSellController(),
    );

  }
}
