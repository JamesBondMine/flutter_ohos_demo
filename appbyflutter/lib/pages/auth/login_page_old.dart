import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickpass_yidun_flutter/quickpass_yidun_flutter.dart';

import 'package:appbyflutter/controllers/auth_controller.dart';
import 'package:appbyflutter/core/config/app_config.dart';
import 'package:appbyflutter/core/constants/app_constants.dart';
import 'package:appbyflutter/models/user_model.dart';
import 'package:appbyflutter/widgets/custom_button.dart';
import 'package:get/get.dart';

/// 登录页：一键登录 + 手机号验证码登录
class LoginPageOld extends StatefulWidget {
  const LoginPageOld({super.key});

  @override
  State<LoginPageOld> createState() => _LoginPageOldState();
}

class _LoginPageOldState extends State<LoginPageOld> {
  String phoneNumber = "";
  String _verifyCode = "";
  String _result = "token=";
  bool _loading = false;
  bool _usePhoneLogin = false;
  int _countdown = 0;
  Timer? _countdownTimer;

  /// 用户列表接口返回结果（示例网络请求）
  UserListResult? _userListResult;

  final QuickpassFlutterPlugin quickLoginPlugin = QuickpassFlutterPlugin();
  final _eventChannel =
      const EventChannel("yd_quicklogin_flutter_event_channel");

