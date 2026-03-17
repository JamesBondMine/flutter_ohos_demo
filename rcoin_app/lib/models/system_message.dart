// To parse this JSON data, do
//
//     final tradeSystemMessage = tradeSystemMessageFromJson(jsonString);

import 'dart:convert';


///SystemMessage
class SystemMessage {
  SystemMessage({
    this.content,
    this.contentEn,
    this.contentHi,
    this.createdAt,
    this.id,
    this.readState,
    this.title,
    this.titleEn,
    this.titleHi,
    this.tradeId,
    this.type,
    this.updatedAt,
    this.userId,
  });


  ///通知内容
  String? content;
  //通知内容
  String? contentEn;
  //通知内容
  String? contentHi;

  ///创建时间
  String? createdAt;

  ///主键ID
  int? id;

  ///是否已读 0否 1是
  int? readState;

  ///标题
  String? title;
  ///标题
  String? titleEn;
  ///标题
  String? titleHi;

  ///交易ID
  int? tradeId;

  ///消息类型PLACE/TAKE/PAY/RECEIPT 下单/接单/付款/收款
  String? type;

  ///更新时间
  String? updatedAt;

  ///用户ID
  int? userId;

  factory SystemMessage.fromRawJson(String str) => SystemMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemMessage.fromJson(Map<String, dynamic> json) => SystemMessage(
    content: json["content"],
    contentEn: json["contentEn"],
    contentHi: json["contentHi"],
    createdAt: json["CreatedAt"],
    id: json["ID"],
    readState: json["readState"],
    title: json["title"],
    titleEn: json["titleEn"],
    titleHi: json["titleHi"],
    tradeId: json["tradeId"],
    type: json["type"],
    updatedAt: json["updatedAt"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "contentEn": contentEn,
    "contentHi": contentHi,
    "createdAt": createdAt,
    "ID": id,
    "readState": readState,
    "title": title,
    "titleEn": titleEn,
    "titleHi": titleHi,
    "tradeId": tradeId,
    "type": type,
    "updatedAt": updatedAt,
    "userId": userId,
  };
}