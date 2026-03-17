import 'dart:async';
import 'package:http/http.dart' as http;

Future<(String, String)> fetchLatestDomain(List<String> domains,
    {Duration? timeout = const Duration(seconds: 5)}) {
  final completer = Completer<(String, String)>();

  for (final domain in domains) {
    final uri = Uri.parse(domain);
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        if (!completer.isCompleted) {
          completer.complete((uri.host, response.body));
        }
      }
    }).catchError((error) {
      completer.completeError(error);
      return;
    });
  }

  if (timeout != null) {
    Future.delayed(timeout).then((_) {
      // 设置 timeout，如果超时则认为无有效域名返回
      if (!completer.isCompleted) {
        completer.completeError(Exception('timeout, No valid domain found'));
      }
    });
  }

  return completer.future;
}
