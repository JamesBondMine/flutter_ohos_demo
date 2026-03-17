import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/network/request/order_list_request.dart';

class AdvertiseController extends GetxController
    with GetTickerProviderStateMixin, PagingMixin<PublishOrder> {
  static AdvertiseController get to => Get.put(AdvertiseController());

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    dateMap = today();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  // 时间选择结果
  Map<String, DateTime> dateMap = {};

  // 今天
  Map<String, DateTime> today() {
    DateTime startNew = DateTime(
      DateTime.now().year, // 年份
      DateTime.now().month, // 月份
      DateTime.now().day, // 日期
      0, // 小时
      0, // 分钟
      0, // 秒
      0, // 毫秒
    );
    return {"start": startNew, "end": DateTime.now()};
  }

  // 昨天
  Map<String, DateTime> yesterday() {
    DateTime endTime = DateTime(
      DateTime.now().year, // 年份
      DateTime.now().month, // 月份
      DateTime.now().day, // 日期
      0, // 小时
      0, // 分钟
      0, // 秒
      0, // 毫秒
    );
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        endTime.millisecondsSinceEpoch - (3600000 * 24));
    return {"start": startTime, "end": endTime};
  }

  // 本周
  Map<String, DateTime> weekday() {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day - now.weekday + 1);
    DateTime startTime = DateTime(
      monday.year, // 年份
      monday.month, // 月份
      monday.day, // 日期
      0, // 小时
      0, // 分钟
      0, // 秒
      0, // 毫秒
    );
    return {"start": startTime, "end": DateTime.now()};
  }

  // 本月
  Map<String, DateTime> monthday() {
    DateTime startTime = DateTime(
      DateTime.now().year, // 年份
      DateTime.now().month, // 月份
      1, // 日期
      0, // 小时
      0, // 分钟
      0, // 秒
      0, // 毫秒
    );
    return {"start": startTime, "end": DateTime.now()};
  }

  // 时间选择视图
  int timeSelectIndex = 0;
  String adverTimeSelectRefreshId = "adverTimeSelectRefreshId";
  updateAdverTimeSelectRefresh() {
    update([adverTimeSelectRefreshId]);
  }

  @override
  FutureOr fetchData(int page) async {
    dateMap = dateMap.isEmpty ? today() : dateMap;
    DateTime start = dateMap["start"] ?? DateTime.now();
    DateTime end = dateMap["end"] ?? DateTime.now();
    String startStr = start.toString();
    String endStr = end.toString();
    // startCreatedAt
    Map<String, dynamic> data = {
      "page": page + 1,
      "pageSize": 10,
      "type": -1,
      "startCreatedAt": "${startStr.replaceAll(" ", "T")}Z",
      "endCreatedAt": "${endStr.replaceAll(" ", "T")}Z"
    };
    AppResponse res = await Api.requestUserOrderList(data);
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }
    Map dm = res.data;
    List dl = dm["list"] ?? [];
    int total = dm["total"] ?? dl.length;
    endLoad(dl.map((e) => PublishOrder.fromJson(e)).toList(), maxCount: total);
  }
}
