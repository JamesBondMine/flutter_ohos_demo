import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class TeamRuleController extends GetxController with StateMixin<String> {
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    change(null, status: RxStatus.loading());
    final res = await NetRepository.client.agentRule();
    if (res.code != 0) {
      change(null, status: RxStatus.error(res.msg));
    } else {
      var detail = (res.data as Map<String, dynamic>)['content'] ?? '';

      change(detail, status: RxStatus.success());
    }
  }
}
