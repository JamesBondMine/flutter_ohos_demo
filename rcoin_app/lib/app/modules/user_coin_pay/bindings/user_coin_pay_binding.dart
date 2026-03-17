import 'package:get/get.dart';

import '../controllers/user_coin_pay_controller.dart';

class UserCoinPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCoinPayController>(
      () => UserCoinPayController(),
    );
  }
}
