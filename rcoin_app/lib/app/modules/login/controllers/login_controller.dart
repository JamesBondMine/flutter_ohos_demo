import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models.dart';
import 'package:otc_app/network/exception_handler.dart';
import 'package:otc_app/network/request/login_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/service.dart';
import 'package:otc_app/services/pusher.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  Rx<bool> usePhone = true.obs;
  Rx<bool> usePassword = true.obs;
  Rx<bool> showPassword = true.obs;
  Rx<String> areaCode = '+91'.obs;

  TextEditingController accountCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    accountCtrl.dispose();
    codeCtrl.dispose();
    passwordCtrl.dispose();
    tabController.dispose();
  }

  Future<bool> sendCode() async {
    final account = accountCtrl.text.trim();
    int captchaType = 1;
    if (usePhone.value) {
      if (!GetUtils.isPhoneNumber(account)) {
        Toast.showError('请输入正确的手机号码'.tr);
        return false;
      }
      captchaType = 1;
    } else {
      if (!GetUtils.isEmail(account)) {
        Toast.showError('请输入正确的邮箱'.tr);
        return false;
      }
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
          scene: 2));
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

  login() async {
    int loginType = 1;
    String password = '';
    final account = accountCtrl.text.trim();
    if (usePhone.value) {
      if (account.isEmpty) {
        Toast.showError('请输入手机号'.tr);
        return false;
      }
    } else {
      if (account.isEmpty) {
        Toast.showError('请输入邮箱号'.tr);
        return false;
      }
    }
    if (usePassword.value) {
      if (passwordCtrl.text.isEmpty) {
        Toast.showError('请输入密码'.tr);
        return false;
      }
      password = passwordCtrl.text;
      loginType = 1;
    } else {
      if (passwordCtrl.text.isEmpty) {
        Toast.showError('请输入验证码'.tr);
        return false;
      }
      password = passwordCtrl.text;
      loginType = 2;
    }

    try {
      Toast.showLoading();
      final res = await NetRepository.client.login(LoginRequest(
        account: account,
        captcha: password,
        loginType: loginType,
        password: password,
      ));
      if (res.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg);
        return;
      }
      UserService.to.login(
          AppToken(
            token: res.data.token ?? '',
            expiresAt: res.data.expiresAt ?? 0,
          ),
          res.data.user ?? const User());
      Pusher.getInstance().connect();
      Get.offAllNamed(Routes.APPLICATION);
      Toast.hideLoading();
      Toast.showSuccess("Successful !");
    } catch (e) {
      Toast.hideLoading();
      Toast.showError(e.toString());
    }
  }
}
