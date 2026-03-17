// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageHistoryRequestImpl _$$MessageHistoryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageHistoryRequestImpl(
      id: (json['id'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      targetId: (json['targetId'] as num?)?.toInt(),
      minId: (json['minId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessageHistoryRequestImplToJson(
        _$MessageHistoryRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'targetId': instance.targetId,
      'minId': instance.minId,
    };
