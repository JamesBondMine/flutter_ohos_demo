// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_captcha_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendCaptchaRequestImpl _$$SendCaptchaRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendCaptchaRequestImpl(
      account: json['account'] as String,
      areaCode: json['areaCode'] as String?,
      captchaType: (json['captchaType'] as num).toInt(),
      scene: (json['scene'] as num).toInt(),
    );

Map<String, dynamic> _$$SendCaptchaRequestImplToJson(
        _$SendCaptchaRequestImpl instance) =>
    <String, dynamic>{
      'account': instance.account,
      'areaCode': instance.areaCode,
      'captchaType': instance.captchaType,
      'scene': instance.scene,
    };
