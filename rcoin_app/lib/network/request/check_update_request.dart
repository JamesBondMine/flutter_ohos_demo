// To parse this JSON data, do
//
//     final checkUpdateRequest = checkUpdateRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_update_request.freezed.dart';

part 'check_update_request.g.dart';

///request.VersionUpgradeReq
@freezed
class CheckUpdateRequest with _$CheckUpdateRequest {
  const factory CheckUpdateRequest({
    required String currentVersion,
    required String device,
    required String versionType,
  }) = _CheckUpdateRequest;

  factory CheckUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUpdateRequestFromJson(json);
}
