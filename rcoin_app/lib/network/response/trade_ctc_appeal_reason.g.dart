// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_ctc_appeal_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeCtcAppealReasonImpl _$$TradeCtcAppealReasonImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCtcAppealReasonImpl(
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradeCtcAppealReasonImplToJson(
        _$TradeCtcAppealReasonImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'updatedAt': instance.updatedAt,
    };
