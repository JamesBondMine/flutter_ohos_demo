import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/network/request/register_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/network/request/set_pay_password_request.dart';
import 'package:otc_app/service.dart';

class SetPayPasswordController extends GetxController {
  // TextEditingController emailCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();

  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordNewCtrl = TextEditingController();
  TextEditingController passwordConfirmCtrl = TextEditingController();

  final usePhone = true.obs;

  Rx<bool> showPassword1 = true.obs;
  Rx<bool> showPassword2 = true.obs;
  Rx<bool> showPassword3 = true.obs;

  int passwordType = Get.arguments['type'] ?? 1;

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

    // emailCtrl.dispose();
    codeCtrl.dispose();

    passwordNewCtrl.dispose();
    passwordCtrl.dispose();
    passwordConfirmCtrl.dispose();
  }

  Future<bool> sendCode() async {
    String account;
    if (usePhone.value) {
      account = UserService.to.user.value.phone ?? '';
      if (account.isEmpty) {
        Toast.showError('尚未绑定手机号'.tr);
        return false;
      }
    } else {
      account = UserService.to.user.value.email ?? '';
      if (account.isEmpty) {
        Toast.showError('尚未绑定邮箱'.tr);
        return false;
      }
    }

    try {
      Toast.showLoading();
      ConnectivityResult? resnet = await netCheck();
      if (resnet != null &&
          (resnet == ConnectivityResult.other ||
              resnet == ConnectivityResult.none)) {
        Toast.hideLoading();
        Toast.showError('net error!');
        return false;
      }
      final res = await NetRepository.client.sendCaptcha(SendCaptchaRequest(
          account: account, captchaType: usePhone.value ? 1 : 2, scene: 3));
      if (res.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg);
        return false;
      }
      Toast.hideLoading();
      return true;
    } catch (e) {
      Toast.hideLoading();
      Toast.showError('captche error!');
      return false;
    }
  }

  Future<ConnectivityResult?> netCheck() async {
    try {
      final Connectivity connectivity = Connectivity();
      List<ConnectivityResult> resnet = await connectivity.checkConnectivity();
      if (resnet.isEmpty) {
        return null;
      }
      return resnet.first;
    } catch (e) {
      return null;
    }
  }

  // 忘记交易密码
  save() async {
    String account;
    if (usePhone.value) {
      account = UserService.to.user.value.phone ?? '';
    } else {
      account = UserService.to.user.value.email ?? '';
    }

    if (passwordNewCtrl.text.isEmpty) {
      Toast.showInfo("新密码不能为空".tr);
      return;
    }
    if (passwordConfirmCtrl.text.isEmpty) {
      Toast.showInfo("确认密码不能为空".tr);
      return;
    }
    if (passwordNewCtrl.text != passwordConfirmCtrl.text) {
      Toast.showInfo("两次密码输入不一致".tr);
      return;
    }
    if (codeCtrl.text.isEmpty) {
      Toast.showInfo("验证码不能为空".tr);
      return;
    }
    final res = await NetRepository.client.setPayPassword(SetPayPasswordRequest(
      account: account,
      captcha: codeCtrl.text.trim(),
      payPassword: passwordNewCtrl.text.trim(),
      confirmPayPassword: passwordConfirmCtrl.text.trim(),
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    Toast.showSuccess('成功'.tr);
    passwordNewCtrl.text = "";
    passwordConfirmCtrl.text = "";
    UserService.to.user.value = UserService.to.user.value.copyWith(
      payPassword: 'not_empty',
    );
    Get.back();
  }

  // 修改交易密码 + 修改登陆密码
  Future updateLoginPwd() async {
    final oldPwd = passwordCtrl.text.trim();
    final pwd = passwordNewCtrl.text.trim();
    final pwdConfirm = passwordConfirmCtrl.text.trim();
    if (oldPwd.isEmpty) {
      Toast.showSuccess('请输入当前密码'.tr);
      return;
    }
    if (pwd.isEmpty) {
      Toast.showSuccess('请输入新密码'.tr);
      return;
    }

    if (pwdConfirm.isEmpty) {
      Toast.showSuccess('两次输入的密码不一致，请重新输入'.tr);
      return;
    }

    AppResponse res;
    if (passwordType == 2) {
      // 修改登陆密码
      res = await NetRepository.client.updateLoginPassword({
        'oldPassword': oldPwd,
        'newPassword': pwd,
        'confirmPassword': pwdConfirm,
      });
    } else {
      // 修改交易密码
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
    passwordCtrl.clear();
    passwordCtrl.clear();
    passwordConfirmCtrl.clear();
    Get.back();
  }
}
