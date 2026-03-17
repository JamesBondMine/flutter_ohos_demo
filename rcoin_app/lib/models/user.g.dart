// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      areaCode: json['areaCode'] as String?,
      cardId: json['cardId'] as String?,
      createdAt: json['createdAt'] as String?,
      email: json['email'] as String?,
      fromType: (json['fromType'] as num?)?.toInt(),
      headerImg: json['headerImg'] as String?,
      id: (json['id'] as num?)?.toInt(),
      inviteCode: json['inviteCode'] as String?,
      level: (json['level'] as num?)?.toInt(),
      nickName: json['nickName'] as String?,
      password: json['password'] as String?,
      payPassword: json['payPassword'] as String?,
      phone: json['phone'] as String?,
      realName: json['realName'] as String?,
      surplusMoney: (json['surplusMoney'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      userType: (json['userType'] as num?)?.toInt(),
      username: json['username'] as String?,
      receivingOrders: (json['receivingOrders'] as num?)?.toInt(),
      payReceivingOrders: (json['payReceivingOrders'] as num?)?.toInt(),
      googleSecret: json['googleSecret'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'areaCode': instance.areaCode,
      'cardId': instance.cardId,
      'createdAt': instance.createdAt,
      'email': instance.email,
      'fromType': instance.fromType,
      'headerImg': instance.headerImg,
      'id': instance.id,
      'inviteCode': instance.inviteCode,
      'level': instance.level,
      'nickName': instance.nickName,
      'password': instance.password,
      'payPassword': instance.payPassword,
      'phone': instance.phone,
      'realName': instance.realName,
      'surplusMoney': instance.surplusMoney,
      'updatedAt': instance.updatedAt,
      'userType': instance.userType,
      'username': instance.username,
      'receivingOrders': instance.receivingOrders,
      'payReceivingOrders': instance.payReceivingOrders,
      'googleSecret': instance.googleSecret,
    };
