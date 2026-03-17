// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeListRequestImpl _$$TradeListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeListRequestImpl(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      sourceType: (json['sourceType'] as num?)?.toInt() ?? 0,
      state: (json['state'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TradeListRequestImplToJson(
        _$TradeListRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'sourceType': instance.sourceType,
      'state': instance.state,
      'type': instance.type,
    };
