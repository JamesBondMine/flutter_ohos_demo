// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiveSettingImpl _$$ReceiveSettingImplFromJson(Map<String, dynamic> json) =>
    _$ReceiveSettingImpl(
      createdAt: json['createdAt'] as String?,
      endReceivingTime: json['endReceivingTime'] as String?,
      id: (json['id'] as num?)?.toInt(),
      maxMoney: (json['maxMoney'] as num?)?.toDouble(),
      minMoney: (json['minMoney'] as num?)?.toDouble(),
      number: (json['number'] as num?)?.toDouble(),
      payMethod: json['payMethod'] as String?,
      state: (json['state'] as num?)?.toInt(),
      surplusNumber: (json['surplusNumber'] as num?)?.toDouble(),
      type: (json['type'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ReceiveSettingImplToJson(
        _$ReceiveSettingImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'endReceivingTime': instance.endReceivingTime,
      'id': instance.id,
      'maxMoney': instance.maxMoney,
      'minMoney': instance.minMoney,
      'number': instance.number,
      'payMethod': instance.payMethod,
      'state': instance.state,
      'surplusNumber': instance.surplusNumber,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
