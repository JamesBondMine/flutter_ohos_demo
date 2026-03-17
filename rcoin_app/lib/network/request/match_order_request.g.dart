// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchOrderRequestImpl _$$MatchOrderRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchOrderRequestImpl(
      number: (json['number'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      orderId: (json['orderId'] as num).toInt(),
      payMethod: (json['payMethod'] as num).toInt(),
      pwd: json['pwd'] as String,
    );

Map<String, dynamic> _$$MatchOrderRequestImplToJson(
        _$MatchOrderRequestImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'amount': instance.amount,
      'orderId': instance.orderId,
      'payMethod': instance.payMethod,
      'pwd': instance.pwd,
    };
