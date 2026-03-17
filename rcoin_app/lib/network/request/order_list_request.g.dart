// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderListRequestImpl _$$OrderListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderListRequestImpl(
      amount: (json['amount'] as num?)?.toInt(),
      keyword: json['keyword'] as String?,
      maxAmount: (json['maxAmount'] as num?)?.toInt(),
      minAmount: (json['minAmount'] as num?)?.toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      paymentMethod: (json['paymentMethod'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      cooperated: (json['cooperated'] as num?)?.toInt(),
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderListRequestImplToJson(
        _$OrderListRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'keyword': instance.keyword,
      'maxAmount': instance.maxAmount,
      'minAmount': instance.minAmount,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'paymentMethod': instance.paymentMethod,
      'cooperated': instance.cooperated,
      'type': instance.type,
    };
