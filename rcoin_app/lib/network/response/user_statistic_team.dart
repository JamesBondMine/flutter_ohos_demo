// To parse this JSON data, do
//
//     final userStatisticTeam = userStatisticTeamFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_statistic_team.freezed.dart';
part 'user_statistic_team.g.dart';


///trade.UserStatisticTeam
@freezed
class UserStatisticTeam with _$UserStatisticTeam {
  const factory UserStatisticTeam({
    double? contribution,
    String? createdAt,
    int? directReferral,
    int? id,
    int? indirectReferral,
    double? todayEarnings,
    double? totalEarnings,
    int? totalReferral,
    String? updatedAt,
    int? userId,
    double? yesterdayEarnings,
  }) = _UserStatisticTeam;

  factory UserStatisticTeam.fromJson(Map<String, dynamic> json) => _$UserStatisticTeamFromJson(json);
}