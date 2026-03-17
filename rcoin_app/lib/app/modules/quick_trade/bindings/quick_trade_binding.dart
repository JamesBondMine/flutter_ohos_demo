import 'package:get/get.dart';

import '../controllers/quick_trade_controller.dart';

class QuickTradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickTradeController>(
      () => QuickTradeController(),
    );
  }
}
