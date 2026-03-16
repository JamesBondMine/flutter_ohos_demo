import 'package:flutter/material.dart';

/// 应用主题配置
class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue.shade600,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      );
}
