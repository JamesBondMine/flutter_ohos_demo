import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app/modules/teams/controllers/team_rule_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeamRule extends GetView<TeamRuleController> {
  const TeamRule({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      var c = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(state ?? '');
      return WebViewWidget(
        controller: c,
      );
    });
  }
}
