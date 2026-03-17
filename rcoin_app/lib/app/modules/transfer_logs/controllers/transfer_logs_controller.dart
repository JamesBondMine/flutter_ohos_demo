import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/transfer_logs_request.dart';
import 'package:otc_app/network/response/trans_fon.dart';

class TransferLogsController extends GetxController
    with GetSingleTickerProviderStateMixin, PagingMixin<TransFon> {
  late TabController tabController;
  int type = 2;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    initPaging(type: 2);
    super.onInit();
  }

  @override
  void initPaging({int initPage = 0, isLoadMore = true, int type = 2}) {
    this.type = type;
    super.initPaging(initPage: initPage, isLoadMore: isLoadMore);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  switchStateQuery(int type) {
    initPaging(type: type);
    onRefresh();
  }

  @override
  FutureOr fetchData(int page) async {
    final res = await NetRepository.client.transferLogs(TransferLogsRequest(
        page: page + 1, pageSize: 10, coinId: 1, type: type));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<TransFon>, maxCount: res.data.total);
  }
}
