import 'dart:convert';

class Banner {
  Banner({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.sort,
    required this.status,
    required this.thumb,
    required this.title,
    required this.updatedAt,
    required this.url,
    required this.urlType,
  });

  ///创建时间
  String? createdAt;

  ///描述
  String? description;

  ///主键ID
  int? id;

  ///排序
  int? sort;

  ///是否显示 0否；1是
  bool? status;

  ///图片地址
  String? thumb;

  ///标题
  String? title;

  ///更新时间
  String? updatedAt;

  ///跳转地址
  String? url;

  ///外部跳转（0否，1是）
  bool? urlType;

  Banner copyWith({
    String? createdAt,
    String? description,
    int? id,
    int? sort,
    bool? status,
    String? thumb,
    String? title,
    String? updatedAt,
    String? url,
    bool? urlType,
  }) =>
      Banner(
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
        id: id ?? this.id,
        sort: sort ?? this.sort,
        status: status ?? this.status,
        thumb: thumb ?? this.thumb,
        title: title ?? this.title,
        updatedAt: updatedAt ?? this.updatedAt,
        url: url ?? this.url,
        urlType: urlType ?? this.urlType,
      );

  factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        createdAt: json["createdAt"],
        description: json["description"],
        id: json["id"],
        sort: json["sort"],
        status: json["status"],
        thumb: json["thumb"],
        title: json["title"],
        updatedAt: json["updatedAt"],
        url: json["url"],
        urlType: json["urlType"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "description": description,
        "id": id,
        "sort": sort,
        "status": status,
        "thumb": thumb,
        "title": title,
        "updatedAt": updatedAt,
        "url": url,
        "urlType": urlType,
      };
}
