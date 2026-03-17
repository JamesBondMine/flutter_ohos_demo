// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagingRequestImpl _$$PagingRequestImplFromJson(Map<String, dynamic> json) =>
    _$PagingRequestImpl(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PagingRequestImplToJson(_$PagingRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
