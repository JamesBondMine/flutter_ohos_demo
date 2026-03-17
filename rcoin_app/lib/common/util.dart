import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scan/scan.dart';

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

String removeTrailingZeros(String numberString) {
  if (!numberString.contains('.')) {
    return numberString;
  }

  // 先移除字符串尾部的零
  String result = numberString.replaceAll(RegExp(r"0*$"), "");

  // 处理小数点
  int dotIndex = result.indexOf('.');

  // 如果小数点后都是零，则移除小数点
  if (dotIndex != -1 && result.substring(dotIndex + 1).isEmpty) {
    result = result.substring(0, dotIndex);
  }

  return result;
}

extension RemoveTrailingZerosNum on num {
  String get rtz => removeTrailingZeros(toString());
}

extension RemoveTrailingZerosStr on String {
  String get rtz => removeTrailingZeros(this);
}

String formatDateTime(String dateTimeString,
    {String format = 'yyyy-MM-dd HH:mm:ss'}) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  DateTime dn = DateTime.now();
  if (dateTime.year == dn.year) {
    format = 'MM.dd HH:mm:ss';
    if (dateTime.month == dn.month && dateTime.day == dn.day) {
      format = 'HH:mm';
      if (dateTime.millisecondsSinceEpoch >
          (dn.millisecondsSinceEpoch - 3600 * 1000)) {
        return "刚刚".tr;
      }
    } else if (dateTime.millisecondsSinceEpoch >
        (today().millisecondsSinceEpoch - 3600 * 1000 * 24)) {
      return "昨天".tr;
    }
  }
  DateTime localDateTime = dateTime.toLocal();
  final DateFormat formatter = DateFormat(format);
  return formatter.format(localDateTime);
}

// 今天
DateTime today() {
  DateTime startNew = DateTime(
    DateTime.now().year, // 年份
    DateTime.now().month, // 月份
    DateTime.now().day, // 日期
    0, // 小时
    0, // 分钟
    0, // 秒
    0, // 毫秒
  );
  return startNew;
}

