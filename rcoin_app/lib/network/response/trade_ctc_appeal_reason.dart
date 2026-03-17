import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trade_ctc_appeal_reason.freezed.dart';
part 'trade_ctc_appeal_reason.g.dart';


///trade.CtcAppealReason
@freezed
class TradeCtcAppealReason with _$TradeCtcAppealReason {
  const factory TradeCtcAppealReason({
    String? content,
    String? createdAt,
    int? id,
    String? updatedAt,
  }) = _TradeCtcAppealReason;

  factory TradeCtcAppealReason.fromJson(Map<String, dynamic> json) => _$TradeCtcAppealReasonFromJson(json);
}
