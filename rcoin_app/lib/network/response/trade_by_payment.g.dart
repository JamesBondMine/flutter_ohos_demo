// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_by_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseCtcTradeByPaymentListResImpl
    _$$ResponseCtcTradeByPaymentListResImplFromJson(
            Map<String, dynamic> json) =>
        _$ResponseCtcTradeByPaymentListResImpl(
          list: (json['list'] as List<dynamic>?)
                  ?.map((e) => TradeCtcTradeByPaymentFon.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
          page: (json['page'] as num).toInt(),
          pageSize: (json['pageSize'] as num).toInt(),
          total: (json['total'] as num).toInt(),
          totalAmount: (json['totalAmount'] as num).toDouble(),
        );

Map<String, dynamic> _$$ResponseCtcTradeByPaymentListResImplToJson(
        _$ResponseCtcTradeByPaymentListResImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'total': instance.total,
      'totalAmount': instance.totalAmount,
    };

_$TradeCtcTradeByPaymentFonImpl _$$TradeCtcTradeByPaymentFonImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCtcTradeByPaymentFonImpl(
      amount: (json['amount'] as num).toDouble(),
      createdAt: json['CreatedAt'] as String,
      id: (json['id'] as num).toInt(),
      orderSn: json['orderSn'] as String,
      name: json['name'] as String,
      payMethod: (json['payMethod'] as num).toInt(),
      receiveOrPay: (json['receiveOrPay'] as num).toInt(),
    );

Map<String, dynamic> _$$TradeCtcTradeByPaymentFonImplToJson(
        _$TradeCtcTradeByPaymentFonImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'CreatedAt': instance.createdAt,
      'id': instance.id,
      'orderSn': instance.orderSn,
      'name': instance.name,
      'payMethod': instance.payMethod,
      'receiveOrPay': instance.receiveOrPay,
    };
