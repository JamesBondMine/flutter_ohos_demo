import 'package:get/get.dart';
import 'package:otc_app/app/modules/acceptance/controllers/acceptance_controller.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/merchant_controller.dart';
import 'package:otc_app/app/modules/mine/controllers/mine_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/trade_controller.dart';

import '../controllers/application_controller.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(
      () => ApplicationController(),
    );
    // Get.lazyPut<HomeController>(
    //       () => HomeController(),
    // );
    // Get.lazyPut<TradeController>(
    //       () => TradeController(),
    // );
    // Get.lazyPut<AcceptanceController>(
    //       () => AcceptanceController(),
    // );
    // Get.lazyPut<MerchantController>(
    //       () => MerchantController(),
    // );
    // Get.lazyPut<MineController>(
    //       () => MineController(),
    // );
  }
}
