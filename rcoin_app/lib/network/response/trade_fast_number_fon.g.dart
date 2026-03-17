// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_fast_number_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeFastNumberFonImpl _$$TradeFastNumberFonImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeFastNumberFonImpl(
      amount: (json['amount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      sort: (json['sort'] as num?)?.toInt(),
      tag: json['tag'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradeFastNumberFonImplToJson(
        _$TradeFastNumberFonImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'sort': instance.sort,
      'tag': instance.tag,
      'updatedAt': instance.updatedAt,
    };
