import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/payment_method/controllers/payment_method_controller.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_payment.dart';
import 'package:otc_app/network/api_client.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddPaymentController extends GetxController
    with StateMixin<List<TradePaymentChannel>> {
  RxList<TradePaymentChannel> selectedChannels = RxList([]);
  Rx<AssetEntity?> qrcodeImg = Rx(null);

  PaymentType paymentType = Get.arguments['type'] ?? PaymentType.upi;
  Payment? payment = Get.arguments['payment'];

  RxList<TradePayment> paymentMethods = RxList([]);

  TradePayment? get paymentMethod => paymentMethods.isNotEmpty
      ? paymentMethods.firstWhereOrNull((e) => e.id == paymentType.value)
      : null;

  final enable = true.obs;
  TextEditingController accountCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController bankNameCtrl = TextEditingController();

  // TextEditingController minCtrl = TextEditingController();
  TextEditingController maxCtrl = TextEditingController();

  // TextEditingController numCtrl = TextEditingController();

  TextEditingController minPerTxCtrl = TextEditingController();
  TextEditingController maxPerTxCtrl = TextEditingController();

  TextEditingController addressProtocolCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPaymentMethods();
    fetchPaymentChannels();

    logger.e('paymentType======', error: paymentType);
    if (payment != null) {
      enable.value = payment?.enable == 1;
      accountCtrl.text = payment?.account ?? '';
      nameCtrl.text = payment?.name ?? '';
      bankNameCtrl.text = payment?.bankName ?? '';
      maxCtrl.text = (payment?.dayMaxCount?.toString() ?? '100000').rtz;

      minPerTxCtrl.text = (payment?.dayMinAmount?.toString() ?? '').rtz;
      maxPerTxCtrl.text = (payment?.dayMaxAmount?.toString() ?? '100000').rtz;

      addressProtocolCtrl.text = payment?.addressProtocol ?? '';
      addressCtrl.text = payment?.address ?? '';
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    accountCtrl.dispose();
    nameCtrl.dispose();
    bankNameCtrl.dispose();
    // minCtrl.dispose();
    maxCtrl.dispose();
    // numCtrl.dispose();

    minPerTxCtrl.dispose();
    maxPerTxCtrl.dispose();

    addressProtocolCtrl.dispose();
    addressCtrl.dispose();
  }

  String paymentTypeSelectRefreshId = "paymentTypeSelectRefreshId";
  updatePaymentTypeSelectRefresh() {
    update([paymentTypeSelectRefreshId]);
  }

  fetchPaymentChannels() async {
    final res =
        await NetRepository.client.paymentChannels(payWay: paymentType.value);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    logger.e('fetchPaymentChannels======', error: res);
    Map<int, TradePaymentChannel> channelMap =
        (res.data.list as List<TradePaymentChannel>)
            .fold({}, (map, item) => map..[item.id!] = item);
    if (payment?.paymentChannelIds?.isNotEmpty ?? false) {
      for (final item in (payment?.paymentChannelIds?.split(',') ?? [])) {
        final channel = channelMap[int.parse(item)];
        if (channel != null) {
          selectedChannels.add(channel);
        }
      }
    }
    var list = res.data.list as List<TradePaymentChannel>;
    if (list.isNotEmpty) {
      selectedChannels.add(list.first);
    }
    change(res.data.list, status: RxStatus.success());
  }

  Future<String?> getQrUrl() async {
    if (qrcodeImg.value != null) {
      AppResponse<UploadResponse> ret = await NetRepository.uploadClient
          .upload((await qrcodeImg.value?.file)!);
      if (ret.code != 0) {
        Toast.showError(ret.msg);
        return null;
      }
      return ((ret.data as UploadResponse).url);
    }

    return null;
  }

  createData() async {
    try {
      Toast.showLoading(message: "uploading...");
      final url = await getQrUrl();
      final _payment = Payment(
        payMethod: paymentType.value,
        name: nameCtrl.text.trim(),
        account: accountCtrl.text.trim(),
        img: url,
        enable: enable.value ? 1 : 2,
        dayMaxCount: double.tryParse(maxCtrl.text.trim()) ?? 100000,
        dayMinAmount: double.tryParse(minPerTxCtrl.text.trim()) ?? 0,
        dayMaxAmount: double.tryParse(maxPerTxCtrl.text.trim()) ?? 100000,
        addressProtocol: addressProtocolCtrl.text,
        address: addressCtrl.text,
        paymentChannelIds: selectedChannels.map((e) => e.id).join(','),
      );
      final res = await NetRepository.client.createPayment(_payment);
      Toast.hideLoading();
      if (res.code != 0) {
        Toast.showError(res.msg.tr);
        return;
      }
      Toast.showSuccess('添加成功'.tr);
      Get.find<PaymentMethodController>().onRefresh();
      Get.back();
    } catch (e) {
      Toast.hideLoading();
      Toast.showError("error".tr);
    }
  }

  updateData() async {
    final url = await getQrUrl();
    final _payment = Payment(
      id: payment?.id,
      payMethod: paymentType.value,
      name: nameCtrl.text.trim(),
      account: accountCtrl.text.trim(),
      img: url,
      enable: enable.value ? 1 : 2,
      dayMaxCount: double.tryParse(maxCtrl.text.trim()) ?? 100000,
      dayMinAmount: double.tryParse(minPerTxCtrl.text.trim()) ?? 0,
      dayMaxAmount: double.tryParse(maxPerTxCtrl.text.trim()) ?? 100000,
      addressProtocol: addressProtocolCtrl.text ?? '',
      address: addressCtrl.text ?? '',
      paymentChannelIds: selectedChannels.map((e) => e.id).join(','),
    );
    AppResponse res = await NetRepository.client.updatePayment(_payment);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }

    // Toast.showSuccess('修改成功'.tr);
    Get.find<PaymentMethodController>().onRefresh();
    // Get.back();
  }

  fetchPaymentMethods() async {
    final res = await NetRepository.client.paymentMethods();
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    paymentMethods.value = res.data.list;
  }
}
