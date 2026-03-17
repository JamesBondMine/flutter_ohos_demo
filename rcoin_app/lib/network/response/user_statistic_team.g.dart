// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistic_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatisticTeamImpl _$$UserStatisticTeamImplFromJson(
        Map<String, dynamic> json) =>
    _$UserStatisticTeamImpl(
      contribution: (json['contribution'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      directReferral: (json['directReferral'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      indirectReferral: (json['indirectReferral'] as num?)?.toInt(),
      todayEarnings: (json['todayEarnings'] as num?)?.toDouble(),
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble(),
      totalReferral: (json['totalReferral'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      yesterdayEarnings: (json['yesterdayEarnings'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserStatisticTeamImplToJson(
        _$UserStatisticTeamImpl instance) =>
    <String, dynamic>{
      'contribution': instance.contribution,
      'createdAt': instance.createdAt,
      'directReferral': instance.directReferral,
      'id': instance.id,
      'indirectReferral': instance.indirectReferral,
      'todayEarnings': instance.todayEarnings,
      'totalEarnings': instance.totalEarnings,
      'totalReferral': instance.totalReferral,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'yesterdayEarnings': instance.yesterdayEarnings,
    };
