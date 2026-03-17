import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/transfer_logs_request.dart';
import 'package:otc_app/network/response/trans_fon.dart';

class ReceiptLogsController extends GetxController  with PagingMixin<TransFon>{

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
    final res = await NetRepository.client.transferLogs(TransferLogsRequest(
        page: page + 1,
        pageSize: 10,
        coinId: 1,
        type: 1
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<TransFon>, maxCount: res.data.total);
  }
}
