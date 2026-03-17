// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_assets_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAssetsResponseImpl _$$UserAssetsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAssetsResponseImpl(
      address: json['address'] as String?,
      deposit: (json['deposit'] as num?)?.toDouble(),
      money: (json['money'] as num?)?.toDouble(),
      todayEarnings: (json['todayEarnings'] as num?)?.toDouble(),
      tradeAmount: (json['tradeAmount'] as num?)?.toDouble(),
      yesterdayEarnings: (json['yesterdayEarnings'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserAssetsResponseImplToJson(
        _$UserAssetsResponseImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'deposit': instance.deposit,
      'money': instance.money,
      'todayEarnings': instance.todayEarnings,
      'tradeAmount': instance.tradeAmount,
      'yesterdayEarnings': instance.yesterdayEarnings,
    };
