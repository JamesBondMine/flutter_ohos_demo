import 'package:dio/dio.dart';
import 'package:otc_app/app.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_client.dart';
import 'interceptor.dart';
import 'upload_client.dart';

/// 统一处理错误信息
void formatError(e) {
  logger.d(e.toString());
  if (e is Response) {
    Toast.showError(e.statusMessage ?? '');
    return;
  }
  Toast.showError('请求异常');
}

class
NetRepository {
  /// 请求体 (如果域名不一致可以创建多个请求体进行区分)
  static ApiClient client = ApiClient(
    Dio(BaseOptions())
      ..interceptors.addAll([
        NetInterceptor(),
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 900)
      ]),
    baseUrl: Config.host,
  );

  static UploadClient uploadClient = UploadClient(
    Dio(BaseOptions())
      ..interceptors.addAll([
        NetInterceptor(),
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ]),
    baseUrl: Config.host,
  );
}
