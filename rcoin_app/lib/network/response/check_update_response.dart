// To parse this JSON data, do
//
//     final checkUpdateResponse = checkUpdateResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'check_update_response.freezed.dart';
part 'check_update_response.g.dart';


///response.VersionUpgradeRes
@freezed
class CheckUpdateResponse with _$CheckUpdateResponse {
  const factory CheckUpdateResponse({
    String? device,
    String? log,
    bool? must,
    bool? needUpgrade,
    String? url,
    String? version,
    String? versionType,
  }) = _CheckUpdateResponse;

  factory CheckUpdateResponse.fromJson(Map<String, dynamic> json) => _$CheckUpdateResponseFromJson(json);
}