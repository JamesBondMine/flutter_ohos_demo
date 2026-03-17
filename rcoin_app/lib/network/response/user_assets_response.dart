import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user_assets_response.freezed.dart';
part 'user_assets_response.g.dart';

@freezed
class UserAssetsResponse with _$UserAssetsResponse {
  const factory UserAssetsResponse({
    String? address,
    double? deposit,
    double? money,
    double? todayEarnings,
    double? tradeAmount,
    double? yesterdayEarnings,
  }) = _UserAssetsResponse;

  factory UserAssetsResponse.fromJson(Map<String, Object?> json) =>
      _$UserAssetsResponseFromJson(json);
}
