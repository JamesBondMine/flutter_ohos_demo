import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'update_user_info_request.freezed.dart';
part 'update_user_info_request.g.dart';

@freezed
class UpdateUserInfoRequest with _$UpdateUserInfoRequest {
  const factory UpdateUserInfoRequest({
    String? headerImg,
    String? nickName,
  }) = _UpdateUserInfoRequest;

  factory UpdateUserInfoRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateUserInfoRequestFromJson(json);
}
