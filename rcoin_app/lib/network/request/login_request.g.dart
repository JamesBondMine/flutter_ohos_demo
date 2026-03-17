// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      account: json['account'] as String?,
      captcha: json['captcha'] as String?,
      loginType: (json['loginType'] as num?)?.toInt(),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'account': instance.account,
      'captcha': instance.captcha,
      'loginType': instance.loginType,
      'password': instance.password,
    };
