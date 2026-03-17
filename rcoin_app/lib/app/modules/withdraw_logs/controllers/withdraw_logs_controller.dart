import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/withdraw_logs_request.dart';
import 'package:otc_app/network/response/withdraw_log.dart';

class WithdrawLogsController extends GetxController with PagingMixin<WithdrawLog> {
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


  @override
  FutureOr fetchData(int page) async {
    final res = await NetRepository.client.withdrawLogs(WithdrawLogsRequest(
      page: page + 1,
      pageSize: 10,
     coinId: 1,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    endLoad((res.data.list) as List<WithdrawLog>, maxCount: res.data.total);
  }
}
