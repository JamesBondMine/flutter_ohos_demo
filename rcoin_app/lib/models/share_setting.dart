// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'share_setting.freezed.dart';
part 'share_setting.g.dart';


///response.ShareRewardSettingRes
@freezed
class ShareSetting with _$ShareSetting {
  const factory ShareSetting({
    double? limit,
    double? reward,
    String? rewardSetting,
    @JsonKey(name: "ShareUrl")
    String? shareUrl,
  }) = _ShareSetting;

  factory ShareSetting.fromJson(Map<String, dynamic> json) => _$ShareSettingFromJson(json);
}
