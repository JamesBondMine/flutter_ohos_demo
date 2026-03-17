import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'bind_google_auth_request.freezed.dart';
part 'bind_google_auth_request.g.dart';

@freezed
class BindGoogleAuthRequest with _$BindGoogleAuthRequest {
  const factory BindGoogleAuthRequest({
    String? captcha,
    String? secret,
  }) = _BindGoogleAuthRequest;

  factory BindGoogleAuthRequest.fromJson(Map<String, Object?> json) =>
      _$BindGoogleAuthRequestFromJson(json);
}
