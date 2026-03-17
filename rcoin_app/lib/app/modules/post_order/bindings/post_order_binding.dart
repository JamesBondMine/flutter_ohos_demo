import 'package:get/get.dart';
import 'package:otc_app/app/modules/post_order/controllers/post_order_controller.dart';

class PostOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostOrderController>(
      () => PostOrderController(),
    );
  }
}
