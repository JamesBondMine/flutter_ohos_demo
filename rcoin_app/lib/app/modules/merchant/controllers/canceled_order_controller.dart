import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/common/refresh/paging_mixin.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/repository.dart';
import 'package:otc_app/network/request/order_list_request.dart';
import 'package:otc_app/network/request/trade_list_request.dart';

import '../../../widgets/fresh_trades_mixin.dart';

class CanceledOrderController extends GetxController with PagingMixin<TradeDetail>, FreshTradesMixin {
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
    final res = await NetRepository.client.tradeList(TradeListRequest(
      page: page + 1,
      pageSize: 10,
      state: 3,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<TradeDetail>, maxCount: res.data.total);
  }
}
