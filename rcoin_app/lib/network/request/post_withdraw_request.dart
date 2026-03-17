import 'dart:convert';

///request.UserWithdraw
class PostWithdrawRequest {
  PostWithdrawRequest({
    required this.account,
    required this.accountType,
    required this.number,
    required this.remark,
    required this.password,
  });

  ///收款账户信息 钱包地址 例 ERC20:0x0000000;
  String? account;

  ///收款账户类型 2钱包地址;
  int? accountType;

  ///数量
  double? number;

  ///备注
  String? remark;
  String? password;

  factory PostWithdrawRequest.fromRawJson(String str) =>
      PostWithdrawRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostWithdrawRequest.fromJson(Map<String, dynamic> json) =>
      PostWithdrawRequest(
        account: json["account"],
        accountType: json["accountType"],
        number: json["number"].toDouble(),
        remark: json["remark"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "accountType": accountType,
        "number": number,
        "remark": remark,
        "password": password,
      };
}
