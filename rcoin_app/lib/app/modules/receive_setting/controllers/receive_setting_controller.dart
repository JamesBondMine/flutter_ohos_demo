import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_payment.dart';
import 'package:otc_app/network/response/receive_setting.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';

class ReceiveSettingController extends GetxController {
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController minCtrl = TextEditingController();
  TextEditingController maxCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();

  RxList<TradePaymentChannel> selectedChannels =
      RxList<TradePaymentChannel>([]);

  List<PaymentType> get paymentTypes => selectedChannels
      .map((element) => PaymentType.fromValue(element.payMethod!))
      .toList();

  int coinId = 1;
  PaySide paySide = Get.arguments['type'];
  Rx<ReceiveSetting> setting = Rx(const ReceiveSetting());
  List<TradePayment> paymentMethods = [];
  List<TradePaymentChannel> paymentChannels = [];

  Map<int, TradePaymentChannel> get channelMap =>
      paymentChannels.fold({}, (map, item) => map..[item.id!] = item);

  @override
  void onInit() {
    super.onInit();
    fetchPaymentMethods();
    fetchSetting();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    numberCtrl.dispose();
    minCtrl.dispose();
    maxCtrl.dispose();
    remarkCtrl.dispose();
  }

  fetchPaymentChannels() async {
    //1代收 2代付
    final res = await NetRepository.client
        .paymentChannels(type: paySide.value == PaySide.buy.value ? 2 : 1);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    paymentChannels = res.data.list;
  }

  fetchPaymentMethods() async {
    final res = await NetRepository.client.paymentMethods(
      paySide == PaySide.buy ? 2 : 1,
    );
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    paymentMethods = res.data.list;
  }

  fetchSetting() async {
    await fetchPaymentChannels();
    final res = await NetRepository.client.receiveOrderSetting({
      "type": paySide.value,
    });
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    setting.value = res.data;
    numberCtrl.text =
        setting.value.number == 0 ? '' : (setting.value.number?.rtz ?? '');
    minCtrl.text =
        setting.value.minMoney == 0 ? '' : (setting.value.minMoney?.rtz ?? '');
    maxCtrl.text =
        setting.value.maxMoney == 0 ? '' : (setting.value.maxMoney?.rtz ?? '');
    if (setting.value.payMethod?.isNotEmpty ?? false) {
      for (final item in (setting.value.payMethod?.split(',') ?? [])) {
        final channel = channelMap[int.parse(item)];
        if (channel != null) {
          selectedChannels.add(channel);
        }
      }
    }
  }

  updateSetting() async {
    final minAmount = double.tryParse(minCtrl.text.trim()) ?? 0;
    final maxAmount = double.tryParse(maxCtrl.text.trim()) ?? 0;
    final number = double.tryParse(numberCtrl.text.trim()) ?? 0;

    setting.value = setting.value.copyWith(
      number: number,
      minMoney: minAmount,
      maxMoney: maxAmount,
      payMethod: selectedChannels.map((e) => e.id).join(','),
    );

    final res =
        await NetRepository.client.updateReceiveOrderSetting(setting.value);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    Toast.showSuccess('成功'.tr);
  }

  toggleOpen() async {
    final minAmount = double.tryParse(minCtrl.text.trim()) ?? 0;
    final maxAmount = double.tryParse(maxCtrl.text.trim()) ?? 0;
    final number = double.tryParse(numberCtrl.text.trim()) ?? 0;
    setting.value = setting.value.copyWith(
      number: number,
      minMoney: minAmount,
      maxMoney: maxAmount,
      payMethod: selectedChannels.map((e) => e.id).join(','),
      state: setting.value.state == 1 ? 2 : 1,
    );
    final res =
        await NetRepository.client.updateReceiveOrderSetting(setting.value);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    UserService.to.reFetchUser();
  }
}
