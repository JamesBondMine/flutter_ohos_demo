// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      authType: (json['authType'] as num?)?.toInt(),
      contactInfo: json['contactInfo'] as String?,
      nickName: json['nickName'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'authType': instance.authType,
      'contactInfo': instance.contactInfo,
      'nickName': instance.nickName,
      'url': instance.url,
    };
