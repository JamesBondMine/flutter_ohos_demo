// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'receive_setting.freezed.dart';
part 'receive_setting.g.dart';


///trade.ReceiveOrderSetting
@freezed
class ReceiveSetting with _$ReceiveSetting {
  const factory ReceiveSetting({
    String? createdAt,
    String? endReceivingTime,
    int? id,
    double? maxMoney,
    double? minMoney,
    double? number,
    String? payMethod,
    int? state,
    double? surplusNumber,
    int? type,
    String? updatedAt,
    int? userId,
  }) = _ReceiveSetting;

  factory ReceiveSetting.fromJson(Map<String, dynamic> json) => _$ReceiveSettingFromJson(json);
}
