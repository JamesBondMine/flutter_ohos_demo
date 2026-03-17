// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      content: json['content'] as String?,
      createdAt: json['CreatedAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      tag: json['tag'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'CreatedAt': instance.createdAt,
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
    };
