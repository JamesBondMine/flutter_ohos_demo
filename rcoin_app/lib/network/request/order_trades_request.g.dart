// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_trades_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderTradesRequestImpl _$$OrderTradesRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderTradesRequestImpl(
      id: (json['id'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$OrderTradesRequestImplToJson(
        _$OrderTradesRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
