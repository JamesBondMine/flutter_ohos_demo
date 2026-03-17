import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_statistic_fon.freezed.dart';
part 'user_statistic_fon.g.dart';


///trade.UserStatisticFon
@freezed
class UserStatisticFon with _$UserStatisticFon {
  const factory UserStatisticFon({
    double? contribution,
    String? CreatedAt,
    String? userStatisticFonCreatedAt,
    int? directReferral,
    String? headerImg,
    int? id,
    int? direct,
    int? indirectReferral,
    String? nickName,
    double? todayContribution,
    double? commission,
    double? payCommission,
    String? updatedAt,
    int? userId,
    String? username,
    double? yesterdayContribution,
  }) = _UserStatisticFon;

  factory UserStatisticFon.fromJson(Map<String, dynamic> json) => _$UserStatisticFonFromJson(json);
}