import 'package:get/get.dart';

import '../controllers/team_sub_members_controller.dart';

class TeamSubMembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamSubMembersController>(
      () => TeamSubMembersController(),
    );
  }
}
