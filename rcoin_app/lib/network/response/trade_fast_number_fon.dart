// To parse this JSON data, do
//
//     final tradeFastNumberFon = tradeFastNumberFonFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_fast_number_fon.freezed.dart';
part 'trade_fast_number_fon.g.dart';

TradeFastNumberFon tradeFastNumberFonFromJson(String str) => TradeFastNumberFon.fromJson(json.decode(str));

String tradeFastNumberFonToJson(TradeFastNumberFon data) => json.encode(data.toJson());


///trade.FastNumberFon
@freezed
class TradeFastNumberFon with _$TradeFastNumberFon {
  const factory TradeFastNumberFon({
    int? amount,
    String? createdAt,
    int? id,
    int? sort,
    String? tag,
    String? updatedAt,
  }) = _TradeFastNumberFon;

  factory TradeFastNumberFon.fromJson(Map<String, dynamic> json) => _$TradeFastNumberFonFromJson(json);
}