// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trans_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransFonImpl _$$TransFonImplFromJson(Map<String, dynamic> json) =>
    _$TransFonImpl(
      CreatedAt: json['CreatedAt'] as String?,
      address: json['address'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      coinId: (json['coinId'] as num?)?.toInt(),
      coinName: json['coinName'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      realAmount: (json['realAmount'] as num?)?.toDouble(),
      receiveAddress: json['receiveAddress'] as String?,
    );

Map<String, dynamic> _$$TransFonImplToJson(_$TransFonImpl instance) =>
    <String, dynamic>{
      'CreatedAt': instance.CreatedAt,
      'address': instance.address,
      'amount': instance.amount,
      'coinId': instance.coinId,
      'coinName': instance.coinName,
      'fee': instance.fee,
      'id': instance.id,
      'realAmount': instance.realAmount,
      'receiveAddress': instance.receiveAddress,
    };
