import 'package:appbyflutter/core/network/app_http_client.dart';

/// 环境与运行配置（API 基地址、易盾 AppKey 等）
/// 正式环境可通过 --dart-define 或 flavor 区分
class AppConfig {
  AppConfig._();

  /// API 基地址（不含末尾 /）
  static const String baseUrl = 'http://8.155.13.7:8888';

  /// 易盾 Android AppKey（建议从环境变量或 flavor 读取，勿提交敏感值）
  static const String yidunAndroidAppKey = 'a5d8be959ecc4f4eb6485ac5765983ca';

  /// 易盾 iOS AppKey
  static const String yidunIosAppKey = '4ff698778def428dadb075e713f13bb3';

  /// 全局网络客户端（基于 dart:io，统一 code/msg/data 模型）
  static final AppHttpClient httpClient = AppHttpClient(
    baseUrl: baseUrl,
    defaultHeaders: {'Accept': 'application/json'},
  );
}
