import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/system_message.dart';

class NotificationDetailController extends GetxController
    with StateMixin<SystemMessage> {
  int id = Get.arguments['id'];

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchDetail() async {
    final res = await NetRepository.client.systemMessageDetail(id);
    if (res.code != 0) {
      change(null, status: RxStatus.error(res.msg));
    } else {
      var detail = res.data as SystemMessage;
      change(detail, status: RxStatus.success());
    }
  }
}
