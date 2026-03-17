import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/advertise/controllers/advertise_controller.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/network/request/order_list_request.dart';

class AdvertiseBuyController extends GetxController
    with PagingMixin<PublishOrder> {
  static AdvertiseBuyController get to => Get.put(AdvertiseBuyController());
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
    DateTime start = AdvertiseController.to.dateMap["start"] ?? DateTime.now();
    DateTime end = AdvertiseController.to.dateMap["end"] ?? DateTime.now();
    String startStr = start.toString();
    String endStr = end.toString();
    // startCreatedAt
    Map<String, dynamic> data = {
      "page": page + 1,
      "pageSize": 10,
      "type": PaySide.buy.value,
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

  refreshAction() {}

  // 删选时间
}
