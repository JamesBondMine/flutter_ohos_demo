import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'appeal_detail_res.freezed.dart';
part 'appeal_detail_res.g.dart';


///response.CtcAppealDetailRes
@freezed
class AppealDetailRes with _$AppealDetailRes {
  const factory AppealDetailRes({
    String? address,
    String? addressProtocol,
    double? amount,
    String? bankAccount,
    String? bankName,
    int? coinName,
    String? content,
    String? createdAt,
    int? id,
    int? userId,
    List<String>? imgs,
    String? name,
    double? number,
    int? payMethod,
    double? price,
    String? reason,
    int? state,
    int? type,
    String? updatedAt,
    List<String>? videoUrls,
    String? wechatAccount,
    String? wechatImg,
    String? zfbAccount,
    String? zfbImg,
  }) = _AppealDetailRes;

  factory AppealDetailRes.fromJson(Map<String, dynamic> json) => _$AppealDetailResFromJson(json);
}