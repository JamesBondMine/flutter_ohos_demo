import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'upload_response.freezed.dart';
part 'upload_response.g.dart';

@freezed
class UploadResponse with _$UploadResponse {
  const factory UploadResponse({
    String? createdAt,
    int? id,
    String? key,
    String? name,
    String? tag,
    String? updatedAt,
    String? url,
  }) = _UploadResponse;

  factory UploadResponse.fromJson(Map<String, Object?> json) =>
      _$UploadResponseFromJson(json);
}
