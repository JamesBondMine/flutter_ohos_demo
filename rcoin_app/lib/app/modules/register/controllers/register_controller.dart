import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/register_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/services/user.dart';

import '../../../../models.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  TextEditingController accountCtrl = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordConfirmCtrl = TextEditingController();
  TextEditingController paypasswordCtrl = TextEditingController();
  TextEditingController paypasswordConfirmCtrl = TextEditingController();
  TextEditingController inviteCtrl = TextEditingController();

  final usePhone = true.obs;
  final areaCode = '+91'.obs;
  Rx<bool> showPassword = true.obs;

  Rx<bool> showPassword1 = true.obs;

  String paypasswordStr = "";
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
    fullName.dispose();
    codeCtrl.dispose();
    passwordCtrl.dispose();
    passwordConfirmCtrl.dispose();
    paypasswordCtrl.dispose();
    paypasswordConfirmCtrl.dispose();
    inviteCtrl.dispose();
    tabController.dispose();
  }

  bool pinFinish = false;
  // 确认密码显示刷新
  String pinConfirmBtnRefreshId = 'pinConfirmBtnRefreshId';

  // 确认密码显示刷新
  updatePinConfirmRefresh() {
    update([pinConfirmBtnRefreshId]);
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
          scene: 1));
      if (res.code != 0) {
        // Toast.showError(res.msg);
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

  next() async {
    final account = accountCtrl.text.trim();
    final nameString = fullName.text.trim();
    final password = passwordCtrl.text.trim();
    final passwordConfirm = passwordConfirmCtrl.text.trim();

    if (usePhone.value) {
      if (account.isEmpty) {
        Toast.showError('请输入正确的手机号码'.tr);
        return false;
      }
    } else {
      if (!GetUtils.isEmail(account)) {
        Toast.showError('请输入正确的邮箱'.tr);
        return false;
      }
    }

    if (nameString.isEmpty) {
      Toast.showError('请输入您的昵称'.tr);
      return false;
    }
    if (password.isEmpty) {
      Toast.showError('请输入您的密码'.tr);
      return false;
    }
    if (passwordConfirm.isEmpty) {
      Toast.showError('请输入您的确认密码'.tr);
      return false;
    }
    if (password != passwordConfirm) {
      Toast.showError('请输入两次密码不一致，请重新输入'.tr);
      return false;
    }
    Get.toNamed(Routes.REGISTERPAY);
  }

  Future register() async {
    final account = accountCtrl.text.trim();
    int captchaType = 1;
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
      final res = await NetRepository.client.register(RegisterRequest(
        areaCode: areaCode.value, // 区号
        captcha: codeCtrl.text.trim(), // 验证码
        confirmPassword: passwordConfirmCtrl.text, // 确认密码
        email: "", // 邮箱
        inviteCode: "", // 邀请码
        passWord: passwordCtrl.text, // 密码
        phone: accountCtrl.text, // 手机号
        registerType: captchaType, // 注册类型
        username: fullName.text, // 用户名
        payPassword: paypasswordStr, // 支付密码
        confirmPayPassword: paypasswordStr, // 确认支付密码
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
      Toast.hideLoading();
      Toast.showSuccess('成功'.tr);
      Get.offAllNamed(Routes.APPLICATION);
    } catch (e) {
      Toast.hideLoading();
      Toast.showError("register error!");
    }
  }
}
