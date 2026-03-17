import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/network/request/bind_google_auth_request.dart';
import 'package:otc_app/service.dart';

class DeleteGoogleAuthController extends GetxController {
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

  deleteSecret() async {
    final res = await NetRepository.client.deleteGoogleSecret(BindGoogleAuthRequest(
      captcha:captcha
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    await UserService.to.reFetchUser();
    ApplicationController.to.backHome(Routes.MINE);
  }
}
