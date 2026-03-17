import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class MineController extends GetxController {
  static MineController get to => Get.put(MineController());

  final showAssets = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  // 头像刷新
  String userHeadRefreshId = 'userHeadRefreshId';
  // 头像
  updateUserHeadRefresh() {
    update([userHeadRefreshId]);
  }

  // 认证刷新
  String userAuthRefreshId = 'userAuthRefreshId';
  // 头像
  updateUserAuthRefresh() {
    update([userAuthRefreshId]);
  }
}
