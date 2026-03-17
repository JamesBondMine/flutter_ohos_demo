// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_coin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferCoinRequestImpl _$$TransferCoinRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferCoinRequestImpl(
      address: json['address'] as String?,
      coinId: (json['coinId'] as num?)?.toInt(),
      number: (json['number'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TransferCoinRequestImplToJson(
        _$TransferCoinRequestImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'coinId': instance.coinId,
      'number': instance.number,
    };
