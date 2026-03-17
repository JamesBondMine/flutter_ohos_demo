// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';


///request.ResetPassword
class ResetPasswordRequest {
  ResetPasswordRequest({
    this.account,
    this.captcha,
    this.confirmPassword,
    this.password,
  });


  ///手机号/邮箱
  String? account;

  ///验证码
  String? captcha;

  ///确认密码
  String? confirmPassword;

  ///密码
  String? password;

  factory ResetPasswordRequest.fromRawJson(String str) => ResetPasswordRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
    account: json["account"],
    captcha: json["captcha"],
    confirmPassword: json["confirmPassword"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "captcha": captcha,
    "confirmPassword": confirmPassword,
    "password": password,
  };
}