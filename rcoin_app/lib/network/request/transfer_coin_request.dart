import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'transfer_coin_request.freezed.dart';
part 'transfer_coin_request.g.dart';


///request.CoinTrans
@freezed
class TransferCoinRequest with _$TransferCoinRequest {
  const factory TransferCoinRequest({
    String? address,
    int? coinId,
    double? number,
  }) = _TransferCoinRequest;

  factory TransferCoinRequest.fromJson(Map<String, dynamic> json) => _$TransferCoinRequestFromJson(json);
}
