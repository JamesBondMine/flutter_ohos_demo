import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/update_user_info_request.dart';

class AccountDetailController extends GetxController {
  static AccountDetailController get to => Get.put(AccountDetailController());
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = UserService.to.user.value.nickName ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
  }

  saveNickname(String nickName) async {
    final res = await NetRepository.client.updateUserInfo(UpdateUserInfoRequest(
      nickName: nickName,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    // Toast.showSuccess('成功'.tr);
    await UserService.to.reFetchUser();
  }
}
