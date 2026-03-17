// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_pay_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetPayPasswordRequestImpl _$$SetPayPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SetPayPasswordRequestImpl(
      account: json['account'] as String,
      captcha: json['captcha'] as String,
      confirmPayPassword: json['confirmPayPassword'] as String,
      payPassword: json['payPassword'] as String,
    );

Map<String, dynamic> _$$SetPayPasswordRequestImplToJson(
        _$SetPayPasswordRequestImpl instance) =>
    <String, dynamic>{
      'account': instance.account,
      'captcha': instance.captcha,
      'confirmPayPassword': instance.confirmPayPassword,
      'payPassword': instance.payPassword,
    };
