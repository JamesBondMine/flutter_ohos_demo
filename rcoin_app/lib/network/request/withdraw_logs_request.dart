// To parse this JSON data, do
//
//     final withdrawLogsRequest = withdrawLogsRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


///server_model_fontend_request.WithdrawSearch
class WithdrawLogsRequest {
  WithdrawLogsRequest({
    required this.coinId,
    required this.page,
    required this.pageSize,
  });


  ///币种ID
  int? coinId;

  ///页码
  int? page;

  ///每页大小
  int? pageSize;

  WithdrawLogsRequest copyWith({
    int? coinId,
    int? page,
    int? pageSize,
  }) =>
      WithdrawLogsRequest(
        coinId: coinId ?? this.coinId,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
      );

  factory WithdrawLogsRequest.fromRawJson(String str) => WithdrawLogsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawLogsRequest.fromJson(Map<String, dynamic> json) => WithdrawLogsRequest(
    coinId: json["coinId"],
    page: json["page"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "coinId": coinId,
    "page": page,
    "pageSize": pageSize,
  };
}
