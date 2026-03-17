import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/share_setting.dart';

class SharePageController extends GetxController with StateMixin<ShareSetting> {
  @override
  void onInit() {
    fetchSetting();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchSetting() async {
    final res = await NetRepository.client.shareSetting();
    if (res.code != 0) {
      change(null, status: RxStatus.error(res.msg));
      return;
    }
    change(res.data, status: RxStatus.success());
  }
}
