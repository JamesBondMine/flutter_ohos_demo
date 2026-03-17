import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/coin.dart';
import 'package:otc_app/network/request/transfer_coin_request.dart';
import 'package:otc_app/network/request/transfer_logs_request.dart';
import 'package:otc_app/network/response/trans_fon.dart';

class TransferController extends GetxController {
  static TransferController get to => Get.put(TransferController());
  TextEditingController addressController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController realNumController = TextEditingController();
  Rx<double> realNum = .0.obs;

  Rx<Coin?> coin = Rx(null);

  Rx<int?> filterIndex = Rx<int?>(null);

  StreamSubscription<OrderFilterEvent>? sub;

  @override
  void onInit() {
    super.onInit();
    final address = (Get.arguments ?? {})['address'];
    addressController.text = address ?? '';

    ApplicationController.to.fetchAssets();
    fetchCoinInfo();

    sub = AppService.bus.on<OrderFilterEvent>().listen((event) {
      filterIndex.value = null;
    });
  }

  @override
  void onReady() {
    super.onReady();
    numController.addListener(() async {
      double number = double.tryParse(numController.text.trim()) ?? 0;
      realNum.value = number;
      double fee = await transferFee(number);
      feeController.text = (fee > 0 ? fee : '-').toString();

      realNumController.text = number.rtz;
    });
  }

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
    numController.dispose();
    feeController.dispose();
    realNumController.dispose();
  }

  fetchCoinInfo() async {
    AppResponse<Coin> res = await NetRepository.client.coinInfo(1);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    coin.value = res.data;
  }

  transferFee(double number) async {
    final res = await NetRepository.client.transferFee(1, number);
    return double.parse('${res.data['fee'] ?? 0}');
  }

  transfer(String addressStr, String numStr, VoidCallback success) async {
    final address = addressStr.trim();
    final num = numStr.trim();

    if (address.isEmpty) {
      Toast.showSuccess('输入或粘贴地址'.tr);
      return;
    }
    if (num.isEmpty) {
      Toast.showSuccess('请输入转账金额'.tr);
      return;
    }
    final res = await NetRepository.client.transferCoin(TransferCoinRequest(
      address: address,
      coinId: 1,
      number: double.tryParse(num) ?? 0,
    ));
    if (res.code == 0) {
      Toast.showSuccess('成功'.tr);
      success();
      return;
    }
    Toast.showError(res.msg);
  }

  // 获取第一页转账记录
  Future<List<TransFon>> requestTranslogs(int page) async {
    final res = await NetRepository.client.transferLogs(
        const TransferLogsRequest(page: 1, pageSize: 10, coinId: 1, type: 2));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return [];
    }
    return res.data.list as List<TransFon>;
  }
}
