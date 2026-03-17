import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'trade_list_request.freezed.dart';

part 'trade_list_request.g.dart';

@freezed
class TradeListRequest with _$TradeListRequest {
  const factory TradeListRequest({
    int? page,
    int? pageSize,
    @Default(0) int? sourceType, //0全部 1承兑接单
    int? state, //-1全部 1进行中 2已完成 3已取消
    int? type, //1买入 2卖出
  }) = _TradeListRequest;

  factory TradeListRequest.fromJson(Map<String, Object?> json) =>
      _$TradeListRequestFromJson(json);
}
