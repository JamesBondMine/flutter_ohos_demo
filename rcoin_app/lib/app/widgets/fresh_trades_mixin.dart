import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import '../../models/trade_detail.dart';


mixin FreshTradesMixin on PagingMixin<TradeDetail>, GetxController {
  StreamSubscription<TradeEvent>? sub;
  Timer? timer;

  @override
  void onInit() {
    sub = AppService.bus.on<TradeEvent>().listen((event) {
      onRefresh();
    });
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
     // AppService.to.openTradeListView();
      onRefresh();
    });
    super.onInit();
  }

  @override
  void onClose() {
    sub?.cancel();
    timer?.cancel();
    super.onClose();
  }
}
