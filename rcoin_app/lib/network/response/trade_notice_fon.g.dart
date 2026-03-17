// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_notice_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeNoticeFonImpl _$$TradeNoticeFonImplFromJson(Map<String, dynamic> json) =>
    _$TradeNoticeFonImpl(
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      synopsis: json['synopsis'] as String?,
      title: json['title'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradeNoticeFonImplToJson(
        _$TradeNoticeFonImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'synopsis': instance.synopsis,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
    };
