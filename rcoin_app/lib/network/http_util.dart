
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:otc_app/app.dart';
import 'package:otc_app/models/app_response.dart';

String aesKey = "WB0nMZHXlxNndORe";

class HttpUtil {
  static final String GET = "get";
  static final String POST = "post";
  static final String PUT = "put";
  static final String UPLOAD = "upload";
  static final String DELETE = "delete";
  static final String DATA = "data";
  static final String CODE = "code";
  static final String MSG = "msg";

  Dio? dio;
  static HttpUtil? _instance;

  static HttpUtil getInstance() {
    // 已更新
    _instance ??= HttpUtil();
    return _instance!;
  }

  HttpUtil() {
    dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        headers: {
          "BRAND": Platform.isAndroid ? "Android" : "iOS",
          "OS": Platform.operatingSystem,
        }));
  }

  Future<AppResponse> get(String url, {params, bool disheader = false}) async {
    return _requestHttp(url, GET, data: params, disheader: disheader);
  }

  Future<AppResponse> post(String url,
      {data, needToastMessage = false, bool disheader = false}) async {
    return _requestHttp(url, POST,
        data: data, needToastMessage: needToastMessage, disheader: disheader);
  }

  Future<AppResponse> _requestHttp(String url, String method,
      {dynamic data,
      bool needToastMessage = false,
      bool disheader = false}) async {
    var response;
    try {
      Map<String, String> headers = _getUserHeader();
      if (method == POST) {
        response = await http.post(Uri.parse(url),
            headers: headers, body: data != null ? json.encode(data) : null);
      } else if (method == GET) {
        const timeout = Duration(seconds: 30);
        response = await dio!.request(url,
            queryParameters: data,
            options:
                Options(method: GET, headers: headers, sendTimeout: timeout));
        if (response != null && response.data != null) {
          var dataMap = response.data;
          logger.d(
              "********************************\n$url\n$data\n$dataMap\n***********************************************");
          if (url.contains("dns") || url.contains("scan")) {
            return AppResponse(
                code: dataMap[CODE] ?? 200, data: dataMap, msg: "");
          }
          return AppResponse(
              code: dataMap[CODE] ?? 200,
              data: dataMap[DATA] ?? dataMap['result'],
              msg: dataMap["msg"] ?? dataMap["message"]);
        }
      }
      String dataStr = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200 || response.result == 0) {
        Map<String, dynamic> dataMap = json.decode(dataStr);
        logger.d(
            "********************************\n$url\n$data\n$dataMap\n***********************************************");
        return AppResponse(
            code: dataMap[CODE] ?? 200,
            data: dataMap[DATA] ?? dataMap['result'],
            msg: dataMap["message"] ?? dataMap["msg"]);
      } else {
        Map<String, dynamic> dataMap = json.decode(dataStr);
        return AppResponse(
            code: -1, data: dataMap[DATA] ?? dataMap['result'], msg: '网络异常');
      } //
    } catch (e) {
      String log = "\n****************** 错误响应数据 ******************\n";
      log += "message = ${e.toString()}";
      log += "stackTrace = $url \n";
      int code = 4001;
      logger.d(log);
      String errMsg = "加载失败";
      if (e is SocketException) {
        code = 4002;
        errMsg = "网络异常";
        if (needToastMessage) {}
      }
      return AppResponse(code: code, data: {}, msg: errMsg);
    }
  }

  Future download(String url, String savePath, ValueChanged<double> progress,
      VoidCallback fail) async {
    Map<String, String> headers = _getUserHeader();
    try {
      const timeout = Duration(seconds: 30);
      // print("当前下载链接： $url----------------------------------");
      dio!.download(url, savePath, onReceiveProgress: (count, total) {
        progress(count / total);
      }, options: Options(headers: headers, sendTimeout: timeout));
    } catch (e) {
      Toast.hideLoading();
      fail();
    }
  }

  Future<AppResponse> uploadWebFile(
      String url, FormData data, String fileName) async {
    try {
      Map<String, String> headers = _getUserHeader();
      headers["Content-Type"] = 'multipart/form-data';
      final options = Options(
        headers: headers,
      );
      var response = await Dio().post(url, data: data, options: options);
      Toast.hideLoading();
      if (response.data != null) {
        Map<String, dynamic> dataMap = response.data;
        // print(
        //     "当前上传结果： $url---------\n$fileName\n--------------\n$dataMap\n-----------");
        return AppResponse(code: 0, data: dataMap, msg: dataMap["msg"] ?? "");
      }
      print("当前上传失败： $fileName--------1----");
      return const AppResponse(code: -1, data: {}, msg: "fail");
    } catch (e) {
      print("当前上传失败： $fileName------2------");
      return const AppResponse(code: -1, data: {}, msg: "fail！");
    }
  }

  Map<String, String> _getUserHeader() {
    Map<String, String> headers = {};
    try {
      String? androidId = "";
      headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'x-token': UserService.to.token.token,
        "OS": Platform.operatingSystem,
        "androidid": androidId,
        "imei": androidId,
      };
    } catch (e) {
      return headers;
    }
    return headers;
  }
}
