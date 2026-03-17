import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/request/id_request.dart';
import 'package:otc_app/network/request/order_trades_request.dart';

class AdvertiseTradesController extends GetxController
    with PagingMixin<TradeDetail> {
  final int id;

  AdvertiseTradesController(this.id);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  FutureOr fetchData(int page) async {
    final res = await NetRepository.client.orderTradeList(OrderTradesRequest(
      id: id,
      page: page + 1,
      pageSize: 10,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<TradeDetail>, maxCount: res.data.total);
  }
}
