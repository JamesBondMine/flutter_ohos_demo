// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckUpdateResponseImpl _$$CheckUpdateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckUpdateResponseImpl(
      device: json['device'] as String?,
      log: json['log'] as String?,
      must: json['must'] as bool?,
      needUpgrade: json['needUpgrade'] as bool?,
      url: json['url'] as String?,
      version: json['version'] as String?,
      versionType: json['versionType'] as String?,
    );

Map<String, dynamic> _$$CheckUpdateResponseImplToJson(
        _$CheckUpdateResponseImpl instance) =>
    <String, dynamic>{
      'device': instance.device,
      'log': instance.log,
      'must': instance.must,
      'needUpgrade': instance.needUpgrade,
      'url': instance.url,
      'version': instance.version,
      'versionType': instance.versionType,
    };
