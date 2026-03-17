import 'package:json_annotation/json_annotation.dart';
part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  int? authType;
  String? contactInfo;
  String? nickName;
  String? url;

    AuthRequest({
      this.authType,
      this.contactInfo,
      this.nickName,
      this.url,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);

  AuthRequest copyWith({
    int? authType,
    String? contactInfo,
    String? nickName,
    String? url,
  }) {
    return AuthRequest(
      authType: authType ?? this.authType,
      contactInfo: contactInfo ?? this.contactInfo,
      nickName: nickName ?? this.nickName,
      url: url ?? this.url,
    );
  }
}
