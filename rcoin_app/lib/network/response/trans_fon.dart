import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trans_fon.freezed.dart';
part 'trans_fon.g.dart';


///trade.TransFon
@freezed
class TransFon with _$TransFon {
  const factory TransFon({
    String? CreatedAt,
    String? address,
    double? amount,
    int? coinId,
    String? coinName,
    double? fee,
    int? id,
    double? realAmount,
    String? receiveAddress,
  }) = _TransFon;

  factory TransFon.fromJson(Map<String, dynamic> json) => _$TransFonFromJson(json);
}