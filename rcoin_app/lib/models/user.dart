import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:otc_app/service.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? areaCode,
    String? cardId,
    String? createdAt,
    String? email,
    int? fromType,
    String? headerImg,
    int? id,
    String? inviteCode,
    int? level,
    String? nickName,
    String? password,
    String? payPassword,
    String? phone,
    String? realName,
    int? surplusMoney,
    String? updatedAt,
    int? userType, //1承兑 2 商户
    String? username,
    int? receivingOrders,
    int? payReceivingOrders,
    String? googleSecret,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

extension Attrs on User {
  UserType get accountType => UserType.fromValue(userType!);
}
