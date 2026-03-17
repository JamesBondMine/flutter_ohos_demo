import 'package:get/get.dart';

import '../controllers/share_page_controller.dart';

class SharePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharePageController>(
      () => SharePageController(),
    );
  }
}
