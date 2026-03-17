import 'package:get/get.dart';

import '../controllers/agent_setting_page_controller.dart';

class AgentSettingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentSettingPageController>(
      () => AgentSettingPageController(),
    );
  }
}
