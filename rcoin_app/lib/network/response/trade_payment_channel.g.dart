// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_payment_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradePaymentChannelImpl _$$TradePaymentChannelImplFromJson(
        Map<String, dynamic> json) =>
    _$TradePaymentChannelImpl(
      channel: json['channel'] as String?,
      commissionRate: (json['commissionRate'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      feeRate: (json['feeRate'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
      id: (json['ID'] as num?)?.toInt(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      minCommissionRate: (json['minCommissionRate'] as num?)?.toDouble(),
      minPayCommissionRate: (json['minPayCommissionRate'] as num?)?.toDouble(),
      name: json['name'] as String?,
      pay: json['pay'] as bool?,
      payCommissionRate: (json['payCommissionRate'] as num?)?.toDouble(),
      payFeeRate: (json['payFeeRate'] as num?)?.toDouble(),
      payMethod: (json['payMethod'] as num?)?.toInt(),
      receive: json['receive'] as bool?,
      sort: (json['sort'] as num?)?.toInt(),
      state: json['state'] as bool?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradePaymentChannelImplToJson(
        _$TradePaymentChannelImpl instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'commissionRate': instance.commissionRate,
      'createdAt': instance.createdAt,
      'feeRate': instance.feeRate,
      'icon': instance.icon,
      'ID': instance.id,
      'maxAmount': instance.maxAmount,
      'minAmount': instance.minAmount,
      'minCommissionRate': instance.minCommissionRate,
      'minPayCommissionRate': instance.minPayCommissionRate,
      'name': instance.name,
      'pay': instance.pay,
      'payCommissionRate': instance.payCommissionRate,
      'payFeeRate': instance.payFeeRate,
      'payMethod': instance.payMethod,
      'receive': instance.receive,
      'sort': instance.sort,
      'state': instance.state,
      'updatedAt': instance.updatedAt,
    };
