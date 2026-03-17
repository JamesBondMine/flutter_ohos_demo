import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/refresh/paging_mixin.dart';
import 'package:otc_app/network/request/paging_request.dart';
import 'package:otc_app/network/response/brokerage_list_fon.dart';

class TeamRewardController extends GetxController
    with PagingMixin<BrokerageListFon> {


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
    final res = await NetRepository.client.teamRewards(PagingRequest(
      page: page + 1,
      pageSize: 10,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<BrokerageListFon>, maxCount: res.data.total);
  }

}
