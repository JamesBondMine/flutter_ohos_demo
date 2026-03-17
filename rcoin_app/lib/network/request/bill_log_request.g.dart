// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_log_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillLogRequestImpl _$$BillLogRequestImplFromJson(Map<String, dynamic> json) =>
    _$BillLogRequestImpl(
      billTypeId: (json['billTypeId'] as num?)?.toInt(),
      coinId: (json['coinId'] as num?)?.toInt(),
      endCreatedAt: json['endCreatedAt'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      startCreatedAt: json['startCreatedAt'] as String?,
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BillLogRequestImplToJson(
        _$BillLogRequestImpl instance) =>
    <String, dynamic>{
      'billTypeId': instance.billTypeId,
      'coinId': instance.coinId,
      'endCreatedAt': instance.endCreatedAt,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'startCreatedAt': instance.startCreatedAt,
      'type': instance.type,
    };
