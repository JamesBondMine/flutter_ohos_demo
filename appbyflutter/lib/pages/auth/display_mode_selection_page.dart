import 'dart:convert';
import 'dart:io';

import 'package:appbyflutter/controllers/auth_controller.dart';
import 'package:appbyflutter/core/config/app_config.dart';
import 'package:appbyflutter/core/constants/app_constants.dart';
import 'package:appbyflutter/pages/auth/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/controllers/display_mode_controller.dart';
import 'package:appbyflutter/core/theme/display_mode.dart';
import 'package:quickpass_yidun_flutter/quickpass_yidun_flutter.dart';

enum OperationStatus {
  initial, // Represents 默认 (default)
  success, // Represents 成功
  failure, // Represents 失败
}

/// 首次启动（或未选过模式）时的「普通模式 / 长辈模式」选择页
/// 选择后进入登录页或首页（由登录状态决定）
class DisplayModeSelectionPage extends StatefulWidget {
  const DisplayModeSelectionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return DisplayModeSelectionPageState();
  }
}

class DisplayModeSelectionPageState extends State<DisplayModeSelectionPage> {
  // 易盾
  final QuickpassFlutterPlugin quickLoginPlugin = QuickpassFlutterPlugin();

  final _eventChannel =
      const EventChannel("yd_quicklogin_flutter_event_channel");

  // 易盾 AppKey
  String get _yidunAppKey => Platform.isAndroid
      ? AppConfig.yidunAndroidAppKey
      : AppConfig.yidunIosAppKey;

  // 易盾状态
  OperationStatus _yidunStatus = OperationStatus.initial;

  // token
  String _ydToken = '';

  // accessToken
  String _ydAccessToken = '';

  @override
  void initState() {
    super.initState();
    _initAndCheckVerifyEnable();
    _eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DisplayModeController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ModeCard(
                title: '普通模式',
                subtitle: '标准字体，适合日常使用',
                icon: 'model1.png',
                onTap: () {
                  controller.selectAndConfirm(DisplayMode.normal);
                  if (_yidunStatus == OperationStatus.success) {
                    // 启动一键登录
                    _quickLogin();
                    return;
                  }
                  Get.to(() => LoginPage());
                },
              ),
              SizedBox(height: 36.h),
              _ModeCard(
                title: '长辈模式',
                subtitle: '更大字体，阅读更轻松',
                icon: 'model2.png',
                onTap: () {
                  controller.selectAndConfirm(DisplayMode.elder);
                  if (_yidunStatus == OperationStatus.success) {
                    // 启动一键登录
                    _quickLogin();
                    return;
                  }
                  Get.to(() => LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initAndCheckVerifyEnable() {
    _isInitSuccess(() {
      _checkVerifyEnable(() {
        _preLogin(() {
          _yidunStatus = OperationStatus.success;
        }, () {
          _yidunStatus = OperationStatus.failure;
        });
      }, () {
        _yidunStatus = OperationStatus.failure;
      });
    }, () {
      _yidunStatus = OperationStatus.failure;
    });
  }

  void _isInitSuccess(VoidCallback success, VoidCallback failure) {
    quickLoginPlugin.init(_yidunAppKey, 4, true).then((map) {
      final result = map?[AppConstants.resultKeySuccess];
      setState(() {
        if (result == true) {
          success();
        } else {
          if (kDebugMode) {
            print("❌❌❌❌❌❌❌❌❌❌ sdk 初始换失败");
          }
          failure();
        }
      });
    });
  }

  void _checkVerifyEnable(VoidCallback success, VoidCallback failure) {
    quickLoginPlugin.checkVerifyEnable().then((map) {
      final result = map?[AppConstants.resultKeySuccess];
      setState(() {
        if (result == true) {
          success();
        } else {
          if (kDebugMode) {
            print("❌❌❌❌❌❌❌❌❌❌ 当前网络环境【不支持认证】！");
          }
          failure();
        }
      });
    });
  }

  Future<void> _preLogin(VoidCallback success, VoidCallback failure) async {
    final map = await quickLoginPlugin.preFetchNumber();
    if (map?[AppConstants.resultKeySuccess] == true) {
      _ydToken = map?['token'];
      success();
    } else {
      final errorMsg = map?['errorMsg'];
      if (kDebugMode) {
        print('❌❌❌❌❌❌❌❌❌❌ 取号失败, 出错原因:$errorMsg');
      }
      failure();
    }
  }

  void _quickLogin() {
    final file = Platform.isIOS
        ? "asserts/ios-light-config.json"
        : "asserts/android-light-config.json";
    rootBundle.loadString(file).then((value) async {
      final configMap = {"uiConfig": json.decode(value)};
      quickLoginPlugin.setUiConfig(configMap);
      final map = await quickLoginPlugin.onePassLogin();
      if (map?[AppConstants.resultKeySuccess] == true) {
        _ydAccessToken = map?["accessToken"];
        if (kDebugMode) {
          print("✅✅✅✅✅✅✅✅✅✅ 取号成功, 运营商授权码:$_ydAccessToken");
        }
        quickLoginPlugin.closeLoginAuthView();
        Get.find<AuthController>().setLoggedIn(true); 
      } else {
        final errorMsg = map?["msg"];
        if (kDebugMode) {
          print("❌❌❌❌❌❌❌❌❌❌ 取号失败, 出错原因:$errorMsg");
        }
        quickLoginPlugin.closeLoginAuthView();
      }
    });
  }


  void _onData(dynamic response) {
    if (response is Map) {
      final type = response["type"];
      final action = response["action"];
      if (action == "handleCustomLabel" || action == "otherLogin") {
        quickLoginPlugin.clearScripCache();
        quickLoginPlugin.closeLoginAuthView();
        Get.to(() => LoginPage());
      } else if (type == "uiCallback") {
        if (action == "handleCustomEvent2") {
          quickLoginPlugin.authLoginButtonClick();
        } else if (action == "handleCustomEvent3") {
          quickLoginPlugin.checkedSelected("true");
        } else if (action == "otherLogin") {
          quickLoginPlugin.clearScripCache();
        }
      } else if (type == "login") {
        final cancel = response["cancel"];
        if (cancel == true) {
          quickLoginPlugin.closeLoginAuthView();
        }
      }
    }
  }

  void _onError(dynamic error) {
    debugPrint('Received error: $error');
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          child: Image.asset(
            'asserts/images/$icon',
            fit: BoxFit.cover,
            height: 144.h,
          ),
        ),
      ),
    );
  }
}