  String get _yidunAppKey =>
      Platform.isAndroid ? AppConfig.yidunAndroidAppKey : AppConfig.yidunIosAppKey;

  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
    _initAndCheckVerifyEnable();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_usePhoneLogin ? '手机号验证码登录' : '木兰一键登录'),
      ),
      body: ModalProgressHUD(
        child: _usePhoneLogin ? _buildPhoneLoginContent() : _buildContent(),
        inAsyncCall: _loading,
      ),
    );
  }

  void _initAndCheckVerifyEnable() {
    _isInitSuccess(() {
      _checkVerifyEnable(() {
        _preLogin(() {
          _quickLogin();
        }, () {
          setState(() => _usePhoneLogin = true);
        });
      }, () {
        setState(() => _usePhoneLogin = true);
      });
    }, () {
      setState(() => _usePhoneLogin = true);
    });
  }

  void _onData(dynamic response) {
    if (response is Map) {
      final type = response["type"];
      final action = response["action"];
      if (action == "handleCustomLabel" || action == "otherLogin") {
        quickLoginPlugin.clearScripCache();
        setState(() => _usePhoneLogin = true);
        quickLoginPlugin.closeLoginAuthView();
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

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 80),
            child: Text(_result),
          ),
         
          TextField(
            keyboardType: TextInputType.phone,
            maxLines: 1,
            autofocus: false,
            cursorColor: Colors.blue,
            maxLength: 11,
            onChanged: (text) => phoneNumber = text,
            decoration: const InputDecoration(
              hintText: "请输入手机号码",
              labelText: "手机号",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: SizedBox(
              width: double.infinity,
              // child:  CustomButton(
              //   onPressed: _verifyPhoneNumber,
              //   title: "本机校验",
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListSection() {
    final result = _userListResult!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '用户列表（共 ${result.totalElements} 人，当前页 ${result.users.length} 条）',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ...result.users.take(5).map(
                (u) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '${u.username}${u.nickname != null && u.nickname!.isNotEmpty ? " (${u.nickname})" : ""}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
          if (result.users.length > 5)
            Text(
              '... 等共 ${result.users.length} 条',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
        ],
      ),
    );
  }

  /// 调用用户列表接口（完整网络请求示例）
  Future<void> _fetchUserList() async {
    setState(() => _loading = true);
    try {
      final auth = Get.find<AuthController>();
      final resp = await auth.fetchUsersTest();
      if (!mounted) return;
      setState(() {
        _userListResult = null;
        if (resp.isSuccess && resp.data != null) {
          _userListResult = resp.data;
          _result = '用户列表请求成功：共 ${resp.data!.totalElements} 人';
        } else {
          _result = '请求失败：${resp.msg}（code: ${resp.code}）';
        }
      });
    } catch (e, st) {
      if (mounted) {
        setState(() {
          _userListResult = null;
          _result = '请求异常：$e';
        });
      }
      debugPrint('getUsers error: $e\n$st');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildPhoneLoginContent() {
    return Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_result.isNotEmpty && _result != "token=") ...[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: Colors.orange.shade700, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _result,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange.shade900,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '手机号登录',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '请输入手机号并完成验证',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    style: const TextStyle(fontSize: 16),
                    onChanged: (text) => setState(() => phoneNumber = text),
                    decoration: InputDecoration(
                      hintText: "请输入11位手机号",
                      labelText: "手机号",
                      prefixIcon: Icon(Icons.phone_android_outlined,
                          color: Colors.grey.shade600, size: 22),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          style: const TextStyle(fontSize: 16),
                          onChanged: (text) =>
                              setState(() => _verifyCode = text),
                          decoration: InputDecoration(
                            hintText: "验证码",
                            labelText: "验证码",
                            prefixIcon: Icon(Icons.sms_outlined,
                                color: Colors.grey.shade600, size: 22),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 110,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _countdown > 0
                                ? Colors.grey.shade400
                                : Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _countdown > 0
                              ? null
                              : () {
                                  if (phoneNumber.length != 11) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('请输入11位手机号')),
                                    );
                                    return;
                                  }
                                  _startCountdown();
                                },
                          child: Text(
                              _countdown > 0 ? '${_countdown}s' : '获取验证码',
                              style: const TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (phoneNumber.length != 11) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('请输入11位手机号')),
                          );
                          return;
                        }
                        if (_verifyCode.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('请输入验证码')),
                          );
                          return;
                        }
                        _loginWithPhoneCode();
                      },
                      child: const Text('登录',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 300,
              height: 200,
              child: Column(children: [
                 Container(
            margin: const EdgeInsets.fromLTRB(40, 0, 40, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : () => _fetchUserList(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('获取用户列表（示例请求）', style: TextStyle(fontSize: 13)),
              ),
            ),
          ),
          if (_userListResult != null) _buildUserListSection(),
              ],),
            )
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    setState(() => _countdown = 60);
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (_countdown <= 1) {
          _countdown = 0;
          t.cancel();
        } else {
          _countdown--;
        }
      });
    });
  }

  Future<void> _loginWithPhoneCode() async {
    setState(() => _loading = true);
    try {
      final auth = Get.find<AuthController>();
      final resp = await auth.passwordLoginTest();

      if (!mounted) return;
      setState(() => _loading = false);

      if (resp.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录成功：${resp.msg}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('登录失败：${resp.msg}（code: ${resp.code}）'),
          ),
        );
      }
    } catch (e, st) {
      debugPrint('password login error: $e\n$st');
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('请求异常：$e')),
        );
      }
    }
  }

  void _isInitSuccess(VoidCallback success, VoidCallback failure) {
    quickLoginPlugin.init(_yidunAppKey, 4, true).then((map) {
      final result = map?[AppConstants.resultKeySuccess];
      setState(() {
        if (result == true) {
          _result = "sdk 初始换成功";
          success();
        } else {
          _result = "sdk 初始换失败";
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
          _result = "当前网络环境【支持认证】！";
          success();
        } else {
          _result = "当前网络环境【不支持认证】！";
          failure();
        }
      });
    });
  }

  Future<void> _preLogin(VoidCallback success, VoidCallback failure) async {
    setState(() => _loading = true);
    final map = await quickLoginPlugin.preFetchNumber();
    if (map?[AppConstants.resultKeySuccess] == true) {
      final ydToken = map?['token'];
      setState(() {
        _loading = false;
        _result = "token = $ydToken";
      });
      success();
    } else {
      final errorMsg = map?['errorMsg'];
      setState(() {
        _loading = false;
        _result = "$errorMsg";
      });
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
        final accessToken = map?["accessToken"];
        setState(() {
          _result = "取号成功, 运营商授权码:$accessToken";
        });
        quickLoginPlugin.closeLoginAuthView();
        Get.find<AuthController>().setLoggedIn(true);
      } else {
        final errorMsg = map?["msg"];
        setState(() {
          _result = "取号失败, 出错原因:$errorMsg";
        });
        quickLoginPlugin.closeLoginAuthView();
      }
    });
  }

  void _verifyPhoneNumber() {
    quickLoginPlugin.verifyPhoneNumber(_yidunAppKey, phoneNumber).then((map) {
      if (map?[AppConstants.resultKeySuccess] == true) {
        final accessToken = map?["accessToken"];
        debugPrint("运营商token$accessToken");
      } else {
        final errorMsg = map?["msg"];
        debugPrint("错误信息$errorMsg");
      }
      final ydToken = map?["ydToken"];
      debugPrint("易盾token$ydToken");
    });
  }
}
