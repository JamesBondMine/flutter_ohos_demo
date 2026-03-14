import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickpass_yidun_flutter/quickpass_yidun_flutter.dart';

void main() => runApp(new MaterialApp(
      title: "木兰App",
      theme: new ThemeData(primaryColor: Colors.white),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 统一 key
  final String f_result_key = "success";

  String phoneNumber = "";
  String _verifyCode = "";

  // 显示结果
  String _result = "token=";

  bool _loading = false;

  /// 任一失败时改为 true，页面展示手机号验证码登录
  bool _usePhoneLogin = false;
  int _countdown = 0;
  Timer? _countdownTimer;

  final QuickpassFlutterPlugin quickLoginPlugin = new QuickpassFlutterPlugin();

  var eventChannel = const EventChannel("yd_quicklogin_flutter_event_channel");

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);

    initAndCheckVerifyEnable();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_usePhoneLogin ? '手机号验证码登录' : '木兰一键登录'),
        ),
        body: ModalProgressHUD(
          child: _usePhoneLogin ? _buildPhoneLoginContent() : _buildContent(),
          inAsyncCall: _loading,
        ),
      ),
    );
  }

  // 初始化 + 查看网络状态是否支持取号
  void initAndCheckVerifyEnable() {
    isInitSuccess(() {
      // 初始化成功
      checkVerifyEnable(() {
        // 网络环境支持
        preLogin(() {
          // 预取号成功 直接去一键登录
          quickLogin();
        }, () {
          // 预取号失败 -> 切到手机号验证码登录
          setState(() => _usePhoneLogin = true);
        });
      }, () {
        // 网络环境不支持 -> 切到手机号验证码登录
        setState(() => _usePhoneLogin = true);
      });
    }, () {
      // 初始化失败 -> 切到手机号验证码登录
      setState(() => _usePhoneLogin = true);
    });
  }

  void _onData(response) {
    if (response is Map) {
      var type = (response as Map)["type"];
      var action = (response as Map)["action"];
      if (action == "handleCustomLabel" || action == "otherLogin") {
        print("点击其他登录方式");
        quickLoginPlugin.clearScripCache();
        // -> 切到手机号验证码登录
        setState(() => _usePhoneLogin = true);
        quickLoginPlugin.closeLoginAuthView();
      } else if (type == "uiCallback") {
        if (action == "handleCustomEvent1") {
          print("点击微信");
        } else if (action == "handleCustomEvent2") {
          print("点击QQ");
          quickLoginPlugin.authLoginButtonClick();
        } else if (action == "handleCustomEvent3") {
          quickLoginPlugin.checkedSelected("true");
          print("点击微博");
        } else if (action == "otherLogin") {
          print("点击其他登录方式");
          quickLoginPlugin.clearScripCache();
        } else if (action == "authViewWillDisappear") {
          print("授权页将要消失");
        } else if (action == "authViewDidDisappear") {
          print("授权页已经消失");
        } else if (action == "authViewDealloc") {
          print("授权页销毁");
        } else if (action == "authViewDidLoad") {
          print("加载授权页");
        } else if (action == "authViewWillAppear") {
          print("授权页将要出现");
        } else if (action == "authViewDidAppear") {
          print("授权页已经出现");
        } else if (action == "backAction") {
          print("点击返回按钮");
        } else if (action == "loginAction") {
          print("点击登录按钮");
        } else if (action == "checkedAction") {
          print("点击复选框");
        } else if (action == "appDPrivacy") {
          print("点击默认协议");
        } else if (action == "appFPrivacy") {
          print("点击第一个协议");
        } else if (action == "appSPrivacy") {
          print("点击第二个协议");
        }
      } else if (type == "login") {
        bool cancel = (response as Map)["cancel"];
        if (cancel == true) {
          quickLoginPlugin.closeLoginAuthView();
        }
      }
    }
  }

  _onError(dynamic error) {
    print('Received error: ${error.message}');
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            color:  Colors.white,
            child: Text(_result),
            width: 300,
            height: 100,
          ),
          new TextField(
            keyboardType: TextInputType.phone,
            maxLines: 1,
            autofocus: false,
            cursorColor: Colors.blue,
            maxLength: 11,
            onChanged: (text) {
              phoneNumber = text;
              print("phone=$text");
            },
            decoration: InputDecoration(
              hintText: "请输入手机号码",
              labelText: "手机号",
              // 未获得焦点下划线设为灰色
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              //获得焦点下划线设为蓝色
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          new Container(
            child: SizedBox(
              child: new CustomButton(
                onPressed: () {
                  verifyPhoneNumber();
                },
                title: "本机校验",
              ),
              width: double.infinity,
            ),
            margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }

  /// 手机号验证码登录 UI
  Widget _buildPhoneLoginContent() {
    return Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 失败原因展示
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
            // 登录表单卡片
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
                                  // TODO: 调用发送验证码接口
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

  void _loginWithPhoneCode() {
    setState(() => _loading = true);
    // TODO: 调用手机号+验证码登录接口，成功/失败后 setState(_loading = false) 并跳转或提示
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录请求: $phoneNumber / $_verifyCode，请对接后端接口')),
        );
      }
    });
  }

  /// sdk 初始化是否完成
  void isInitSuccess(VoidCallback success, VoidCallback failure) {
    quickLoginPlugin
        .init(Platform.isAndroid ? "a5d8be959ecc4f4eb6485ac5765983ca" : "4ff698778def428dadb075e713f13bb3", 4, true)
        .then((map) {
      bool result = map?[f_result_key];
      setState(() {
        if (result) {
          _result = "sdk 初始换成功";
          success();
        } else {
          _result = "sdk 初始换失败";
          // 初始化失败 直接显示手机号验证码登录
          failure();
        }
      });
    });
  }

  /// 判断当前网络环境是否可以发起认证
  void checkVerifyEnable(VoidCallback success, VoidCallback failure) {
    quickLoginPlugin.checkVerifyEnable().then((map) {
      bool result = map?[f_result_key];
      setState(() {
        if (result) {
          _result = "当前网络环境【支持认证】！";
          success();
        } else {
          _result = "当前网络环境【不支持认证】！";
          // 网络环境不支持 直接显示手机号验证码登录
          failure();
        }
      });
    });
  }

  /// 登录预取号
  void preLogin(VoidCallback success, VoidCallback failure) async {
    setState(() {
      _loading = true;
    });
    Map<dynamic, dynamic>? map = await quickLoginPlugin.preFetchNumber();
    if (map?[f_result_key] == true) {
      var ydToken = map?['token'];
      setState(() {
        _loading = false;
        _result = "token = $ydToken";
      });

      // 预取号成功 直接夹在一键登录UI
      success();
    } else {
      var ydToken = map?['token'];
      var errorMsg = map?['errorMsg'];
      setState(() {
        _loading = false;
        _result = "$errorMsg";
      });
      failure();
    }
  }

  void quickLogin() {
    var configMap;
    var param = "";
    String file = "";
    if (Platform.isIOS) {
      file = "asserts/ios-light-config.json";
    } else if (Platform.isAndroid) {
      file = "asserts/android-light-config.json";
    }
    rootBundle.loadString(file).then((value) async {
      configMap = {"uiConfig": json.decode(value)};
      quickLoginPlugin.setUiConfig(configMap);
      Map<dynamic, dynamic>? map = await quickLoginPlugin.onePassLogin();
      if (map?[f_result_key]) {
        var accessToken = map?["accessToken"];
        setState(() {
          _result = "取号成功, 运营商授权码:" + accessToken;
        });
        quickLoginPlugin.closeLoginAuthView();
      } else {
        var errorMsg = map?["msg"];
        setState(() {
          _result = "取号失败, 出错原因:" + errorMsg;
        });
        quickLoginPlugin.closeLoginAuthView();
      }
    });
  }

  void verifyPhoneNumber() {
    quickLoginPlugin
        .verifyPhoneNumber(Platform.isAndroid ? "a5d8be959ecc4f4eb6485ac5765983ca" :  "4ff698778def428dadb075e713f13bb3", phoneNumber)
        .then((map) {
      if (map?[f_result_key]) {
        var accessToken = map?["accessToken"];
        print("运营商token$accessToken");
      } else {
        var errorMsg = map?["msg"];
        print("错误信息$errorMsg");
      }
      var ydToken = map?["ydToken"];
      print("易盾token$ydToken");
    });
  }
}

/// 封装 按钮
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const CustomButton({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return new ElevatedButton(
      onPressed: onPressed,
      child: new Text(
        "$title",
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
