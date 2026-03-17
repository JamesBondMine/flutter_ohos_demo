import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/service_button.dart';
import 'package:otc_app/network/response/article.dart';
import 'package:otc_app/network/response/user_assets_response.dart';
import 'package:otc_app/service.dart';
import 'package:otc_app/upgrade.dart';

import '../../../../models/pay_side.dart';
import '../../../../network/request/coinpay_Request.dart';

class ApplicationController extends GetxController {
  static ApplicationController get to => Get.find();
  final navIndex = 0.obs;

  get currentRoute => navs[navIndex.value].$4;

  List<(String, String, String, String)> get navs {
    return [
      ('首页'.tr, Assets.navHome, Assets.navHomeLight, Routes.HOME),
      ('买入'.tr, Assets.homeBuy, Assets.homeBuy, Routes.POST_BUY_ORDER),
      ('消息'.tr, Assets.homeSell, Assets.homeSell, Routes.NOTIFICATIONS),
      ('我的'.tr, Assets.navMine, Assets.navMineLight, Routes.MINE),
    ];
  }

  late PageController pageController;

  Rx<UserAssetsResponse?> assets = Rx(null);

  StreamSubscription<AuthSuccessEvent>? authSuccessSub;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();

    authSuccessSub = AppService.bus.on<AuthSuccessEvent>().listen((event) {
      Toast.showSuccess('身份认证已通过'.tr);
    });
  }

  @override
  void onReady() {
    super.onReady();
    checkUpgrade();
    //悬浮按钮
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Overlay.of(Get.overlayContext!).insert(OverlayEntry(
    //     builder: (BuildContext context) => const FloatingButton(),
    //   ));
    // });
    Get.dialog(NoticeDialogTip(
        'Dear user: Thank you for using Gopay wallet. Please follow our working hours: Monday to Sunday AM10:30-PM10:30'
            .tr));
    UserService.to.setNoticeAlert();
    var lastOpenDate =
        DateTime.fromMillisecondsSinceEpoch(UserService.to.noticeAlert * 1000);

    //公告弹窗
    // if (DateTime.now().format(format: 'yyyy-MM-dd') !=
    //     lastOpenDate.format(format: 'yyyy-MM-dd')) {
    //   fetchAlertNotice().then((Article value) {
    //     Get.dialog(NoticeDialog(value.content ?? ''));
    //     UserService.to.setNoticeAlert();
    //   });
    // }
  }

  @override
  void onClose() {
    pageController.dispose();
    authSuccessSub?.cancel();
    super.onClose();
  }

  backHome(String routeName) {
    Get.toNamed(routeName, id: 1);
    navIndex.value = navs.indexWhere((element) => element.$4 == routeName);
    Get.until((route) => route.settings.name == Routes.APPLICATION);
  }

  fetchAssets() async {
    final res = await NetRepository.client.userAssets();
    if (res.code == 0) {
      assets.value = res.data;
    }
  }

  postUserCoinPay(String scanCode) async {
    //orderSn=161214432825344&amount=100
    if (scanCode.isEmpty) {
      return;
    }
    List<String> scanCodeList = scanCode.split('&');
    //解析orderSn
    String orderSnStr = scanCodeList.first;
    List<String> orderSnList = orderSnStr.split('=');
    String orderSn = orderSnList.last;
    //解析amount
    String amountStr = scanCodeList.last;
    List<String> amountList = amountStr.split('=');
    String amountPStr = amountList.last;
    double amount = double.tryParse(amountPStr) ?? 0;

    Get.toNamed(Routes.ENTER_PIN, arguments: {
      'paySide': PaySide.fromValue(1),
      'onCompleted': (String pin) async {
        CoinPayRequest params = CoinPayRequest(
          orderSn: orderSn,
          money: amount,
          pwd: pin,
        );
        final res = await NetRepository.client.userCoinCoinPay(params);
        int type = 0;
        if (res.code != 0) {
          if (res.code == 80001) {
            type = 1;
          } else {
            type = 2;
          }
          Get.offNamed(Routes.USER_COIN_PAY,
              arguments: {'type': type, 'msg': res.msg, 'amount': amountPStr});
          return;
        }
        Get.offNamed(Routes.USER_COIN_PAY,
            arguments: {'type': type, 'msg': res.msg, 'amount': amountPStr});
      }
    });
  }

  Future<Article> fetchAlertNotice() async {
    final res = await NetRepository.client.getArticle(tag: 'NOTICE_ALERT');
    return res.data;
  }
}
