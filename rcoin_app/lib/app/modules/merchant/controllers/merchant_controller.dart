import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MerchantController extends GetxController
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
    tabController.dispose();
  }
}
