// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_commission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeCommissionImpl _$$TradeCommissionImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCommissionImpl(
      commissionRate: (json['commissionRate'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
      id: (json['id'] as num?)?.toInt(),
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      minCommissionRate: (json['minCommissionRate'] as num?)?.toDouble(),
      minPayCommissionRate: (json['minPayCommissionRate'] as num?)?.toDouble(),
      name: json['name'] as String?,
      payCommissionRate: (json['payCommissionRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TradeCommissionImplToJson(
        _$TradeCommissionImpl instance) =>
    <String, dynamic>{
      'commissionRate': instance.commissionRate,
      'icon': instance.icon,
      'id': instance.id,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'minCommissionRate': instance.minCommissionRate,
      'minPayCommissionRate': instance.minPayCommissionRate,
      'name': instance.name,
      'payCommissionRate': instance.payCommissionRate,
    };
