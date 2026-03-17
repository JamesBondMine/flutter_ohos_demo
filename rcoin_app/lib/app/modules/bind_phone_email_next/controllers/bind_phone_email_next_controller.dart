import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/network/repository.dart';
import 'package:otc_app/network/request/bind_account_request.dart';
import 'package:otc_app/network/request/send_captcha_request.dart';
import 'package:otc_app/service.dart';

class BindPhoneEmailNextController extends GetxController {
  final type = Get.arguments['type'] ?? 1;
  final account = Get.arguments['account'] ?? '';
  final areaCode = Get.arguments['areaCode'] ?? '';
  String? captcha;

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

  Future<bool> sendCode() async {
    final res = await NetRepository.client.sendCaptcha(SendCaptchaRequest(
      areaCode: areaCode,
      account: account,
      captchaType: type == 1 ? 1 : 2,
      scene: 4,
    ));
    if (res.code != 0) {
      Toast.showError('验证码验证错误'.tr);
      return false;
    }
    return true;
  }

  postBind() async {
    final res = await NetRepository.client.bindAccount(BindAccountRequest(
      areaCode: areaCode,
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
    Get.until((route) => route.settings.name == Routes.MINE_INFO);
  }
}
