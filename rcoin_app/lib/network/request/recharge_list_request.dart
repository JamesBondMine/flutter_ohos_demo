// To parse this JSON data, do
//
//     final rechargeListRequest = rechargeListRequestFromJson(jsonString);

import 'dart:convert';


///server_model_fontend_request.RechargeSearch
class RechargeListRequest {
  RechargeListRequest({
    this.page,
    this.pageSize,
    this.state,
  });


  ///页码
  int? page;

  ///每页大小
  int? pageSize;

  ///状态，-1全部，0待付款，1已付款，2已完成，3验证失败，4已取消`
  int? state;

  factory RechargeListRequest.fromRawJson(String str) => RechargeListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RechargeListRequest.fromJson(Map<String, dynamic> json) => RechargeListRequest(
    page: json["page"],
    pageSize: json["pageSize"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "state": state,
  };
}