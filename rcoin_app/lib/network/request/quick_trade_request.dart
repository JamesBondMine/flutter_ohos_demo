import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'quick_trade_request.freezed.dart';
part 'quick_trade_request.g.dart';

@freezed
class QuickTradeRequest with _$QuickTradeRequest {
  const factory QuickTradeRequest({
    double? amount,
    double? number,
    int? payMethod,
  }) = _QuickTradeRequest;

  factory QuickTradeRequest.fromJson(Map<String, Object?> json) =>
      _$QuickTradeRequestFromJson(json);
}
