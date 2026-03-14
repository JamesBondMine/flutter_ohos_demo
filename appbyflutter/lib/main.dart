import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickpass_yidun_flutter/quickpass_yidun_flutter.dart';


void main() => runApp(new MaterialApp(
      title: "易盾号码认证Demo",
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

  String _result = "token=";
  bool _loading = false;

  final QuickpassFlutterPlugin quickLoginPlugin = new QuickpassFlutterPlugin();

  var eventChannel = const EventChannel("yd_quicklogin_flutter_event_channel");

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('易盾一键登录'),
        ),
        body: ModalProgressHUD(child: _buildContent(), inAsyncCall: _loading),
      ),
    );
  }

  void _onData(response) {
    if (response is Map) {
      var type = (response as Map)["type"];
      if (type == "uiCallback") {
        var action = (response as Map)["action"];
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
      child: new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            color: Colors.white,
            child: Text(_result),
            width: 300,
            height: 100,
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CustomButton(
                    onPressed: () {
                      isInitSuccess();
                    },
                    title: "初始化状态"),
                new Text("   "),
                Expanded(
                    child: new CustomButton(
                  onPressed: () {
                    checkVerifyEnable();
                  },
                  title: "网络环境是否支持",
                )),
              ],
            ),
          ),
          new Container(
            child: SizedBox(
              child: new CustomButton(
                onPressed: () {
                  preLogin();
                },
                title: "预取号",
              ),
              width: double.infinity,
            ),
            margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
          ),
          new Container(
            child: SizedBox(
              child: new CustomButton(
                onPressed: () {
                  quickLogin();
                },
                title: "一键登录",
              ),
              width: double.infinity,
            ),
            margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
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

  /// sdk 初始化是否完成
  void isInitSuccess() {
    quickLoginPlugin
        .init("4ff698778def428dadb075e713f13bb3", 4, true)
        .then((map) {
      bool result = map?[f_result_key];
      setState(() {
        if (result) {
          _result = "sdk 初始换成功";
        } else {
          _result = "sdk 初始换失败";
        }
      });
    });
  }

  /// 判断当前网络环境是否可以发起认证
  void checkVerifyEnable() {
    quickLoginPlugin.checkVerifyEnable().then((map) {
      bool result = map?[f_result_key];
      setState(() {
        if (result) {
          _result = "当前网络环境【支持认证】！";
        } else {
          _result = "当前网络环境【不支持认证】！";
        }
      });
    });
  }

  /// 登录预取号
  void preLogin() async {
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
    } else {
      var ydToken = map?['token'];
      var errorMsg = map?['errorMsg'];
      setState(() {
        _loading = false;
        _result = "$errorMsg";
      });
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
        .verifyPhoneNumber("4ff698778def428dadb075e713f13bb3", phoneNumber)
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