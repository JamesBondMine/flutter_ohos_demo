// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'article.freezed.dart';

part 'article.g.dart';

///.Article
@freezed
class Article with _$Article {
  const factory Article({
    String? content,
    @JsonKey(name: 'CreatedAt') String? createdAt,
    int? id,
    String? tag,
    String? title,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
