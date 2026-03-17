// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bind_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BindAccountRequestImpl _$$BindAccountRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$BindAccountRequestImpl(
      account: json['account'] as String?,
      areaCode: json['areaCode'] as String?,
      bindType: (json['bindType'] as num?)?.toInt(),
      captcha: json['captcha'] as String?,
    );

Map<String, dynamic> _$$BindAccountRequestImplToJson(
        _$BindAccountRequestImpl instance) =>
    <String, dynamic>{
      'account': instance.account,
      'areaCode': instance.areaCode,
      'bindType': instance.bindType,
      'captcha': instance.captcha,
    };
