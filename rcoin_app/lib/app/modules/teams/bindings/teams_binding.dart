import 'package:get/get.dart';

import 'package:otc_app/app/modules/teams/controllers/team_member_controller.dart';
import 'package:otc_app/app/modules/teams/controllers/team_reward_controller.dart';
import 'package:otc_app/app/modules/teams/controllers/team_rule_controller.dart';

import '../controllers/teams_controller.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamRuleController>(
      () => TeamRuleController(),
    );
    Get.lazyPut<TeamRewardController>(
      () => TeamRewardController(),
    );
    Get.lazyPut<TeamMemberController>(
      () => TeamMemberController(),
    );
    Get.lazyPut<TeamsController>(
      () => TeamsController(),
    );
  }
}
