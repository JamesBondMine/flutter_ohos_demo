import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/exception_handler.dart';
import 'package:otc_app/network/request/auth_request.dart';

class AuthRoleController extends GetxController {
  TextEditingController nickNameCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController urlCtrl = TextEditingController();

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

    nickNameCtrl.dispose();
    contactCtrl.dispose();
    urlCtrl.dispose();
  }

  auth() async {

      final res = await NetRepository.client.auth(AuthRequest(
        authType: Get.arguments['type'] ?? 1,
        contactInfo: contactCtrl.text,
        nickName: nickNameCtrl.text,
        url: urlCtrl.text,
      ));
      if (res.code != 0) {
        Toast.showError(res.msg);
        return;
      }

      Get.toNamed(Routes.AUTH_RESULT);

  }
}
