import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_notice_fon.freezed.dart';
part 'trade_notice_fon.g.dart';


///trade.NoticeFon
@freezed
class TradeNoticeFon with _$TradeNoticeFon {
  const factory TradeNoticeFon({
    String? content,
    String? createdAt,
    int? id,
    String? synopsis,
    String? title,
    String? updatedAt,
  }) = _TradeNoticeFon;

  factory TradeNoticeFon.fromJson(Map<String, dynamic> json) => _$TradeNoticeFonFromJson(json);
}