extension DateTimeFormat on DateTime {
  format({format = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateFormat(format).format(toLocal());
  }
}

String generateRandomString(int length) {
  final random = Random();
  final codeUnits = List.generate(
    length,
    (index) => random.nextInt(26) + 97, // 生成 ASCII 码为 97-122 的随机数，对应小写字母 a-z
  );
  return String.fromCharCodes(codeUnits);
}

String ucTimeAgo(DateTime time) {
  DateTime nowDate = DateTime.now();
  DateTime conDate = time.toLocal();

  String returnTime = '';

  if (nowDate.year != conDate.year) {
    returnTime = '${conDate.year}${'年'.tr}';
  }

  if (nowDate.day != conDate.day) {
    returnTime = '$returnTime${conDate.month}${'月'.tr}';
    returnTime = '$returnTime${conDate.day}${'日'.tr} ';
  }
  if (returnTime.isNotEmpty) {
    return returnTime;
  }

// 凌晨：0时至5时；早晨：5时至8时；上午：8时至11时；中午：11时至13时；下午：13时至16时；傍晚：16时至19时；晚上：19时至24时。

  int conHour = conDate.hour;

  if (conHour >= 0 && conHour < 5) {
    returnTime = '$returnTime${'凌晨'.tr}';
  } else if (conHour >= 5 && conHour < 8) {
    returnTime = '$returnTime${'早晨'.tr}';
  } else if (conHour >= 8 && conHour < 11) {
    returnTime = '$returnTime${'上午'.tr}';
  } else if (conHour >= 11 && conHour < 13) {
    returnTime = '$returnTime${'中午'.tr}';
  } else if (conHour >= 13 && conHour < 16) {
    returnTime = '$returnTime${'下午'.tr}';
  } else if (conHour >= 16 && conHour < 19) {
    returnTime = '$returnTime${'傍晚'.tr}';
  } else if (conHour >= 19 && conHour <= 23) {
    returnTime = '$returnTime${'晚上'.tr}';
  }

  return '$returnTime${conHour.toString().padLeft(2, '0')}:${conDate.minute.toString().padLeft(2, '0')}';
}

mapGet(dynamic map, String key) {
  if (map == null) {
    return null;
  }
  if (map is Map) {
    return map[key];
  }
  return null;
}

Future<String?> detectQrcode(File file) async {
  return await Scan.parse(file.path);
}

int compareVersions(String version1, String version2) {
  List<String> v1 = version1.replaceAll(RegExp(r'\+\d+'), '').split('.');
  List<String> v2 = version2.replaceAll(RegExp(r'\+\d+'), '').split('.');

  int maxLength = v1.length > v2.length ? v1.length : v2.length;

  for (int i = 0; i < maxLength; i++) {
    int num1 = i < v1.length ? int.parse(v1[i]) : 0;
    int num2 = i < v2.length ? int.parse(v2[i]) : 0;

    if (num1 > num2) {
      return 1;
    } else if (num1 < num2) {
      return -1;
    }
  }

  // 比较构建号
  int buildNumber1 = int.parse(version1.split('+')[1]);
  int buildNumber2 = int.parse(version2.split('+')[1]);

  if (buildNumber1 > buildNumber2) {
    return 1;
  } else if (buildNumber1 < buildNumber2) {
    return -1;
  }

  return 0;
}

String formatDuration(Duration duration) {
  String hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  if (hours == '00' && minutes == '00' && seconds[0] == '0') {
    seconds = seconds[1];
  }

  String formattedTime = '';
  if (hours != '00') {
    formattedTime += '$hours:';
  }
  if (hours != '00' || minutes != '00') {
    formattedTime += '$minutes:';
  }
  formattedTime += seconds;

  return formattedTime;
}

double formatDecimal(double number, {int decimals = 2}) {
  double formattedDecimal = double.parse(number.toStringAsFixed(2));
  return formattedDecimal;
}

extension FixedDecimal on double {
  fixed({int decimals = 2}) => formatDecimal(this, decimals: decimals);
}

Future<T?> showAppDialog<T>(
  Widget widget, {
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useSafeArea = true,
  GlobalKey<NavigatorState>? navigatorKey,
  Object? arguments,
  Duration? transitionDuration,
  Curve? transitionCurve,
  String? name,
  RouteSettings? routeSettings,
}) {
  final context = Get.context;
  final theme = Theme.of(context!);
  return Get.generalDialog<T>(
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      final pageChild = widget;
      Widget dialog = Builder(builder: (context) {
        return Theme(data: theme, child: pageChild);
      });
      if (useSafeArea) {
        dialog = SafeArea(child: dialog);
      }
      return dialog;
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor ?? Colors.black54,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 150),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.easeInOut.transform(animation.value);
      return Transform.scale(
        scale: curve,
        child: child,
      );
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: transitionCurve ?? Curves.easeOutQuad,
        ),
        child: child,
      );
    },
    navigatorKey: navigatorKey,
    routeSettings:
        routeSettings ?? RouteSettings(arguments: arguments, name: name),
  );
}

Future<File> saveImage(Uint8List imageByte) async {
  var tempDir = await getTemporaryDirectory();
  //生成file文件格式
  var file =
      await File('${tempDir.path}/image_${DateTime.now().millisecond}.jpg')
          .create();
  //转成file文件
  return await file.writeAsBytes(imageByte);
}

throttle(Function func, int milliseconds) {
  bool enable = true;
  return () {
    if (enable == true) {
      enable = false;
      func();
      Future.delayed(Duration(milliseconds: milliseconds), () {
        enable = true;
      });
    }
  };
}

void Function() debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  target() {
    timer?.cancel();
    timer = Timer(delay, () {
      func.call();
    });
  }

  return target;
}

copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text))
      .then((value) => Toast.showSuccess('复制成功'.tr));
}
