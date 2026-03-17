// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppealDetailResImpl _$$AppealDetailResImplFromJson(
        Map<String, dynamic> json) =>
    _$AppealDetailResImpl(
      address: json['address'] as String?,
      addressProtocol: json['addressProtocol'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      bankAccount: json['bankAccount'] as String?,
      bankName: json['bankName'] as String?,
      coinName: (json['coinName'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      imgs: (json['imgs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      number: (json['number'] as num?)?.toDouble(),
      payMethod: (json['payMethod'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      state: (json['state'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      videoUrls: (json['videoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      wechatAccount: json['wechatAccount'] as String?,
      wechatImg: json['wechatImg'] as String?,
      zfbAccount: json['zfbAccount'] as String?,
      zfbImg: json['zfbImg'] as String?,
    );

Map<String, dynamic> _$$AppealDetailResImplToJson(
        _$AppealDetailResImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'addressProtocol': instance.addressProtocol,
      'amount': instance.amount,
      'bankAccount': instance.bankAccount,
      'bankName': instance.bankName,
      'coinName': instance.coinName,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'userId': instance.userId,
      'imgs': instance.imgs,
      'name': instance.name,
      'number': instance.number,
      'payMethod': instance.payMethod,
      'price': instance.price,
      'reason': instance.reason,
      'state': instance.state,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'videoUrls': instance.videoUrls,
      'wechatAccount': instance.wechatAccount,
      'wechatImg': instance.wechatImg,
      'zfbAccount': instance.zfbAccount,
      'zfbImg': instance.zfbImg,
    };
