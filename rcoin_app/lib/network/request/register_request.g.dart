// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      areaCode: json['areaCode'] as String?,
      captcha: json['captcha'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      email: json['email'] as String?,
      inviteCode: json['inviteCode'] as String?,
      passWord: json['passWord'] as String?,
      phone: json['phone'] as String?,
      registerType: (json['registerType'] as num?)?.toInt(),
      username: json['username'] as String?,
      payPassword: json['payPassword'] as String?,
      confirmPayPassword: json['confirmPayPassword'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'areaCode': instance.areaCode,
      'captcha': instance.captcha,
      'confirmPassword': instance.confirmPassword,
      'email': instance.email,
      'inviteCode': instance.inviteCode,
      'passWord': instance.passWord,
      'phone': instance.phone,
      'registerType': instance.registerType,
      'username': instance.username,
      'payPassword': instance.payPassword,
      'confirmPayPassword': instance.confirmPayPassword,
    };
