import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/bind_google_auth_request.dart';
import 'package:otc_app/service.dart';

class BindGoogleAuthNextController extends GetxController {
  final String secret = Get.arguments['secret'];
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

  bindSecret() async {
    final res =
        await NetRepository.client.bindGoogleSecret(BindGoogleAuthRequest(
      secret: secret,
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
