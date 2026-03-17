import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class AccoutBindingController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController emailController;

  bool get haveBindPhone => UserService.to.user.value.phone?.isNotEmpty ?? false;
  bool get haveBindEmail => UserService.to.user.value.email?.isNotEmpty ?? false;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    emailController = TextEditingController();

    phoneController.text = UserService.to.user.value.phone ?? '';
    emailController.text = UserService.to.user.value.email ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
    emailController.dispose();
  }

}
