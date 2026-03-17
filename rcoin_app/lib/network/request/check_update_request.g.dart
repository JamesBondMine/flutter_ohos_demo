// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckUpdateRequestImpl _$$CheckUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckUpdateRequestImpl(
      currentVersion: json['currentVersion'] as String,
      device: json['device'] as String,
      versionType: json['versionType'] as String,
    );

Map<String, dynamic> _$$CheckUpdateRequestImplToJson(
        _$CheckUpdateRequestImpl instance) =>
    <String, dynamic>{
      'currentVersion': instance.currentVersion,
      'device': instance.device,
      'versionType': instance.versionType,
    };
