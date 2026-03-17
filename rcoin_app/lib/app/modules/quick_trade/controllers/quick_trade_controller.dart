import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/request/quick_trade_request.dart';

class QuickTradeController extends GetxController {
  final isBuy = true.obs;
  final payMethod = 0.obs;
  final Rx<double> num = 0.0.obs;

  TextEditingController inputController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  final RxDouble usdPrice = .0.obs;

  double get rPrice => usdPrice.value == 0 ? 0 : (1 / usdPrice.value).toPrecision(2);

  @override
  void onInit() {
    super.onInit();
    final PaySide initPaySide = Get.arguments['type'] ?? PaySide.unknown;

    isBuy.value = initPaySide == PaySide.buy;

    inputController.addListener(() {
      num.value = double.tryParse(inputController.text) ?? 0;
    });

    isBuy.listen((isBuy) {
      inputController.clear();
      valueController.clear();
    });

    NetRepository.client.getUsdRate().then((value) {
      usdPrice.value = value.data;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    isBuy.close();
    inputController.dispose();
    valueController.dispose();
  }

  quickTrade(PaymentType paymentType) async {
    AppResponse<TradeDetail> res;
    if (isBuy.value) {
      res = await NetRepository.client.quickBuy(QuickTradeRequest(
        amount: num.value,
        payMethod: paymentType.value,
      ));
    } else {
      res = await NetRepository.client.quickSell(QuickTradeRequest(
        number: num.value,
        payMethod: paymentType.value,
      ));
    }
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    Get.toNamed(Routes.ORDER_DETAIL, arguments: {
      'id': (res.data as TradeDetail).id,
    });
  }
}
