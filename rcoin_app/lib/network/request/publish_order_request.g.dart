// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublishOrderRequestImpl _$$PublishOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PublishOrderRequestImpl(
      coinId: (json['coinId'] as num).toInt(),
      maxMoney: (json['maxMoney'] as num).toDouble(),
      minMoney: (json['minMoney'] as num).toDouble(),
      number: (json['number'] as num).toDouble(),
      paymentMethod: (json['paymentMethod'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      price: (json['price'] as num).toDouble(),
      remark: json['remark'] as String,
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$$PublishOrderRequestImplToJson(
        _$PublishOrderRequestImpl instance) =>
    <String, dynamic>{
      'coinId': instance.coinId,
      'maxMoney': instance.maxMoney,
      'minMoney': instance.minMoney,
      'number': instance.number,
      'paymentMethod': instance.paymentMethod,
      'price': instance.price,
      'remark': instance.remark,
      'type': instance.type,
    };
