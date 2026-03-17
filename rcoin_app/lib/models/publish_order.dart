import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:otc_app/models/payment_type.dart';

part 'publish_order.freezed.dart';

part 'publish_order.g.dart';

@freezed
class PublishOrder with _$PublishOrder {
  const factory PublishOrder({
    required int id,
    String? CreatedAt,
    String? updatedAt,
    required int userId,
    required int coinId,
    required int type,
    required double number,
    required double price,
    required double fee,
    required double minMoney,
    required double maxMoney,
    required double surplusNumber,
    required int state,
    required int source_type,
    required int moneyType,
    required double recvFee,
    required String payMethod,
    bool? isRealTime,
    String? remark,
    double? deposit,
    String? nickName,
    String? headerImg,
    int? closeRate,
    int? transactionCount,
    int? level,
    int? transactionDuration,
  }) = _PublishOrder;

  factory PublishOrder.fromJson(Map<String, Object?> json) =>
      _$PublishOrderFromJson(json);
}

extension GetPaymentType on PublishOrder {
  List<PaymentType> get paymentTypes {
    return payMethod
        .split(',')
        .map((e) => PaymentType.fromValue(int.parse(e)))
        .toList();
  }
}
