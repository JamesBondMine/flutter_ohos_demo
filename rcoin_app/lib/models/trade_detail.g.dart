// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeDetailImpl _$$TradeDetailImplFromJson(Map<String, dynamic> json) =>
    _$TradeDetailImpl(
      amount: (json['amount'] as num?)?.toDouble(),
      appealState: (json['appealState'] as num?)?.toInt(),
      buyer: json['buyer'] == null
          ? null
          : TradeTrader.fromJson(json['buyer'] as Map<String, dynamic>),
      callback: (json['callback'] as num?)?.toInt(),
      callbackTimes: (json['callbackTimes'] as num?)?.toInt(),
      coinId: (json['coinId'] as num?)?.toInt(),
      countDown: (json['countDown'] as num?)?.toInt(),
      CreatedAt: json['CreatedAt'] as String?,
      ctcTradePay: json['ctcTradePay'] == null
          ? null
          : Payment.fromJson(json['ctcTradePay'] as Map<String, dynamic>),
      deposit: (json['deposit'] as num?)?.toDouble(),
      fee: (json['fee'] as num?)?.toDouble(),
      finishTime: json['finishTime'] as String?,
      fourChannelId: (json['fourChannelId'] as num?)?.toInt(),
      fourChannelSn: json['fourChannelSn'] as String?,
      id: (json['id'] as num?)?.toInt(),
      imgs: json['imgs'] as String?,
      notifyUrl: json['notifyUrl'] as String?,
      number: (json['number'] as num?)?.toDouble(),
      orderId: (json['orderId'] as num?)?.toInt(),
      orderSn: json['orderSn'] as String?,
      orderUserId: (json['orderUserId'] as num?)?.toInt(),
      outNickname: json['outNickname'] as String?,
      outOrderId: json['outOrderId'] as String?,
      outUid: json['outUid'] as String?,
      paymentState: (json['paymentState'] as num?)?.toInt(),
      payMethod: (json['payMethod'] as num?)?.toInt(),
      payTime: json['payTime'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      receiveConfirm: (json['receiveConfirm'] as num?)?.toInt(),
      receiveOrPay: (json['receiveOrPay'] as num?)?.toInt(),
      recvFee: (json['recvFee'] as num?)?.toDouble(),
      remark: json['remark'] as String?,
      remarkCode: json['remarkCode'] as String?,
      seller: json['seller'] == null
          ? null
          : TradeTrader.fromJson(json['seller'] as Map<String, dynamic>),
      sourceType: (json['sourceType'] as num?)?.toInt(),
      state: (json['state'] as num?)?.toInt(),
      tradePayId: (json['tradePayId'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      usdtAmount: (json['usdtAmount'] as num?)?.toDouble(),
      userId: (json['userId'] as num?)?.toInt(),
      userPaymentMethodId: (json['userPaymentMethodId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TradeDetailImplToJson(_$TradeDetailImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'appealState': instance.appealState,
      'buyer': instance.buyer,
      'callback': instance.callback,
      'callbackTimes': instance.callbackTimes,
      'coinId': instance.coinId,
      'countDown': instance.countDown,
      'CreatedAt': instance.CreatedAt,
      'ctcTradePay': instance.ctcTradePay,
      'deposit': instance.deposit,
      'fee': instance.fee,
      'finishTime': instance.finishTime,
      'fourChannelId': instance.fourChannelId,
      'fourChannelSn': instance.fourChannelSn,
      'id': instance.id,
      'imgs': instance.imgs,
      'notifyUrl': instance.notifyUrl,
      'number': instance.number,
      'orderId': instance.orderId,
      'orderSn': instance.orderSn,
      'orderUserId': instance.orderUserId,
      'outNickname': instance.outNickname,
      'outOrderId': instance.outOrderId,
      'outUid': instance.outUid,
      'paymentState': instance.paymentState,
      'payMethod': instance.payMethod,
      'payTime': instance.payTime,
      'price': instance.price,
      'receiveConfirm': instance.receiveConfirm,
      'receiveOrPay': instance.receiveOrPay,
      'recvFee': instance.recvFee,
      'remark': instance.remark,
      'remarkCode': instance.remarkCode,
      'seller': instance.seller,
      'sourceType': instance.sourceType,
      'state': instance.state,
      'tradePayId': instance.tradePayId,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'usdtAmount': instance.usdtAmount,
      'userId': instance.userId,
      'userPaymentMethodId': instance.userPaymentMethodId,
    };
