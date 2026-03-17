import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/service_online/models/message.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/repository.dart';
import 'package:otc_app/network/request/trade_list_request.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../app/widgets/service_button.dart';
import '../models/publish_order.dart';
import 'user.dart';

/// `event_bus`通知挂载
class AppNeedToLogin {}

class TradeStateChangedEvent {
  final int id;
  final int state;

  TradeStateChangedEvent({required this.id, required this.state});
}

class AuthSuccessEvent {
  final int userId;
  final UserType userType;

  AuthSuccessEvent({required this.userId, required this.userType});
}

class TradeSideEvent {
  final int side;

  TradeSideEvent(this.side);
}

class TradeEvent {
  final int tradeId;

  TradeEvent(this.tradeId);
}

class NewOrderEvent {
  final PublishOrder order;

  NewOrderEvent({required this.order});
}

class OrderFilterEvent {
  int? cooperated;
  double? maxAmount;
  double? minAmount;
  List<int>? paymentMethods;

  OrderFilterEvent(
      {this.cooperated, this.maxAmount, this.minAmount, this.paymentMethods});
}

class ChatMsgEvent {
  final Message message;

  ChatMsgEvent(this.message);
}

class AppService extends GetxService {
  static AppService get to => Get.find();
  bool appIsBackground = false;
  final box = Hive.box('app');
  final RxDouble usdPrice = .0.obs;

  final defaultLocale = const Locale('en', 'US');

  double get rPrice =>
      usdPrice.value == 0 ? 0 : (1 / usdPrice.value).toPrecision(2);
  RxList<TradeDetail> trades = RxList([]);

  Rx<PackageInfo?> packageInfo = Rx(null);

  /// 全局通知
  static EventBus get bus => to._bus;
  final _bus = EventBus();

  final player = AudioPlayer();

  StreamSubscription<TradeEvent>? sub;
  Timer? timer;

  play(String path) {
    if (player.playing) {
      player.stop();
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      player.setUrl(path);
    } else {
      player.setAsset(path);
    }
    player.play();
  }

  @override
  void onInit() {
    FGBGEvents.instance.stream.listen((event) {
      appIsBackground = event == FGBGType.background;
    });
    super.onInit();

    sub = _bus.on<TradeEvent>().listen((event) async {
      fetchTrades();
      if (Get.currentRoute == Routes.ORDER_DETAIL &&
          event.tradeId == Get.arguments['id']) {
        return;
      }
      // openTradeListView();
    });

    PackageInfo.fromPlatform().then((value) => packageInfo.value = value);
  }

  @override
  void onReady() {
    updateUsdPrice();
    // openTradeListView();
  }

  @override
  onClose() {
    super.onClose();
    sub?.cancel();
  }

  openTradeListView() async {
    await fetchTrades();
    if (trades.isNotEmpty &&
        Get.currentRoute != 'tradeListDialog' &&
        UserService.to.user.value.userType == 1) {
      Get.dialog(const TradesDialog(),
          barrierDismissible: false,
          routeSettings: const RouteSettings(
            name: 'tradeListDialog',
          ));
    }
  }

  updateUsdPrice() {
    if (UserService.to.isLogin) {
      NetRepository.client.getUsdRate().then((value) {
        usdPrice.value = value.data;
      });
    }
  }

  fetchTrades() async {
    final res = await NetRepository.client.tradeList(const TradeListRequest(
      page: 1,
      pageSize: 100,
      state: 1,
      sourceType: 1,
    ));
    trades.value = (res.data.list as List<TradeDetail>).where((e) {
      if (e.isBuyer) {
        return [0].contains(e.state);
      }
      return [0, 1].contains(e.state);
    }).toList();
  }

  Locale getLocale() {
    String? locale = box.get('app_locale');
    if (locale != null) {
      var [languageCode, countryCode] = locale.split('_');
      return Locale.fromSubtags(
          languageCode: languageCode, countryCode: countryCode);
    }
    return Get.deviceLocale ?? defaultLocale;
  }

  setLocale(Locale locale) {
    box.put('app_locale', '${locale.languageCode}_${locale.countryCode ?? ''}');
    Get.updateLocale(locale);
  }
}

List<(Locale, String)> locales = [
  (const Locale('en', 'US'), 'English'),
  // (const Locale('zh', 'CN'), '简体中文'),
  (const Locale('hi', 'IN'), 'हिन्दी (Hindi)'),
];
