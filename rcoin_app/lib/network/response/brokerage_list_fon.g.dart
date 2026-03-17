// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brokerage_list_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrokerageListFonImpl _$$BrokerageListFonImplFromJson(
        Map<String, dynamic> json) =>
    _$BrokerageListFonImpl(
      amount: (json['amount'] as num?)?.toDouble(),
      contributorHeaderImg: json['contributorHeaderImg'] as String?,
      contributorId: (json['contributorId'] as num?)?.toInt(),
      contributorNickName: json['contributorNickName'] as String?,
      contributorUsername: json['contributorUsername'] as String?,
      CreatedAt: json['CreatedAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      tradeAmount: (json['tradeAmount'] as num?)?.toDouble(),
      tradeSn: json['tradeSn'] as String?,
      tradeType: (json['tradeType'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BrokerageListFonImplToJson(
        _$BrokerageListFonImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'contributorHeaderImg': instance.contributorHeaderImg,
      'contributorId': instance.contributorId,
      'contributorNickName': instance.contributorNickName,
      'contributorUsername': instance.contributorUsername,
      'CreatedAt': instance.CreatedAt,
      'id': instance.id,
      'tradeAmount': instance.tradeAmount,
      'tradeSn': instance.tradeSn,
      'tradeType': instance.tradeType,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
