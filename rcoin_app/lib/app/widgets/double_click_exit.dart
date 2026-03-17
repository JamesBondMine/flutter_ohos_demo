import 'package:otc_app/app.dart';

mixin DoubleClickExit {
  DateTime? lastPopTime;

  Future<bool> handlerExit(String text) {
    if (lastPopTime == null ||
        DateTime.now().difference(lastPopTime!) > const Duration(seconds: 2)) {
      lastPopTime = DateTime.now();
      Toast.showInfo(text);
      return Future.value(false);
    } else {
      lastPopTime = DateTime.now();
      return Future.value(true);
    }
  }
}
