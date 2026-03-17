// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_commission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetCommissionRequestImpl _$$SetCommissionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SetCommissionRequestImpl(
      commission: (json['commission'] as List<dynamic>?)
          ?.map((e) => TradeUserCommission.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SetCommissionRequestImplToJson(
        _$SetCommissionRequestImpl instance) =>
    <String, dynamic>{
      'commission': instance.commission,
      'userId': instance.userId,
    };
