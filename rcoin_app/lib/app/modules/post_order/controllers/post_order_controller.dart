import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/request/publish_order_request.dart';

class PostOrderController extends GetxController {
  static PostOrderController get to => Get.put(PostOrderController());

  TextEditingController priceCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController minCtrl = TextEditingController();
  TextEditingController maxCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();

  Rx<List<PaymentType>> payMethods = Rx<List<PaymentType>>([]);
  int coinId = 1;
  PaySide paySide = PaySide.buy; //Get.arguments['type'];

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
    priceCtrl.dispose();
    numberCtrl.dispose();
    minCtrl.dispose();
    maxCtrl.dispose();
    remarkCtrl.dispose();
  }

  // 用户支持的付款方式
  List<PaymentTypeModel> userPaymentList = [];

  // 当前支付方式
  List<PaymentType> selectPaymentList = [];
  // 刷新支付方式
  String orderPostPaymentRefreshId = "orderPostPaymentRefreshId";
  updateOrderPostPaymentRefresh() {
    update([orderPostPaymentRefreshId]);
  }

  publish(int type) async {
    if (payMethods.value.isEmpty) {
      Toast.showSuccess('请选择付款类型'.tr);
      return;
    }

    final price = double.tryParse(priceCtrl.text.trim()) ?? 1;
    final minAmount = double.tryParse(minCtrl.text.trim()) ?? 0;
    final maxAmount = double.tryParse(maxCtrl.text.trim()) ?? 0;
    final number = double.tryParse(numberCtrl.text.trim()) ?? 0;
    final remark = remarkCtrl.text.trim();

    if (maxAmount <= 0) {
      Toast.showSuccess('请输入最大金额'.tr);
      return;
    }
    if (minAmount <= 0) {
      Toast.showSuccess('请输入最小金额'.tr);
      return;
    }
    if (number <= 0) {
      Toast.showSuccess('请输入购买金额'.tr);
      return;
    }

    final res = await NetRepository.client.publishOrder(PublishOrderRequest(
      coinId: coinId,
      maxMoney: maxAmount,
      minMoney: minAmount,
      number: number,
      paymentMethod: payMethods.value.map((data) => data.value).toList(),
      price: price,
      remark: remark,
      type: type,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    Toast.showSuccess('发布成功'.tr);
    Get.toNamed(Routes.POST_ORDER_SUCCESS);
    // Get.back(result: true);
  }
}
