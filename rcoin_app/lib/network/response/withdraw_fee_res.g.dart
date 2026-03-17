// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_fee_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WithdrawFeeResImpl _$$WithdrawFeeResImplFromJson(Map<String, dynamic> json) =>
    _$WithdrawFeeResImpl(
      fee: (json['fee'] as num?)?.toDouble(),
      USDTAmount: (json['USDTAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WithdrawFeeResImplToJson(
        _$WithdrawFeeResImpl instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'USDTAmount': instance.USDTAmount,
    };
