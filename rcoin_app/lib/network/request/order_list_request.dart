import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'order_list_request.freezed.dart';

part 'order_list_request.g.dart';

@freezed
class OrderListRequest with _$OrderListRequest {
  const factory OrderListRequest({
    int? amount,
    String? keyword,
    int? maxAmount,
    int? minAmount,
    required int page,
    required int pageSize,
    List<int>? paymentMethod,
    int? cooperated,
    required int type,
  }) = _OrderListRequest;

  factory OrderListRequest.fromJson(Map<String, Object?> json) =>
      _$OrderListRequestFromJson(json);
}
