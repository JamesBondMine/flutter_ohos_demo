// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistic_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatisticFonImpl _$$UserStatisticFonImplFromJson(
        Map<String, dynamic> json) =>
    _$UserStatisticFonImpl(
      contribution: (json['contribution'] as num?)?.toDouble(),
      CreatedAt: json['CreatedAt'] as String?,
      userStatisticFonCreatedAt: json['userStatisticFonCreatedAt'] as String?,
      directReferral: (json['directReferral'] as num?)?.toInt(),
      headerImg: json['headerImg'] as String?,
      id: (json['id'] as num?)?.toInt(),
      direct: (json['direct'] as num?)?.toInt(),
      indirectReferral: (json['indirectReferral'] as num?)?.toInt(),
      nickName: json['nickName'] as String?,
      todayContribution: (json['todayContribution'] as num?)?.toDouble(),
      commission: (json['commission'] as num?)?.toDouble(),
      payCommission: (json['payCommission'] as num?)?.toDouble(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      username: json['username'] as String?,
      yesterdayContribution:
          (json['yesterdayContribution'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserStatisticFonImplToJson(
        _$UserStatisticFonImpl instance) =>
    <String, dynamic>{
      'contribution': instance.contribution,
      'CreatedAt': instance.CreatedAt,
      'userStatisticFonCreatedAt': instance.userStatisticFonCreatedAt,
      'directReferral': instance.directReferral,
      'headerImg': instance.headerImg,
      'id': instance.id,
      'direct': instance.direct,
      'indirectReferral': instance.indirectReferral,
      'nickName': instance.nickName,
      'todayContribution': instance.todayContribution,
      'commission': instance.commission,
      'payCommission': instance.payCommission,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'username': instance.username,
      'yesterdayContribution': instance.yesterdayContribution,
    };
