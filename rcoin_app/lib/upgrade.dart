import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/update_center_view.dart';
import 'package:otc_app/network/request/check_update_request.dart';
import 'package:otc_app/network/response/check_update_response.dart';
import 'package:package_info_plus/package_info_plus.dart';

checkUpgrade() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  final res = await NetRepository.client.needUpgrade(CheckUpdateRequest(
    currentVersion: packageInfo.version,
    device: Platform.isAndroid ? 'android' : 'ios',
    versionType: 'release',
  ));
  final data = res.data as CheckUpdateResponse;
  if (data.needUpgrade!) {
    AppBindInfo version = AppBindInfo();
    version.downUrl = data.url!;
    version.forceUrl = data.url!;
    version.updateText = data.log!;
    version.version = data.version!;
    version.isForce = data.must! ? 1 : 0;
    Get.dialog(
        Container(
          padding: EdgeInsets.only(
              bottom: (Get.height - 600) / 2,
              left: 16,
              right: 16,
              top: (Get.height - 600) / 2),
          child: UpdateCenterView(appBindInfo: version),
        ),
        barrierDismissible: false);
  }
}
