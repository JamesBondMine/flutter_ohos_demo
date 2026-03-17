// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadResponseImpl _$$UploadResponseImplFromJson(Map<String, dynamic> json) =>
    _$UploadResponseImpl(
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      key: json['key'] as String?,
      name: json['name'] as String?,
      tag: json['tag'] as String?,
      updatedAt: json['updatedAt'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$UploadResponseImplToJson(
        _$UploadResponseImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'tag': instance.tag,
      'updatedAt': instance.updatedAt,
      'url': instance.url,
    };
