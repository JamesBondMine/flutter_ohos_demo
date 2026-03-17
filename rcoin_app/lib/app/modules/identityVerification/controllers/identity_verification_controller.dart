import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/network/api.dart';

class IdentityVerificationController extends GetxController {
  static IdentityVerificationController get to =>
      Get.put(IdentityVerificationController());
  String pic1 = '';
  String pic2 = '';
  String video = '';

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

  String mediaPhotosRefreshId = "mediaPhotosRefreshId";
  updateMediaPhotosRefresh() {
    update([mediaPhotosRefreshId]);
  }

  Future<AuthModel?> authApplyStateInfo() async {
    AuthModel? res = await Api.loadRealNameAuthInfo();
    return res;
  }

  Future<String> authUploadFiles(File file) async {
    String fname = file.path.split("/").last;
    fname = fname.split(".").first;
    AppResponse res = await Api.uploadWebFile(file, name: fname);
    Map resData = res.data;
    return resData["data"]["url"] ?? "";
  }

  // 申请
  Future<bool> authApplyEvent(Map<String, dynamic> data) async {
    AppResponse? res = await Api.requestRealNameAuth(data);
    return res != null && res.code == 0;
  }
}
