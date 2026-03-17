// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradePaymentImpl _$$TradePaymentImplFromJson(Map<String, dynamic> json) =>
    _$TradePaymentImpl(
      channel: json['channel'] as String?,
      createdAt: json['createdAt'] as String?,
      feeRate: (json['feeRate'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
      id: (json['ID'] as num?)?.toInt(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      payFeeRate: (json['payFeeRate'] as num?)?.toDouble(),
      sort: (json['sort'] as num?)?.toInt(),
      state: json['state'] as bool?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradePaymentImplToJson(_$TradePaymentImpl instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'createdAt': instance.createdAt,
      'feeRate': instance.feeRate,
      'icon': instance.icon,
      'ID': instance.id,
      'maxAmount': instance.maxAmount,
      'minAmount': instance.minAmount,
      'name': instance.name,
      'payFeeRate': instance.payFeeRate,
      'sort': instance.sort,
      'state': instance.state,
      'updatedAt': instance.updatedAt,
    };
