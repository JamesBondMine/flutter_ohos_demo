import 'package:flutter/services.dart';

const platform = MethodChannel('flutterNativeChannel');

class ChannelAndroidIos {
  static Future<String> configureFlutterEngine() async {
    final result;
    try {
      result = await platform.invokeMethod('schemeQuery');
      return result;
    } on PlatformException catch (e) {
      return "Failed : '${e.message}'.";
    }
  }
}
