// To parse this JSON data, do
//
//     final brokerageListFon = brokerageListFonFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'brokerage_list_fon.freezed.dart';
part 'brokerage_list_fon.g.dart';


///trade.BrokerageListFon
@freezed
class BrokerageListFon with _$BrokerageListFon {
  const factory BrokerageListFon({
    double? amount,
    String? contributorHeaderImg,
    int? contributorId,
    String? contributorNickName,
    String? contributorUsername,
    String? CreatedAt,
    int? id,
    double? tradeAmount,
    String? tradeSn,
    int? tradeType,
    String? updatedAt,
    int? userId,
  }) = _BrokerageListFon;

  factory BrokerageListFon.fromJson(Map<String, dynamic> json) => _$BrokerageListFonFromJson(json);
}