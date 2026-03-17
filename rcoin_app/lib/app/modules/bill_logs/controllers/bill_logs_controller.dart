import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/bill_log_request.dart';
import 'package:otc_app/network/response/bill_types_fon.dart';
import 'package:otc_app/network/response/coin_bills_fon.dart';

class BillLogsController extends GetxController with PagingMixin<CoinBillsFon> {
  RxList<BillTypesFon> billTypes = RxList([]);

  RxInt billType = 0.obs;
  Rx<DateTimeRange?> picked = Rx(null);

  @override
  void onInit() {
    super.onInit();
    fetchBillTypes();
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
    final res = await NetRepository.client.billLogs(BillLogRequest(
      page: page + 1,
      pageSize: 10,
      coinId: 1,
      billTypeId: billType.value,
      startCreatedAt: picked.value?.start.toString(),
      endCreatedAt: picked.value?.end.toString(),
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<CoinBillsFon>, maxCount: res.data.total);
  }

  fetchBillTypes() async {
    final res = await NetRepository.client.billTypes();
    billTypes.addAll(res.data.list);
    if (billTypes.isNotEmpty) {
      billTypes.insert(0, BillTypesFon(id: 0, name: '全部'.tr));
    }
  }
}
