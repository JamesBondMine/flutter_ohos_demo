// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppealRequestImpl _$$AppealRequestImplFromJson(Map<String, dynamic> json) =>
    _$AppealRequestImpl(
      content: json['content'] as String?,
      imgs: json['imgs'] as String?,
      reasonId: (json['reasonId'] as num?)?.toInt(),
      tradeId: (json['tradeId'] as num?)?.toInt(),
      videoUrls: json['videoUrls'] as String?,
    );

Map<String, dynamic> _$$AppealRequestImplToJson(_$AppealRequestImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'imgs': instance.imgs,
      'reasonId': instance.reasonId,
      'tradeId': instance.tradeId,
      'videoUrls': instance.videoUrls,
    };
