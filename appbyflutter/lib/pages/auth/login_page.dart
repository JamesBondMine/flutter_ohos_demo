import 'package:appbyflutter/controllers/auth_controller.dart';
import 'package:appbyflutter/core/utils/gbs_color.dart';
import 'package:flutter/material.dart';
import 'package:appbyflutter/widgets/common_back_button.dart';
import 'package:appbyflutter/widgets/custom_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool _agreeProtocol = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  bool get _canLogin =>
      _phoneController.text.isNotEmpty &&
      _codeController.text.isNotEmpty &&
      _agreeProtocol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonBackButton(),
              const SizedBox(height: 40),
              // logo 100 * 100 圆形
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: Image.asset(
                      'asserts/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Expanded(
              //     child:
                   Column (
                // padding: EdgeInsets.all(0),
                children: [
                  _buildInput(),
                ],
              ),
              Spacer(),
              // ),
              _buildProtocol()
            ],
          ),
        ),
      ),
    );
  }

  // 账号部分
  Widget _buildInput() {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 手机号输入框（无边框、无背景）
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: '请输入手机号',
              border: InputBorder.none,
              isDense: true,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 24),

          // 验证码输入 + 获取验证码按钮（都无边框、无背景）
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '请输入验证码',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Obx(() {
                final auth = Get.find<AuthController>();
                final bool disabled =
                    _phoneController.text.isEmpty || auth.isCountingDown;
                final String text = auth.isCountingDown
                    ? '${auth.smsCountdown.value}s'
                    : '获取验证码';
                return TextButton(
                  onPressed: disabled
                      ? null
                      : () {
                          auth.sendSmsCode(_phoneController.text.trim());
                        },
                  child: Text(text),
                );
              }),
            ],
          ),
          const SizedBox(height: 80),
          // 登录按钮，使用自定义按钮组件
          CustomButton(
            text: '登录',
            enabled: _canLogin,
            onPressed: _canLogin
                ? () {
                    _loginWithPhoneCode();
                  }
                : null,
          ),
        ]));
  }

  Future<void> _loginWithPhoneCode() async {
    final auth = Get.find<AuthController>();
    auth.passwordLoginTest();
  }

// 协议勾选
  Widget _buildProtocol() {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Padding(
          padding: EdgeInsetsGeometry.only(right: 24, bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _agreeProtocol = !_agreeProtocol;
                  });
                },
                child: Padding(
                  padding: EdgeInsetsGeometry.only(top: 3, right: 8, left: 24),
                  child: Container(
                    height: 40,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      _agreeProtocol
                          ? 'asserts/images/sel_did.png'
                          : 'asserts/images/sel_none.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                          text: '我已阅读并同意',
                          style: TextStyle(
                              fontSize: 20, color: GbsColors.textColor6)),
                      TextSpan(
                        text: '《用户注册协议》',
                        style: TextStyle(
                            fontSize: 20, color: GbsColors.primaryColor),
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: '《隐私政策》',
                        style: TextStyle(
                            fontSize: 20, color: GbsColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
