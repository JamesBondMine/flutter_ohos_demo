import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_user_commission.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';

class AgentSettingPageController extends GetxController
    with StateMixin<List<TradeUserCommission>> {
  final detail = Get.arguments['detail'] as UserStatisticFon;

  // late Map<PaymentType, Rx<TradeUserCommission>> commissions;

  @override
  void onInit() {
    freshCommission();

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

  freshCommission() async {
    final res = await NetRepository.client.getUserCommission(detail.userId!);
    if (res.code != 0) {
      // Toast.showError(res.msg);
      return;
    }
    var list = res.data as List<TradeUserCommission>;

    change(list, status: RxStatus.success());
  }
}
