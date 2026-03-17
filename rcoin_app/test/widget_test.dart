// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otc_app/app.dart';

import 'package:otc_app/main.dart';
import 'package:otc_app/services/pusher.dart';
import 'package:otc_app/upgrade.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Future<String> fetchLatestDomain(List<String> domains) {
      final completer = Completer<String>();

      for (final domain in domains) {
        http.head(Uri.parse(domain)).then((response) {
          if (response.statusCode == 200) {
            completer.complete(domain);
          }
        }).catchError((error) {
          // 处理单个请求错误情况
          print('Error: $error');
        });
      }

      Future.delayed(Duration(seconds: 2)).then((_) {
        // 设置 timeout，如果超时则认为无有效域名返回
        if (!completer.isCompleted) {
          completer.completeError(Exception('No valid domain found'));
        }
      });

      return completer.future;
    }

    final domain = await fetchLatestDomain([
      'https://baidu.com',
      'https://jd.com',
      'https://qq.com',
    ]);

    print('Latest domain: $domain');
  }); 
}
