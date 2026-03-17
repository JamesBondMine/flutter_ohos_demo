import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'bind_account_request.freezed.dart';
part 'bind_account_request.g.dart';

@freezed
class BindAccountRequest with _$BindAccountRequest {
  const factory BindAccountRequest({
    String? account,
    String? areaCode,
    int? bindType,
    String? captcha,
  }) = _BindAccountRequest;

  factory BindAccountRequest.fromJson(Map<String, Object?> json) =>
      _$BindAccountRequestFromJson(json);
}
