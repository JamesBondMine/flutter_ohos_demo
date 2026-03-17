import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/register_request.dart';
import 'package:otc_app/network/request/reset_password_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/services/user.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordConfirmCtrl = TextEditingController();

  final usePhone = true.obs;
  final areaCode = '+86'.obs;

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

    emailCtrl.dispose();
    phoneCtrl.dispose();
    codeCtrl.dispose();
    passwordCtrl.dispose();
    passwordConfirmCtrl.dispose();
  }

  Future<bool> sendCode() async {
    final phone = phoneCtrl.text.trim();
    final email = emailCtrl.text.trim();

    String account;
    if (usePhone.value) {
      account = phone;
      if (!GetUtils.isPhoneNumber(phone)) {
        Toast.showError('请输入正确的手机号码'.tr);
        return false;
      }
    } else {
      account = email;
      if (!GetUtils.isEmail(email)) {
        Toast.showError('请输入正确的邮箱'.tr);
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
        Toast.showError(res.msg.tr);
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

  submit() async {
    final res = await NetRepository.client.resetPassword(ResetPasswordRequest(
      account: usePhone.value ? phoneCtrl.text : emailCtrl.text,
      captcha: codeCtrl.text,
      password: passwordCtrl.text,
      confirmPassword: passwordConfirmCtrl.text,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    Get.toNamed(Routes.LOGIN);
  }
}
