// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_coin_market_fon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeCoinMarketFonImpl _$$TradeCoinMarketFonImplFromJson(
        Map<String, dynamic> json) =>
    _$TradeCoinMarketFonImpl(
      coinName: json['coinName'] as String?,
      img: json['img'] as String?,
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      sort: (json['sort'] as num?)?.toInt(),
      state: json['state'] as bool?,
      symbol: json['symbol'] as String?,
      ud: (json['ud'] as num?)?.toDouble(),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$$TradeCoinMarketFonImplToJson(
        _$TradeCoinMarketFonImpl instance) =>
    <String, dynamic>{
      'coinName': instance.coinName,
      'img': instance.img,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'price': instance.price,
      'sort': instance.sort,
      'state': instance.state,
      'symbol': instance.symbol,
      'ud': instance.ud,
      'updatedAt': instance.updatedAt,
    };
