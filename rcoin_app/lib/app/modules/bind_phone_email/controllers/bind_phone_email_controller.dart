import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/bind_account_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';

class BindPhoneEmailController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  Rx<String> areaCode = '+91'.obs;
  final type = mapGet(Get.arguments, 'type') ?? 1;
  RxBool btnEnable = false.obs;

  @override
  void onInit() {
    super.onInit();
    textEditingController.addListener(() {
      btnEnable.value = _btnEnable();
    });
    codeController.addListener(() {
      btnEnable.value = _btnEnable();
    });
  }

  _btnEnable() {
    if (type == 1) {
      if (!GetUtils.isPhoneNumber(textEditingController.text)) {
        return false;
      }
    } else {
      if (!GetUtils.isEmail(textEditingController.text)) {
        return false;
      }
    }
    return codeController.text.trim().isNotEmpty;
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
    codeController.dispose();
  }

 Future<bool> sendCaptcha(int type) async {
    final account = textEditingController.text.trim();
    if (type == 1 && !GetUtils.isPhoneNumber(account)) {
      Toast.showError('请输入正确的手机号码'.tr);
      return false;
    }
    if (type == 2 && !GetUtils.isEmail(account)) {
      Toast.showError('请输入正确的邮箱'.tr);
      return false;
    }

    final res = await NetRepository.client.sendCaptcha(SendCaptchaRequest(
      areaCode: areaCode.value,
      account: account,
      captchaType: type == 1 ? 1 : 2,
      scene: 4,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return false;
    }
    return true;
    // Get.toNamed(Routes.BIND_PHONE_EMAIL_NEXT, arguments: {
    //   'type': type,
    //   'account': account,
    //   'areaCode': areaCode.value,
    // });
  }

  postBind() async {
    final account = textEditingController.text.trim();
    final captcha = codeController.text.trim();

    final res = await NetRepository.client.bindAccount(BindAccountRequest(
      areaCode: areaCode.value,
      account: account,
      bindType: type,
      captcha: captcha,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    await UserService.to.reFetchUser();
    Get.until((route) => route.settings.name == Routes.APPLICATION);
  }
}
