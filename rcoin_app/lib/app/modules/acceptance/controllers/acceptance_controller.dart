import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/user_assets_response.dart';
import 'package:otc_app/service.dart';

class AcceptanceController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final showAssets = true.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  acceptSwitch(bool value) async {
    var user = UserService.to.user.value;
    UserService.to.user.value = UserService.to.user.value.copyWith(
      receivingOrders: value ? 1 : 2,
    );
    final res = await NetRepository.client.acceptSwitch({
      'type': value ? 1 : 2,
    });
    if (res.code != 0) {
      Toast.showError(res.msg);
      UserService.to.user.value = user;
    }
  }
}
