import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'match_order_request.freezed.dart';

part 'match_order_request.g.dart';

@freezed
class MatchOrderRequest with _$MatchOrderRequest {
  const factory MatchOrderRequest({
    double? number,
    double? amount,
    required int orderId,
    required int payMethod,
    required String pwd,
  }) = _MatchOrderRequest;

  factory MatchOrderRequest.fromJson(Map<String, Object?> json) =>
      _$MatchOrderRequestFromJson(json);
}
