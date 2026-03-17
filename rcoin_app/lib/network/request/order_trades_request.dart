import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'order_trades_request.freezed.dart';
part 'order_trades_request.g.dart';

@freezed
class OrderTradesRequest with _$OrderTradesRequest {
  const factory OrderTradesRequest({
    int? id,
    int? page,
    int? pageSize,
  }) = _OrderTradesRequest;

  factory OrderTradesRequest.fromJson(Map<String, Object?> json) =>
      _$OrderTradesRequestFromJson(json);
}
