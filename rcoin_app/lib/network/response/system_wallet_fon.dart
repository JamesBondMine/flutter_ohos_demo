// To parse this JSON data, do
//
//     final systemWalletFon = systemWalletFonFromJson(jsonString);

import 'dart:convert';


///trade.SystemWalletFon
class SystemWalletFon {
  SystemWalletFon({
    this.address,
    this.createdAt,
    this.id,
    this.protocol,
    this.serviceUrl,
    this.sort,
    this.state,
    this.updatedAt,
  });


  ///钱包地址
  String? address;

  ///创建时间
  String? createdAt;
  int? id;

  ///协议类型TRC20/ERC20
  String? protocol;
  String? serviceUrl;
  int? sort;
  bool? state;

  ///更新时间
  String? updatedAt;

  factory SystemWalletFon.fromRawJson(String str) => SystemWalletFon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemWalletFon.fromJson(Map<String, dynamic> json) => SystemWalletFon(
    address: json["address"],
    createdAt: json["createdAt"],
    id: json["id"],
    protocol: json["protocol"],
    serviceUrl: json["serviceUrl"],
    sort: json["sort"],
    state: json["state"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "createdAt": createdAt,
    "id": id,
    "protocol": protocol,
    "serviceUrl": serviceUrl,
    "sort": sort,
    "state": state,
    "updatedAt": updatedAt,
  };
}