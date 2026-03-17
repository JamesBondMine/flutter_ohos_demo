import 'dart:async';

import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/models/list_response.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/network/response/trade_coin_market_fon.dart';
import 'package:otc_app/network/response/trade_notice_fon.dart';
import 'package:otc_app/network/response/banner.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());
  final showAssets = true.obs;
  RxList<TradeNoticeFon> notices = RxList([]);
  RxList<TradeCoinMarketFon> coins = RxList([]);
  RxList<Banner> banners = RxList([]);

  TradeCoinMarketFon? get rcoinMarket =>
      coins.firstWhereOrNull((element) => element.id == 10);

  List<TradeCoinMarketFon> get marketCoins =>
      coins.where((e) => e.id != 10).toList();

  RxInt unreadCount = 0.obs;

  Timer? timer;

  Rx<Offset> btnOffset = Rx(Offset(310.w, 500.h));
  RxBool btnIsDragging = false.obs;
  final Size _buttonSize = Size(51.w, 192.w);

  bool userAuthent = false; // 实名认证

  bool amountEncryption = false; // 金额加密

  @override
  void onInit() {
    fetchData();
    super.onInit();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (Get.currentRoute == Routes.APPLICATION &&
          ApplicationController.to.currentRoute == Routes.HOME) {
        // fetchMarketCoins();
        fetchUnreadCount();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  fetchData() {
    fetchNoticeList();
    fetchMarketCoins();
    fetchUnreadCount();
    ApplicationController.to.fetchAssets();
    fetchBanners();
  }

  // 近期交易类型
  int remoatTradeType = 0;

  // 更新金额加密状态
  String amountEncryptRefreshId = "amountEncryptRefreshId";
  updateAmountEncryptRefresh() {
    update([amountEncryptRefreshId]);
  }

  fetchNoticeList() async {
    final res = await NetRepository.client.noticeList();
    if (res.code != 0) {
      logger.e('获取公告失败', error: res.msg);
      return;
    }
    var list = ((res.data as ListResponse<TradeNoticeFon>).list
        as List<TradeNoticeFon>);

    notices.clear();
    notices.addAll(list);
  }

  Future<List<TradeCoinMarketFon>> fetchMarketCoins() async {
    final res = await NetRepository.client.marketCoins();
    if (res.code != 0) {
      logger.e('获取行情失败', error: res.msg);
      return [];
    }
    var list = ((res.data as ListResponse<TradeCoinMarketFon>).list
        as List<TradeCoinMarketFon>);

    coins.clear();
    coins.addAll(list);
    return list;
  }

  fetchUnreadCount() async {
    if (!UserService.to.isLogin) {
      return;
    }
    final res = await NetRepository.client.unreadCount();
    unreadCount(res.data);
  }

  fetchBanners() async {
    final res = await NetRepository.client.bannerList();
    banners(((res.data as ListResponse<Banner>).list as List<Banner>));
  }

  void updatePosition(PointerMoveEvent pointerMoveEvent) {
    // var maxTop = Get.window.padding.top / Get.pixelRatio;
    double maxTop = 100;

    double newOffsetX = btnOffset.value.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = btnOffset.value.dy + pointerMoveEvent.delta.dy;

    // 边界检测
    if (newOffsetX < 0) {
      newOffsetX = 0;
    }
    if (newOffsetX > 1.sw - _buttonSize.width) {
      newOffsetX = 1.sw - _buttonSize.width;
    }
    if (newOffsetY < maxTop) {
      newOffsetY = maxTop;
    }
    if (newOffsetY > 1.sh - _buttonSize.height - kBottomNavigationBarHeight) {
      newOffsetY = 1.sh - _buttonSize.height - kBottomNavigationBarHeight;
    }

    btnOffset.value = Offset(newOffsetX, newOffsetY);
  }

  Future<AuthModel?> authApplyStateInfo() async {
    AuthModel? res = await Api.loadRealNameAuthInfo();
    return res;
  }
}
