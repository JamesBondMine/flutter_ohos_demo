import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/user_statistic_team.dart';

class TeamsController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<UserStatisticTeam> statistics = Rx(const UserStatisticTeam());

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchStatistics();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  fetchStatistics() async {
    final res = await NetRepository.client.teamStatistic();
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    statistics.value = res.data;
  }
}
