import 'package:appbyflutter/core/utils/gbs_color.dart';
import 'package:flutter/material.dart';

/// 应用主题配置
class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: GbsColors.primaryColor,
          primary: GbsColors.primaryColor,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      );
}
