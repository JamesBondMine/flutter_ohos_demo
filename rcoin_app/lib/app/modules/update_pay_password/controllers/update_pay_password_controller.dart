import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/app_response.dart';

class UpdatePayPasswordController extends GetxController {
  int passwordType = Get.arguments['type'] ?? 1;

  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordConfirmCtrl = TextEditingController();

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

    oldPasswordCtrl.dispose();
    passwordCtrl.dispose();
    passwordConfirmCtrl.dispose();
  }

  postUpdate() async {
    final oldPwd = oldPasswordCtrl.text.trim();
    final pwd = passwordCtrl.text.trim();
    final pwdConfirm = passwordConfirmCtrl.text.trim();
    if(oldPwd.isEmpty){
      Toast.showSuccess('请输入当前密码'.tr);
      return;
    }
    if(pwd.isEmpty){
      Toast.showSuccess('请输入新密码'.tr);
      return;
    }

    if(pwdConfirm.isEmpty){
      Toast.showSuccess('两次输入的密码不一致，请重新输入'.tr);
      return;
    }

    AppResponse res;
    if (passwordType == 1) {

      res = await NetRepository.client.updateLoginPassword({
        'oldPassword': oldPwd,
        'newPassword': pwd,
        'confirmPassword': pwdConfirm,
      });
    } else {
      res = await NetRepository.client.updatePayPassword({
        'oldPayPassword': oldPwd,
        'newPayPassword': pwd,
        'confirmPayPassword': pwdConfirm,
      });
    }

    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    oldPasswordCtrl.clear();
    passwordCtrl.clear();
    passwordConfirmCtrl.clear();
  }
}
