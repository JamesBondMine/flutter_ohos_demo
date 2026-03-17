import 'package:flutter/material.dart';
import 'package:get/get.dart' hide debounce;
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/models/chain_type.dart';
import 'package:otc_app/network/request/post_withdraw_request.dart';
import 'package:otc_app/network/response/withdraw_fee_res.dart';

class WithdrawController extends GetxController {
  Rx<ChainType> chainType = Rx(ChainType.trc20);

  TextEditingController addrCtrl = TextEditingController();
  TextEditingController feeCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController usdtCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();

  bool get publishAvailable =>
      addrCtrl.text.isNotEmpty && double.parse(numberCtrl.text) > 0;

  @override
  void onInit() {
    super.onInit();

    numberCtrl.addListener(debounce(calcEqualNum));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    addrCtrl.dispose();
    numberCtrl.dispose();
    usdtCtrl.dispose();
    remarkCtrl.dispose();
    feeCtrl.dispose();
  }

  calcEqualNum() async {
    final amount = double.tryParse(numberCtrl.text) ?? 0;
    if (amount == 0) {
      usdtCtrl.text = '';
      return;
    }
    final res = await NetRepository.client.withdrawFee(num: amount);
    if (res.code == 0) {
      WithdrawFeeRes data = res.data;
      usdtCtrl.text = data.USDTAmount?.rtz ?? '';
      feeCtrl.text = data.fee?.rtz ?? '';
    } else {
      Toast.showError(res.msg);
    }
  }

  publish() async {
    String? password = await Get.dialog(const PasswordInputDialog());
    if (password == null || password.isEmpty) {
      return;
    }
    var request = PostWithdrawRequest(
      account: '$chainType:${addrCtrl.text.trim()}',
      accountType: 2,
      number: double.parse(numberCtrl.text),
      remark: remarkCtrl.text,
      password: password,
    );
    final res = await NetRepository.client.postWithdraw(request);
    if (res.code == 0) {
      Toast.showSuccess('成功'.tr);
      addrCtrl.clear();
      numberCtrl.clear();
      feeCtrl.clear();
      usdtCtrl.clear();
    }
    Toast.showError(res.msg);
  }
}
