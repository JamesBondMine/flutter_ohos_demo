import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/recharge_list_request.dart';
import 'package:otc_app/network/response/recharge_res_detail.dart';

class RechargeLogsController extends GetxController
    with GetSingleTickerProviderStateMixin, PagingMixin<RechargeResDetail> {
  static RechargeLogsController get to => Get.put(RechargeLogsController());
  // late TabController tabController;

  int controllerIndex = 0;

  int status = -1;

  @override
  void onInit() {
    // tabController = TabController(length: 4, vsync: this);
    initPaging(status: -1);
    super.onInit();
  }

  @override
  void initPaging({int initPage = 1, isLoadMore = true, int status = -1}) {
    this.status = status;
    super.initPaging(initPage: initPage, isLoadMore: isLoadMore);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // tabController.dispose();
  }

  switchStateQuery(int state) {
    initPaging(status: state);
    onRefresh();
  }

  @override
  FutureOr fetchData(int page) async {
    final res = await NetRepository.client.rechargeList(RechargeListRequest(
      page: page,
      pageSize: 10,
      state: status,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    endLoad((res.data.list) as List<RechargeResDetail>,
        maxCount: res.data.total);
  }
}
