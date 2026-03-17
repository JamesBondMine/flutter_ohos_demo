import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/refresh/paging_mixin.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_payment.dart';
import 'package:otc_app/network/repository.dart';

class PaymentMethodController extends GetxController with PagingMixin<Payment> {
  // RxMap<PaymentType, int> defaultOpen = RxMap<PaymentType, int>({
  //   PaymentType.wechat: 0,
  //   PaymentType.alipay: 0,
  //   PaymentType.bank: 0,
  // });

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

  // resetDefault() {
  //   defaultOpen.value = {
  //     PaymentType.wechat: 0,
  //     PaymentType.alipay: 0,
  //     PaymentType.bank: 0,
  //   };
  // }

  @override
  FutureOr fetchData(int page) async {
    // resetDefault();

    final res = await NetRepository.client.payments(page + 1, 100);
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    var data = res.data.list as List<Payment>;
    // for (var value in data) {
    //   if (value.enable == 1) {
    //     defaultOpen[value.payType] = value.id!;;
    //   }
    // }
    endLoad(data, maxCount: res.data.total);
  }

  String paymentDataListRefreshId = "paymentDataListRefreshId";
  updatePaymentDataListRefresh() {
    update([paymentDataListRefreshId]);
  }

  Future<List<Payment>> requestPaymentData(int page) async {
    List<Payment> dl = [];
    // resetDefault();

    final res = await NetRepository.client.payments(page, 100);
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return dl;
    }

    dl = res.data.list as List<Payment>;
    // for (var value in data) {
    //   if (value.enable == 1) {
    //     defaultOpen[value.payType] = value.id!;;
    //   }
    // }
    // endLoad(data, maxCount: res.data.total);
    return dl;
  }

  Future<List<PaymentType>> fetchPaymentMethods() async {
    final res = await NetRepository.client.paymentMethods(
      1,
    );
    if (res.code != 0) {
      Toast.showError(res.msg);
      return [];
    }
    return (res.data.list as List<TradePayment>)
        .map((e) => PaymentType.fromValue(e.id!))
        .toList();
  }
}
