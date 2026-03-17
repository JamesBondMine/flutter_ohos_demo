import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide debounce;
import 'package:otc_app/app.dart';
import 'package:otc_app/models/chain_type.dart';
import 'package:otc_app/network/request/recharge_pay_request.dart';
import 'package:otc_app/network/request/recharge_request.dart';
import 'package:otc_app/network/response/system_wallet_fon.dart';

class RechargeController extends GetxController
    with StateMixin<List<SystemWalletFon>> {
  Rx<ChainType> chainType = Rx(ChainType.trc20);
  TextEditingController editingController = TextEditingController();
  TextEditingController hashController = TextEditingController();
  Rx<int?> orderId = Rx(null);
  Rx<String?> equalNum = Rx(null);
  Rx<double?> realNum = Rx(null);

  ScrollController scrollController = ScrollController();

  SystemWalletFon? get currentAddress => state?.firstWhereOrNull(
      (element) => element.protocol == chainType.value.toString());

  int countDown = 600;

  @override
  void onInit() {
    super.onInit();
    fetchAddress();

    editingController.addListener(debounce(calcEqualNum));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    editingController.dispose();
    hashController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  fetchAddress() async {
    final res = await NetRepository.client.rechargeAddress();
    if (res.code == 0) {
      change(res.data.list, status: RxStatus.success());
    } else {
      change([], status: RxStatus.error(res.msg));
    }
  }

  calcEqualNum() async {
    final amount = double.tryParse(editingController.text) ?? 0;
    if (amount == 0) {
      equalNum.value = null;
      return;
    }
    final res = await NetRepository.client.rechargePayAmount(amount);
    if (res.code == 0) {
      equalNum(res.data);
    }
  }

  recharge() async {
    try {
      if (editingController.text.isEmpty) {
        Toast.showInfo('请输入金额'.tr, icon: true);
        return;
      }
      Toast.showLoading();
      final res = await NetRepository.client.recharge(RechargeRequest(
        addressId: currentAddress!.id,
        amount: double.tryParse(editingController.text) ?? 0,
      ));
      Toast.hideLoading();
      if (res.code != 0) {
        Toast.showError(res.msg);
        return;
      }
      orderId.value = res.data['ID'];
      realNum.value = res.data['money'];
      if (orderId.value != null) {
        countDown = 600;
        Get.toNamed(Routes.RECHARGESUBMIT);
      }
    } catch (e) {
      Toast.hideLoading();
    }
  }

  rechargePay() async {
    final res = await NetRepository.client.rechargePay(RechargePayRequest(
      hash: hashController.text.trim(),
      id: orderId.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    Toast.showSuccess('成功'.tr);
  }
}
