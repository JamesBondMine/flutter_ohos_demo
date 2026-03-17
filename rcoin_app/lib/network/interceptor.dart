import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart'hide Response;
import 'package:otc_app/app.dart';

import '../services/user.dart';

/// 请求拦截相关的处理
class NetInterceptor extends Interceptor {
  NetInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserService.to.token.token;
    final language = Get.locale!.languageCode;
    if (token.isNotEmpty) {
      options.headers['x-token'] = token;
    }
    if (language.isNotEmpty) {
      options.headers['Accept-Language'] = language;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map dataMap;
    if (response.data is Map) {
      dataMap = response.data;
    } else if (response.data is String) {
      dataMap = jsonDecode(response.data);
    } else {
      dataMap = {'code': 0, 'data': response.data, 'msg': 'success'};
    }

    if (dataMap['code'] != 0) {
      if (dataMap['code'] == 60001) {
        AppService.bus.fire(AppNeedToLogin());
      }
      // handler.reject(
      //   DioException(
      //     requestOptions: response.requestOptions,
      //     error: dataMap['msg'],
      //   ),
      //   true,
      // );
      // return;
    }
    response.data = dataMap;
    handler.next(response);
  }
}
