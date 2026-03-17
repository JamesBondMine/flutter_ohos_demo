import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'send_captcha_request.freezed.dart';

part 'send_captcha_request.g.dart';

@freezed
class SendCaptchaRequest with _$SendCaptchaRequest {
  const factory SendCaptchaRequest({
    required String account,
    String? areaCode,
    required int captchaType, //验证码类型 1短信 2邮箱
    required int scene, //发送场景 1注册 2登录 3重置密码
  }) = _SendCaptchaRequest;

  factory SendCaptchaRequest.fromJson(Map<String, Object?> json) =>
      _$SendCaptchaRequestFromJson(json);
}
