// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_by_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeByPaymentRequestImpl _$$TradeByPaymentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeByPaymentRequestImpl(
      day: json['day'] as String,
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      payMethod: (json['payMethod'] as num).toInt(),
    );

Map<String, dynamic> _$$TradeByPaymentRequestImplToJson(
        _$TradeByPaymentRequestImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'payMethod': instance.payMethod,
    };
