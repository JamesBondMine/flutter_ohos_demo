// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublishOrderImpl _$$PublishOrderImplFromJson(Map<String, dynamic> json) =>
    _$PublishOrderImpl(
      id: (json['id'] as num).toInt(),
      CreatedAt: json['CreatedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num).toInt(),
      coinId: (json['coinId'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      number: (json['number'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      minMoney: (json['minMoney'] as num).toDouble(),
      maxMoney: (json['maxMoney'] as num).toDouble(),
      surplusNumber: (json['surplusNumber'] as num).toDouble(),
      state: (json['state'] as num).toInt(),
      source_type: (json['source_type'] as num).toInt(),
      moneyType: (json['moneyType'] as num).toInt(),
      recvFee: (json['recvFee'] as num).toDouble(),
      payMethod: json['payMethod'] as String,
      isRealTime: json['isRealTime'] as bool?,
      remark: json['remark'] as String?,
      deposit: (json['deposit'] as num?)?.toDouble(),
      nickName: json['nickName'] as String?,
      headerImg: json['headerImg'] as String?,
      closeRate: (json['closeRate'] as num?)?.toInt(),
      transactionCount: (json['transactionCount'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      transactionDuration: (json['transactionDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PublishOrderImplToJson(_$PublishOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'CreatedAt': instance.CreatedAt,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'coinId': instance.coinId,
      'type': instance.type,
      'number': instance.number,
      'price': instance.price,
      'fee': instance.fee,
      'minMoney': instance.minMoney,
      'maxMoney': instance.maxMoney,
      'surplusNumber': instance.surplusNumber,
      'state': instance.state,
      'source_type': instance.source_type,
      'moneyType': instance.moneyType,
      'recvFee': instance.recvFee,
      'payMethod': instance.payMethod,
      'isRealTime': instance.isRealTime,
      'remark': instance.remark,
      'deposit': instance.deposit,
      'nickName': instance.nickName,
      'headerImg': instance.headerImg,
      'closeRate': instance.closeRate,
      'transactionCount': instance.transactionCount,
      'level': instance.level,
      'transactionDuration': instance.transactionDuration,
    };
