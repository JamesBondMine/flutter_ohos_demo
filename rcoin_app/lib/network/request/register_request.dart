import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  String? areaCode;
  String? captcha;
  String? confirmPassword;
  String? email;
  String? inviteCode;
  String? passWord;
  String? phone;
  int? registerType;
  String? username;
  String ?payPassword;
  String ?confirmPayPassword;

  RegisterRequest({
    this.areaCode,
    this.captcha,
    this.confirmPassword,
    this.email,
    this.inviteCode,
    this.passWord,
    this.phone,
    this.registerType,
    this.username,
    this.payPassword,
    this.confirmPayPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  RegisterRequest copyWith({
    String? areaCode,
    String? captcha,
    String? confirmPassword,
    String? email,
    String? inviteCode,
    String? passWord,
    String? phone,
    int? registerType,
    String? username,
    String? payPassword,
    String? confirmPayPassword,
  }) {
    return RegisterRequest(
      areaCode: areaCode ?? this.areaCode,
      captcha: captcha ?? this.captcha,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      inviteCode: inviteCode ?? this.inviteCode,
      passWord: passWord ?? this.passWord,
      phone: phone ?? this.phone,
      registerType: registerType ?? this.registerType,
      username: username ?? this.username,
      payPassword: payPassword ?? this.payPassword,
      confirmPayPassword:confirmPayPassword ?? this.confirmPayPassword,
    );
  }
}
