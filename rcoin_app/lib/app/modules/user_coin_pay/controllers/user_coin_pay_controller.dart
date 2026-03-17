import 'package:get/get.dart';

import '../../../../app.dart';

class UserCoinPayController extends GetxController with StateMixin {
  //TODO: Implement UserCoinPayController
  final int type = Get.arguments['type'];
  String msg = Get.arguments['msg'];
  String amount =  Get.arguments['amount'];
  final count = 0.obs;
  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    logger.e('code>>>>>>>>>>type>>>',error: type);
    logger.e('code>>>>>>>>>>msg>>>',error: msg);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
