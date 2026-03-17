import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/common/state_mixin.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/request/appeal_request.dart';
import 'package:otc_app/network/request/id_request.dart';
import 'package:otc_app/services/app.dart';
import 'package:otc_app/services/chat_service.dart';

class OrderDetailController extends GetxController
    with StateMixin<TradeDetail> {
  // static OrderDetailController get to => Get.put(OrderDetailController());

  final int id = Get.arguments['id'];

  int? prevStatus;
  Timer? freshTimer;
  StreamSubscription<TradeStateChangedEvent>? sub;

  RxList<String> pics = RxList();
  RxList<String> videos = RxList();

  //视频封面数组
  // List<ImageProvider> videoCovers = [];
  RxList<ImageProvider> videoCover = RxList();

  @override
  void onInit() {
    super.onInit();
    sub = AppService.bus.on<TradeStateChangedEvent>().listen((event) {
      print(event);
      getData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
    freshTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (Get.currentRoute != Routes.ORDER_DETAIL) {
        return;
      }
      final res = await fetchDetail();
      if (res.code != 0) {
        return;
      }
      var detail = res.data as TradeDetail;

      if (state?.id == detail.id &&
          (state?.state != detail.state ||
              state?.appealState != detail.appealState)) {
        AppService.bus
            .fire(TradeStateChangedEvent(id: detail.id!, state: detail.state!));
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    sub?.cancel();
    freshTimer?.cancel();
  }

  // 订单标题
  bool canHelp = false;
  String orderTitle = "";
  String orderTitleRefreshId = "orderTitleRefreshId";
  updateOrderTitleRefresh() {
    update([orderTitleRefreshId]);
  }

  Future<AppResponse<TradeDetail>> fetchDetail() async {
    return await NetRepository.client.tradeDetail(id);
  }

  getData() async {
    //任何主动的操作, 发送交易变更事件
    AppService.bus.fire(TradeEvent(id));

    change(null, status: RxStatus.loading());
    final res = await NetRepository.client.tradeDetail(id);
    if (res.code != 0) {
      change(null, status: RxStatus.error(res.msg.tr));
    } else {
      var detail = res.data as TradeDetail;
      //记录之前的状态, 如果在这个页面中状态发生完成, 显示完成临时画画
      prevStatus ??= detail.state;
      change(detail, status: RxStatus.success());

      if (detail.state == 3 || detail.state == 4) {
        freshTimer?.cancel();
        freshTimer = null;
      }
    }
  }

  confirmOrder() async {
    final res = await NetRepository.client.receivingConfirm(IdRequest(id: id));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    getData();
  }

  confirmPay() async {
    if (pics.isEmpty) {
      Toast.showError('请添加付款凭证'.tr);
      return;
    }
    final res = await NetRepository.client.confirmPay({
      'id': id,
      'imgs': pics.join(","),
      'video': videos.isNotEmpty ? videos.first : ""
    });
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    getData();
  }

  confirmReceipt() async {
    bool? ok = await Get.dialog(ConfirmDialog(
      title: '确认收款吗?'.tr,
      content: '如果你未收到订单的现金。请不要确认订单，否则资金损失，我们不予负责'.tr,
    ));
    if (ok == null || !ok) {
      return;
    }
    final res = await NetRepository.client.receiptConfirm(IdRequest(id: id));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    getData();
  }

  cancelOrder() async {
    final res = await NetRepository.client.cancelTrade(IdRequest(id: id));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Get.back();
    getData();
  }

  cancelAppeal() async {
    final confirm = await Get.dialog(ConfirmDialog(title: '确定取消吗'.tr));
    if (confirm == null || !confirm) {
      return;
    }
    final res = await NetRepository.client.appealCancel(IdRequest(id: id));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    getData();
  }

  postAppeal() async {
    final res = await NetRepository.client.postAppeal(AppealRequest(
      tradeId: id,
      reasonId: 3,
      content: '未收到款'.tr,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Toast.showSuccess('成功'.tr);
    getData();
    // ChatService.to.goChat(-1);
  }
}
