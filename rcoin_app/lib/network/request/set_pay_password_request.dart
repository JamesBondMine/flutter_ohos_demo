import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'set_pay_password_request.freezed.dart';

part 'set_pay_password_request.g.dart';

@freezed
class SetPayPasswordRequest with _$SetPayPasswordRequest {
  const factory SetPayPasswordRequest({
    required String account,
    required String captcha,
    required String confirmPayPassword,
    required String payPassword,
  }) = _SetPayPasswordRequest;

  factory SetPayPasswordRequest.fromJson(Map<String, Object?> json) =>
      _$SetPayPasswordRequestFromJson(json);
}
