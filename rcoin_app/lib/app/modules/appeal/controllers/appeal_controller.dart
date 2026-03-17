import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/controllers/order_detail_controller.dart';
import 'package:otc_app/models/list_response.dart';
import 'package:otc_app/models/video_list.dart';
import 'package:otc_app/network/request/appeal_request.dart';
import 'package:otc_app/network/response/trade_ctc_appeal_reason.dart';

class AppealController extends GetxController {
  static AppealController get to => Get.put(AppealController());

  // 图片地址数组
  RxList<String> pics = RxList();
  // 视频地址数组
  RxList<String> videsList = RxList();

  RxList<(String, ImageProvider)> videos = RxList();

  RxList<TradeCtcAppealReason> reasons = RxList();
  TextEditingController reasonController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final int maxPics = 5;
  final int maxVideos = 3;
  int? reasonId;

  //申诉图片数组
  List<File> feedImgs = [];

  //申诉视频数组
  List<File> feedVideos = [];

  //申诉视频封面数组
  List<ImageProvider> videoCovers = [];

  @override
  void onInit() {
    super.onInit();
    fetchAppealReasons();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // 申诉内容字数刷新
  String appealContentNumRefreshId = "appealContentNumRefreshId";
  updateAppealContentNumRefresh() {
    update([appealContentNumRefreshId]);
  }

  // 热门题材刷新
  String appealImagesRefreshId = 'appealImagesRefreshId';

  // 热门题材刷新
  updateAppealImagesRefresh() {
    update([appealImagesRefreshId]);
  }

  @override
  void onClose() {
    super.onClose();
    reasonController.dispose();
    contentController.dispose();
  }

  fetchAppealReasons() async {
    final res = await NetRepository.client.appealReasons();
    reasons
        .addAll((res.data as ListResponse).list as List<TradeCtcAppealReason>);
  }

  Future<bool> postAppeal() async {
    //申诉内容
    if (contentController.text.isEmpty) {
      Toast.showError('输入申诉内容'.tr);
      return false;
    }

    final res = await NetRepository.client.postAppeal(AppealRequest(
      tradeId: Get.find<OrderDetailController>().id,
      reasonId: reasonId,
      content: contentController.text,
      imgs: pics.join(','),
      videoUrls: videsList.join(','),
      // videoUrls: videos.map((element) => element.$1).toList().join(','),
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return false;
    }
    Toast.showSuccess('成功'.tr);
    return true;
  }
}
