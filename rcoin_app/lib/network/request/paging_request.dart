// To parse this JSON data, do
//
//     final pagingRequest = pagingRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'paging_request.freezed.dart';
part 'paging_request.g.dart';


///request.AgencySearch
@freezed
class PagingRequest with _$PagingRequest {
  const factory PagingRequest({
    int? page,
    int? pageSize,
  }) = _PagingRequest;

  factory PagingRequest.fromJson(Map<String, dynamic> json) => _$PagingRequestFromJson(json);
}