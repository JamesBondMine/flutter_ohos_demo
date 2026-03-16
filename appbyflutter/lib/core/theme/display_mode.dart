/// 显示模式：普通模式 / 长辈模式（大字体）
enum DisplayMode {
  /// 普通模式，标准字体
  normal,

  /// 长辈模式，放大字体便于阅读
  elder,
}

extension DisplayModeExtension on DisplayMode {
  String get label {
    switch (this) {
      case DisplayMode.normal:
        return '普通模式';
      case DisplayMode.elder:
        return '长辈模式';
    }
  }

  /// 文字缩放系数，用于 ThemeData.textTheme
  double get textScaleFactor {
    switch (this) {
      case DisplayMode.normal:
        return 1.0;
      case DisplayMode.elder:
        return 1.25;
    }
  }
}
