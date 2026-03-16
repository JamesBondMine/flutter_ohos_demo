import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:appbyflutter/core/network/api_response.dart';
import 'package:flutter/foundation.dart';

/// 基于 dart:io HttpClient 的封装，不依赖 dio 等第三方库
/// 提供 GET / POST / DELETE / upload / download，统一使用 [ApiResponse] 接收返回
class AppHttpClient {
  AppHttpClient({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    Map<String, String>? defaultHeaders,
  }) : _defaultHeaders = defaultHeaders ?? {};

  final String baseUrl;
  final Duration timeout;
  final Map<String, String> _defaultHeaders;

  HttpClient _createClient() {
    final client = HttpClient();
    client.connectionTimeout = timeout;
    return client;
  }

  void _logRequest(
    String method,
    Uri uri, {
    int? statusCode,
    Duration? duration,
  }) {
    final statusPart = statusCode != null ? ' => $statusCode' : '';
    final durationPart =
        duration != null ? ' (${duration.inMilliseconds}ms)' : '';
    if (kDebugMode) {
      print('[HTTP] $method $uri$statusPart$durationPart');
    }
  }

  Uri _uri(String path, [Map<String, String>? queryParameters]) {
    final base = Uri.parse(baseUrl);
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    final combinedPath = base.path.isEmpty
        ? normalizedPath
        : (base.path.endsWith('/') ? base.path : '${base.path}/') +
            normalizedPath;
    var uri = base.replace(path: combinedPath);
    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = uri.replace(
        queryParameters: {...uri.queryParameters, ...queryParameters},
      );
    }
    return uri;
  }

  Map<String, String> _headers(Map<String, String>? extra) {
    final map = Map<String, String>.from(_defaultHeaders);
    if (extra != null) map.addAll(extra);
    return map;
  }

  /// 解析 JSON 并包装为 ApiResponse
  Future<ApiResponse<T>> _parseResponse<T>(
    HttpClientResponse response,
    List<int> bodyBytes, [
    T Function(dynamic)? fromJsonData,
  ]) async {
    final body = utf8.decode(bodyBytes);
    if (body.isEmpty) {
      return ApiResponse<T>(code: -1, msg: '空响应', data: null);
    }
    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      return ApiResponse<T>.fromJson(json, fromJsonData);
    } catch (_) {
      return ApiResponse<T>(
        code: response.statusCode,
        msg: body,
        data: null,
      );
    }
  }

  /// GET
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? fromJsonData,
  }) async {
    final client = _createClient();
    try {
      final request = await client.getUrl(_uri(path, queryParameters));
      _defaultHeaders.forEach((k, v) => request.headers.set(k, v));
      _headers(headers).forEach((k, v) => request.headers.set(k, v));
      request.headers.set('Accept', 'application/json');
      final response = await request.close();
      final bodyBytes = await response.fold<List<int>>(
        <int>[],
        (acc, chunk) => acc..addAll(chunk),
      );
      if (response.statusCode >= 400) {
        return ApiResponse<T>(
          code: response.statusCode,
          msg: utf8.decode(bodyBytes),
          data: null,
        );
      }
      return _parseResponse<T>(response, bodyBytes, fromJsonData);
    } finally {
      client.close(force: true);
    }
  }

  /// POST（body 为 JSON Map 或 String）
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? fromJsonData,
  }) async {
    final client = _createClient();
    final sw = Stopwatch()..start();
    try {
      final uri = _uri(path, queryParameters);
      final request = await client.postUrl(uri);
      _headers(headers).forEach((k, v) => request.headers.set(k, v));
      request.headers.set('Content-Type', 'application/json; charset=utf-8');
      request.headers.set('Accept', 'application/json');
      if (body != null) {
        if (body is Map || body is List) {
          request.write(jsonEncode(body));
        } else {
          request.write(body.toString());
        }
      }
      final response = await request.close();
      final bodyBytes = await response.fold<List<int>>(
        <int>[],
        (acc, chunk) => acc..addAll(chunk),
      );

      // 打印 POST 请求的完整响应内容，便于调试
      final responseBody = utf8.decode(bodyBytes);
      print('==== HTTP POST $uri ====');
      print('Status: ${response.statusCode}');
      print('Response: $responseBody');
      print('=========================================');

      sw.stop();
      _logRequest(
        'POST',
        uri,
        statusCode: response.statusCode,
        duration: sw.elapsed,
      );
      if (response.statusCode >= 400) {
        return ApiResponse<T>(
          code: response.statusCode,
          msg: responseBody,
          data: null,
        );
      }
      return _parseResponse<T>(response, bodyBytes, fromJsonData);
    } finally {
      client.close(force: true);
    }
  }

  /// DELETE
  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic body,
    T Function(dynamic)? fromJsonData,
  }) async {
    final client = _createClient();
    try {
      final request = await client.deleteUrl(_uri(path, queryParameters));
      _headers(headers).forEach((k, v) => request.headers.set(k, v));
      request.headers.set('Accept', 'application/json');
      if (body != null) {
        request.headers.set('Content-Type', 'application/json; charset=utf-8');
        if (body is Map || body is List) {
          request.write(jsonEncode(body));
        } else {
          request.write(body.toString());
        }
      }
      final response = await request.close();
      final bodyBytes = await response.fold<List<int>>(
        <int>[],
        (acc, chunk) => acc..addAll(chunk),
      );
      if (response.statusCode >= 400) {
        return ApiResponse<T>(
          code: response.statusCode,
          msg: utf8.decode(bodyBytes),
          data: null,
        );
      }
      return _parseResponse<T>(response, bodyBytes, fromJsonData);
    } finally {
      client.close(force: true);
    }
  }

  /// 上传文件（multipart/form-data）
  Future<ApiResponse<T>> upload<T>(
    String path, {
    required String filePath,
    String fieldName = 'file',
    String? filename,
    Map<String, String>? extraFields,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? fromJsonData,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      return ApiResponse<T>(code: -1, msg: '文件不存在', data: null);
    }
    final bytes = await file.readAsBytes();
    final name = filename ?? filePath.split(RegExp(r'[/\\]')).last;
    return uploadBytes<T>(
      path,
      bytes: bytes,
      filename: name,
      fieldName: fieldName,
      extraFields: extraFields,
      queryParameters: queryParameters,
      headers: headers,
      fromJsonData: fromJsonData,
    );
  }

  /// 上传字节（multipart/form-data）
  Future<ApiResponse<T>> uploadBytes<T>(
    String path, {
    required List<int> bytes,
    required String filename,
    String fieldName = 'file',
    Map<String, String>? extraFields,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic)? fromJsonData,
  }) async {
    const boundary = '----AppHttpClientBoundary';
    final client = _createClient();
    try {
      final request = await client.postUrl(_uri(path, queryParameters));
      _headers(headers).forEach((k, v) => request.headers.set(k, v));
      request.headers.set(
        'Content-Type',
        'multipart/form-data; boundary=$boundary',
      );
      request.headers.set('Accept', 'application/json');

      final buffer = StringBuffer();
      if (extraFields != null) {
        for (final e in extraFields.entries) {
          buffer.writeln('--$boundary');
          buffer.writeln('Content-Disposition: form-data; name="${e.key}"');
          buffer.writeln();
          buffer.writeln(e.value);
        }
      }
      buffer.writeln('--$boundary');
      buffer.writeln(
          'Content-Disposition: form-data; name="$fieldName"; filename="$filename"');
      buffer.writeln('Content-Type: application/octet-stream');
      buffer.writeln();
      request.write(buffer.toString());
      request.add(bytes);
      request.writeln();
      request.writeln('--$boundary--');

      final response = await request.close();
      final bodyBytes = await response.fold<List<int>>(
        <int>[],
        (acc, chunk) => acc..addAll(chunk),
      );
      if (response.statusCode >= 400) {
        return ApiResponse<T>(
          code: response.statusCode,
          msg: utf8.decode(bodyBytes),
          data: null,
        );
      }
      return _parseResponse<T>(response, bodyBytes, fromJsonData);
    } finally {
      client.close(force: true);
    }
  }

  /// 下载文件到本地路径
  Future<ApiResponse<String>> download(
    String path, {
    required String savePath,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final client = _createClient();
    try {
      final request = await client.getUrl(_uri(path, queryParameters));
      _headers(headers).forEach((k, v) => request.headers.set(k, v));
      final response = await request.close();
      if (response.statusCode >= 400) {
        final bodyBytes = await response.fold<List<int>>(
          <int>[],
          (acc, chunk) => acc..addAll(chunk),
        );
        return ApiResponse<String>(
          code: response.statusCode,
          msg: utf8.decode(bodyBytes),
          data: null,
        );
      }
      final file = File(savePath);
      await file.parent.create(recursive: true);
      final sink = file.openWrite();
      await response.pipe(sink);
      await sink.close();
      return ApiResponse<String>(
        code: 0,
        msg: 'success',
        data: savePath,
      );
    } finally {
      client.close(force: true);
    }
  }
}
