import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/system_message.dart';
import 'package:otc_app/network/request/paging_request.dart';

class NotificationsController extends GetxController
    with PagingMixin<SystemMessage> {
  static NotificationsController get to => Get.put(NotificationsController());
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

  // 列表刷新
  String notificationListRefreshId = 'notificationListRefreshId';

  // 列表刷新
  updateNotificationListRefresh() {
    update([notificationListRefreshId]);
  }

  // 顶部刷新
  String notificationTabRefreshId = 'notificationTabRefreshId';

  // 顶部刷新
  updateNotificationTabRefresh() {
    update([notificationTabRefreshId]);
  }

  @override
  FutureOr fetchData(int page) async {
    AppResponse<PagingIndex<SystemMessage>> res =
        await NetRepository.client.systemMessageList(PagingRequest(
      pageSize: 10,
      page: page + 1,
    ));

    endLoad(res.data.list, maxCount: res.data.total);
  }
}
