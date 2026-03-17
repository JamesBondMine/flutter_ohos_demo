// To parse this JSON data, do
//
//     final billTypesFon = billTypesFonFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'bill_types_fon.freezed.dart';
part 'bill_types_fon.g.dart';


///trade.BillTypesFon
@freezed
class BillTypesFon with _$BillTypesFon {
  const factory BillTypesFon({
    String? code,
    String? createdAt,
    int? id,
    String? name,
    int? status,
    String? updatedAt,
  }) = _BillTypesFon;

  factory BillTypesFon.fromJson(Map<String, dynamic> json) => _$BillTypesFonFromJson(json);
}