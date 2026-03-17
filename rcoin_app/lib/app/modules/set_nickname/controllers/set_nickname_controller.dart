import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/update_user_info_request.dart';
import 'package:otc_app/service.dart';

class SetNicknameController extends GetxController {
  TextEditingController controller = TextEditingController();
  @override
  void onInit() {
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

  save() async {
    String nickName = controller.text;
    final res = await NetRepository.client.updateUserInfo(UpdateUserInfoRequest(
      nickName: nickName,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    await UserService.to.reFetchUser();
    Get.back();
  }
}
