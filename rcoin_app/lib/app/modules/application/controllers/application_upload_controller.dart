import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/network/api.dart';
import 'package:path_provider/path_provider.dart';

class ApplicationUploadController extends GetxController {
  static ApplicationUploadController get to =>
      Get.put(ApplicationUploadController());
  // 版本刷新
  String versionInfoRefreshId = 'versionInfoRefreshId';

  //
  updateVersionRefreshEvent() {
    update([versionInfoRefreshId]);
  }

  // 获取新版本安装包
  Future requestApkDownload(
      String url,
      String fileName,
      ValueChanged<double> progress,
      ValueChanged<String> success,
      VoidCallback fail) async {
    try {
      // 获取应用程序的缓存目录
      final directory = await getApplicationDocumentsDirectory();
      // 创建文件路径
      final filePath = '${directory.path}/$fileName';
      Api.downloadApk(url, filePath, (value) {
        progress(value);
        if (value == 1) {
          success(filePath);
        }
      }, () {
        fail();
      });
    } catch (e) {
      fail();
    }
  }
}
