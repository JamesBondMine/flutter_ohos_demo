export 'params.dart';

import 'dart:io';

import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'upload_client.g.dart';

/// https://pub.dev/packages/retrofit
/// retrofit生成器有 bug, 因此把上传单独分出来
@RestApi()
abstract class UploadClient {
  factory UploadClient(Dio dio, {String baseUrl}) = _UploadClient;

  @MultiPart()
  @POST('/user/upload')
  Future<AppResponse<UploadResponse>> upload(@Part() File file);
}
