import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends GetxController with GetTickerProviderStateMixin {
  static HelpController get to => Get.put(HelpController());
  //TODO: Implement HelpController
  late TabController tabController;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;

  String videoPlayRefreshId = 'videoPlayRefreshId';
  updateVideoPlayRefresh() {
    update([videoPlayRefreshId]);
  }
}
