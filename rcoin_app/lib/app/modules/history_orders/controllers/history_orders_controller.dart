import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/models/pay_side.dart';

class HistoryOrdersController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
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

}
