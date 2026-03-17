// import 'dart:io';

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otc_app/app/modules/home/model/home_banner.dart';
// import 'package:get/get.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/app/modules/post_order/controllers/post_order_controller.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/models/user.dart';
import 'package:otc_app/network/http_util.dart';
import 'package:otc_app/network/request/check_update_request.dart';
import 'package:otc_app/network/response/check_update_response.dart';

import 'package:dio/dio.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/services/user.dart';

class Api {
  static String domainUrl = "";

  static String get hostUrl => 'http://$domainUrl/api/v1';

  // 检查是否需要更新
  static Future<CheckUpdateResponse> checckUpgrade(
      CheckUpdateRequest params) async {
    final _data = <String, dynamic>{};
    _data.addAll(params.toJson());
    CheckUpdateResponse result = const CheckUpdateResponse();
    try {
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/version/needUpgrade', data: _data);
      if (res.code == 0) {
        result = CheckUpdateResponse.fromJson(res.data);
      }
      return result;
    } catch (e) {
      return result;
    }
  }

// 获取用户信息
  static Future<User> loadUserInfo() async {
    final _data = <String, dynamic>{};
    User result = const User();
    try {
      AppResponse res = await HttpUtil.getInstance()
          .get('$hostUrl/user/userInfo', params: _data);
      if (res.code == 0) {
        result = User.fromJson(res.data);
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  static Future<List<PaymentTypeModel>> payments() async {
    Map _data = <String, dynamic>{};
    _data["page"] = 1;
    _data["pageSize"] = 12;
    List<PaymentTypeModel> dataList = [];
    try {
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/ctcOrder/enablePaymentList', data: _data);
      if (res.code == 0) {
        Map dataMap = res.data;
        List list = dataMap["list"] ?? [];
        dataList = list.map((e) => PaymentTypeModel.fromjson(e)).toList();
        PostOrderController.to.userPaymentList = dataList;
      }
      return dataList;
    } catch (e) {
      return dataList;
    }
  }

  // 下载apk
  static Future downloadApk(String url, String savePath,
      ValueChanged<double> progress, VoidCallback fail) async {
    HttpUtil.getInstance().download(url, savePath, (value) {
      progress(value);
    }, () {
      fail();
    });
  }

  // 获取认证状态
  static Future<AuthModel?> loadRealNameAuthInfo() async {
    final _data = <String, dynamic>{};
    try {
      AppResponse res = await HttpUtil.getInstance()
          .get('$hostUrl/user/getRealNameAuthInfo', params: _data);
      if (res.code == 0) {
        Map data = res.data;
        return AuthModel.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 实名认证申请
  static Future<AppResponse?> requestRealNameAuth(
      Map<String, dynamic> params) async {
    try {
      Toast.showLoading(message: "loading");
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/user/realNameAuth', data: params);
      Toast.hideLoading();
      if (res.code == 0) {
        Toast.showSuccess("success");
      } else {
        Toast.showError("fail");
      }
      return res;
    } catch (e) {
      Toast.hideLoading();
      Toast.showError("error");
      return null;
    }
  }

  // 上传
  static Future<AppResponse> uploadWebFile(File file,
      {String name = ""}) async {
    try {
      var mfile = await MultipartFile.fromFile(file.path);
      Map<String, dynamic> dm = {"file": mfile};
      FormData formd = FormData.fromMap(dm);
      String url = "$hostUrl/user/upload";
      AppResponse d =
          await HttpUtil.getInstance().uploadWebFile(url, formd, name);
      return d;
    } catch (e) {
      return AppResponse();
    }
  }

  static Future<List<TradeDetail>> requestCtcTradeList(int type) async {
    Map _data = <String, dynamic>{};
    _data["page"] = 1;
    _data["pageSize"] = 10;
    _data["sourceType"] = 0;
    _data["state"] = -1;
    _data["type"] = type;
    List<TradeDetail> dataList = [];
    try {
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/ctcTrade/list', data: _data);
      if (res.code == 0) {
        Map dataMap = res.data;
        List list = dataMap["list"] ?? [];
        dataList = list.map((e) => TradeDetail.fromJson(e)).toList();
      }
      return dataList;
    } catch (e) {
      return dataList;
    }
  }

  // 挂单
  static Future<AppResponse> requestUserOrderList(
      Map<String, dynamic> data) async {
    try {
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/ctcOrder/userOrderList', data: data);
      return res;
    } catch (e) {
      return AppResponse();
    }
  }

  // 挂单
  static Future<AppResponse> requestUserNotificationList(
      Map<String, dynamic> data) async {
    try {
      AppResponse res = await HttpUtil.getInstance()
          .post('$hostUrl/message/systemMessageList', data: data);
      return res;
    } catch (e) {
      return AppResponse();
    }
  }

  // 获取首页海报
  static Future<HomeBanner?> loadBannerListInfo() async {
    final _data = <String, dynamic>{"showType": 2};
    try {
      AppResponse res = await HttpUtil.getInstance()
          .get('$hostUrl/index/bannerList', params: _data);
      if (res.code == 0) {
        Map<String, dynamic> data = res.data;
        List dl = data["list"] ?? [];
        if (dl.isNotEmpty) {
          Map<String, dynamic> fm = dl.first;
          return HomeBanner.fromJson(fm);
        }
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
