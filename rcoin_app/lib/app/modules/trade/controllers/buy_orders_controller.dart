import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/trade_controller.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/network/request/order_list_request.dart';

class BuyOrdersController extends GetxController
    with PagingMixin<PublishOrder> {
  static BuyOrdersController get to => Get.put(BuyOrdersController());
  Timer? timer;

  OrderFilterEvent filters = OrderFilterEvent();
  StreamSubscription<OrderFilterEvent>? sub;

  @override
  void onInit() {
    super.onInit();
    sub = AppService.bus.on<OrderFilterEvent>().listen((event) {
      filters = event;
      onRefresh();
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    sub?.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    //定时刷新挂单
    timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (ApplicationController.to.currentRoute == Routes.TRADE &&
          Get.currentRoute == Routes.APPLICATION &&
          Get.find<TradeController>().tabController.index == 0) {
        final res = await NetRepository.client.orderList(OrderListRequest(
          page: 1,
          pageSize: 50,
          type: PaySide.sell.value,
        ));
        if (res.code != 0) {
          return;
        }
        final list = res.data.list as List<PublishOrder>;
        final currentIds = items.map((e) => e.id).toSet();
        // final int maxId = items.first.id;
        final newOrders = list
            .where((e) =>
                (!currentIds.contains(e.id)) &&
                (items.isEmpty || e.id > items.first.id))
            .toList();
        if (newOrders.isNotEmpty) {
          updateItems(newOrders + items);
        }
      }
    });
  }

  @override
  FutureOr fetchData(int page) async {
    final res = await NetRepository.client.orderList(OrderListRequest(
      page: page + 1,
      pageSize: 10,
      type: PaySide.sell.value,
      cooperated: filters.cooperated,
      minAmount: filters.minAmount?.toInt(),
      maxAmount: filters.maxAmount?.toInt(),
      paymentMethod: filters.paymentMethods,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<PublishOrder>, maxCount: res.data.total);
  }
}
