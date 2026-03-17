import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'dart:convert';

import 'package:otc_app/service.dart';

class BindGoogleAuthController extends GetxController {
  late final String secret;

  @override
  void onInit() {
    super.onInit();
    secret = generateRandomString(16).toUpperCase();
  }

  qrcodeUrl() {
    final userInfo = UserService.to.user.value;

    const String host = 'otc.com';
    final String user =
        (userInfo.phone?.isEmpty ?? true) ? userInfo.email! : userInfo.phone!;

    return "otpauth://totp/$host:$user?secret=$secret&issuer=$host";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
