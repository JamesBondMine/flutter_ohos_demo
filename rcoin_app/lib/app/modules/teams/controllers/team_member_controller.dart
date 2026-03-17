import 'dart:async';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/request/paging_request.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';

class TeamMemberController extends GetxController
    with PagingMixin<UserStatisticFon> {
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
    final res = await NetRepository.client.myTeamMembers({
      'page': page + 1,
      'pageSize': 10,
    });
    if (res.code != 0) {
      Toast.showError(res.msg);
      endLoad([], maxCount: 0);
      return;
    }

    endLoad(res.data.list as List<UserStatisticFon>, maxCount: res.data.total);
  }
}
