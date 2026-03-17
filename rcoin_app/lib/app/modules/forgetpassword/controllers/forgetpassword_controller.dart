import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/widgets/toast.dart';
import '../../../../network/repository.dart';
import '../../../../network/request/reset_password_request.dart';
import '../../../../network/request/send_captcha_request.dart';
import '../../../routes/app_pages.dart';

class ForgetpasswordController extends GetxController {
  //TODO: Implement ForgetpasswordController

  final count = 0.obs;
  Rx<bool> usePhone = true.obs;
  Rx<bool> showPassword = true.obs;
  Rx<bool> showRePassword = true.obs;
  Rx<bool> showPassword1 = true.obs;

  Rx<String> areaCode = '+91'.obs;
  TextEditingController accountCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController reconfirmPasswordCtrl = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    accountCtrl.dispose();
    codeCtrl.dispose();
    passwordCtrl.dispose();
    reconfirmPasswordCtrl.dispose();
  }

  void increment() => count.value++;

  Future<bool> sendCode() async {
    int captchaType = 1;
    final account = accountCtrl.text.trim();
    if (!GetUtils.isPhoneNumber(account) && !GetUtils.isEmail(account)) {
      Toast.showError('请输入正确的手机号或邮箱'.tr);
      return false;
    }
    if (GetUtils.isPhoneNumber(account)) {
      captchaType = 1;
    }
    if (GetUtils.isEmail(account)) {
      captchaType = 2;
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
          account: account,
          areaCode: areaCode.value,
          captchaType: captchaType,
          scene: 3));
      if (res.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg.tr);
        return false;
      }
      Toast.hideLoading();
      return true;
    } catch (e) {
      Toast.hideLoading();
      Toast.showError('captche error');
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
    if (codeCtrl.text.isEmpty) {
      Toast.showError('请输入收到的验证码'.tr);
      return false;
    }
    if (passwordCtrl.text.isEmpty) {
      Toast.showError('请输入设置的密码'.tr);
      return false;
    }
    if (reconfirmPasswordCtrl.text.isEmpty) {
      Toast.showError('请输入确认密码'.tr);
      return false;
    }
    if (passwordCtrl.text != reconfirmPasswordCtrl.text) {
      Toast.showError('两次输入的密码不一致，请重新输入'.tr);
      return false;
    }

    final res = await NetRepository.client.resetPassword(ResetPasswordRequest(
      account: accountCtrl.text,
      captcha: codeCtrl.text,
      password: passwordCtrl.text,
      confirmPassword: reconfirmPasswordCtrl.text,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess(res.msg);
    Get.toNamed(Routes.LOGIN);
  }
}
