// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_logs_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferLogsRequestImpl _$$TransferLogsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferLogsRequestImpl(
      coinId: (json['coinId'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TransferLogsRequestImplToJson(
        _$TransferLogsRequestImpl instance) =>
    <String, dynamic>{
      'coinId': instance.coinId,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'type': instance.type,
    };
