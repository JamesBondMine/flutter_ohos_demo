import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'coin_bills_fon.freezed.dart';
part 'coin_bills_fon.g.dart';


///trade.CoinBillsFon
@freezed
class CoinBillsFon with _$CoinBillsFon {
  const factory CoinBillsFon({
    double? actualRate,
    double? balance,
    String? billSn,
    int? billTypeId,
    int? coinId,
    String? coinName,
    String? CreatedAt,
    int? id,
    double? money,
    String? name,
    String? remark,
    String? updatedAt,
    int? userId,
  }) = _CoinBillsFon;

  factory CoinBillsFon.fromJson(Map<String, dynamic> json) => _$CoinBillsFonFromJson(json);
}