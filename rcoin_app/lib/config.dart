import 'package:otc_app/common/decrypt.dart';
import 'package:otc_app/common/net.dart';
import 'package:otc_app/common/tools/shower.dart';
import 'package:otc_app/models/app_config.dart';
import 'dart:convert';

import 'package:otc_app/network/api.dart';
import 'package:otc_app/support_files/theme_base.dart';
import 'package:otc_app/support_files/theme_light.dart';

const appKey = 'DADA-PAY';

class Config {
  static String appName = 'Gopay';
  static String coinName = 'RSO';
  static String domainUrl = 'api.91pay.in';
  static String _host = 'https://api.91pay.in/api/v1';

  static String get host => _host;

  static PusherConfig _pusherConfig = const PusherConfig(
      apiKey: 'app-key',
      host: 'api.udst.bi',
      wsPort: 6001,
      useTLS: true,
      cluster: '');

  final shower = Shower();

  static BaseTheme? kTheme;

  static PusherConfig get pusherConfig => _pusherConfig;

  static init() async {
    kTheme = LightTheme();
    try {
      // 设置API的域名
      Api.domainUrl = domainUrl;
      // 设push的域名
      _pusherConfig = PusherConfig(
          apiKey: 'app-key',
          host: domainUrl,
          wsPort: 6001,
          useTLS: true,
          cluster: '');

      final config = await fetchConfig();
      print('获取配置成功 $config');
      //域名竞速
      final hosts = config.endpoints.http.dns;
      final (domain, _) = await fetchLatestDomain(
          hosts.map((e) => 'https://$e/api/v1/health').toList());
      print('竞速结果 $domain');
      Api.domainUrl = domain;
      _host = 'https://$domain/api/v1';
      _pusherConfig = PusherConfig(
          apiKey: 'app-key',
          host: domain,
          wsPort: 6001,
          useTLS: true,
          cluster: '');
    } on Exception catch (e) {
      print("竞速结果: error $e");
    }
  }

  static Future<AppConfig> fetchConfig() async {
    print('获取配置 ----------------');
    final (domain, content) = await fetchLatestDomain([
      'https://91pay.s3.ap-south-1.amazonaws.com/dns-conf/conf.txt',
    ]);

    final desContent = aesDecrypt(content, appKey);
    print(domain);
    return AppConfig.fromJson(json.decode(desContent));
  }
}

class PusherConfig {
  final String apiKey;
  final String cluster;
  final String? host;
  final int wsPort;
  final int wssPort;
  final bool? useTLS;

  const PusherConfig({
    required this.apiKey,
    required this.cluster,
    this.host,
    this.wsPort = 80,
    this.wssPort = 443,
    this.useTLS,
  });
}

Config gbs = Config();
