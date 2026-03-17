// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_trade_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuickTradeRequestImpl _$$QuickTradeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QuickTradeRequestImpl(
      amount: (json['amount'] as num?)?.toDouble(),
      number: (json['number'] as num?)?.toDouble(),
      payMethod: (json['payMethod'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuickTradeRequestImplToJson(
        _$QuickTradeRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'number': instance.number,
      'payMethod': instance.payMethod,
    };
