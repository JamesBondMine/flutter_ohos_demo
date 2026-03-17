// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_bills_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoinBillsFonImpl _$$CoinBillsFonImplFromJson(Map<String, dynamic> json) =>
    _$CoinBillsFonImpl(
      actualRate: (json['actualRate'] as num?)?.toDouble(),
      balance: (json['balance'] as num?)?.toDouble(),
      billSn: json['billSn'] as String?,
      billTypeId: (json['billTypeId'] as num?)?.toInt(),
      coinId: (json['coinId'] as num?)?.toInt(),
      coinName: json['coinName'] as String?,
      CreatedAt: json['CreatedAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      money: (json['money'] as num?)?.toDouble(),
      name: json['name'] as String?,
      remark: json['remark'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CoinBillsFonImplToJson(_$CoinBillsFonImpl instance) =>
    <String, dynamic>{
      'actualRate': instance.actualRate,
      'balance': instance.balance,
      'billSn': instance.billSn,
      'billTypeId': instance.billTypeId,
      'coinId': instance.coinId,
      'coinName': instance.coinName,
      'CreatedAt': instance.CreatedAt,
      'id': instance.id,
      'money': instance.money,
      'name': instance.name,
      'remark': instance.remark,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
