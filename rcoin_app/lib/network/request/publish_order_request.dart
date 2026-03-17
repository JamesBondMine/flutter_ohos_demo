import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'publish_order_request.freezed.dart';

part 'publish_order_request.g.dart';

@freezed
class PublishOrderRequest with _$PublishOrderRequest {
  const factory PublishOrderRequest({
    required int coinId,
    required double maxMoney,
    required double minMoney,
    required double number,
    required List<int> paymentMethod,
    required double price,
    required String remark,
    required int type,
  }) = _PublishOrderRequest;

  factory PublishOrderRequest.fromJson(Map<String, Object?> json) =>
      _$PublishOrderRequestFromJson(json);
}
