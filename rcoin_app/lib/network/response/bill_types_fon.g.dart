// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_types_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillTypesFonImpl _$$BillTypesFonImplFromJson(Map<String, dynamic> json) =>
    _$BillTypesFonImpl(
      code: json['code'] as String?,
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      status: (json['status'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$BillTypesFonImplToJson(_$BillTypesFonImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'updatedAt': instance.updatedAt,
    };
