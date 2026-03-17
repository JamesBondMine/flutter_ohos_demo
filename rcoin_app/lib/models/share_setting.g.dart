// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShareSettingImpl _$$ShareSettingImplFromJson(Map<String, dynamic> json) =>
    _$ShareSettingImpl(
      limit: (json['limit'] as num?)?.toDouble(),
      reward: (json['reward'] as num?)?.toDouble(),
      rewardSetting: json['rewardSetting'] as String?,
      shareUrl: json['ShareUrl'] as String?,
    );

Map<String, dynamic> _$$ShareSettingImplToJson(_$ShareSettingImpl instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'reward': instance.reward,
      'rewardSetting': instance.rewardSetting,
      'ShareUrl': instance.shareUrl,
    };
