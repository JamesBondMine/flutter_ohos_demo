import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/common/refresh/paging_mixin.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/repository.dart';
import 'package:otc_app/network/request/trade_by_payment_request.dart';
import 'package:otc_app/network/response/trade_by_payment.dart';

class IncomeRecordDetailPageController extends GetxController
    with PagingMixin<TradeCtcTradeByPaymentFon> {
  late final RxString day = ''.obs;
  final int paymentType = Get.arguments['paymentType'];

  RxDouble total = .0.obs;

  @override
  void onInit() {
    day(Get.arguments['day']);
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
    final res = await NetRepository.client
        .tradeStatisticByPayment(TradeByPaymentRequest(
      page: page + 1,
      pageSize: 10,
      day: day.value,
      payMethod: paymentType,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }
    total.value = res.data.totalAmount;
    endLoad(res.data.list as List<TradeCtcTradeByPaymentFon>,
        maxCount: res.data.total);
  }
}
