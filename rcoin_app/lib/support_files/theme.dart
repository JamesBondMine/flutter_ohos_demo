import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppTheme on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.textPlaceholder,
    required this.textFieldFill,
    required this.divider1,
    required this.divider2,
    required this.comFFF,
    required this.com000,
    required this.background,
    required this.backgroundGrey,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
    required this.red,
    required this.green,
  });

  final Color primary;
  final Color secondary;
  final Color text1;
  final Color text2;
  final Color text3;
  final Color text4;
  final Color textPlaceholder;
  final Color textFieldFill;
  final Color divider1;
  final Color divider2;
  final Color comFFF;
  final Color com000;
  final Color background;
  final Color backgroundGrey;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final Color red;
  final Color green;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? text1,
    Color? text2,
    Color? text3,
    Color? text4,
    Color? textPlaceholder,
    Color? textFieldFill,
    Color? divider1,
    Color? divider2,
    Color? comFFF,
    Color? com000,
    Color? background,
    Color? backgroundGrey,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? red,
    Color? green,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      text4: text4 ?? this.text4,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      textFieldFill: textFieldFill ?? this.textFieldFill,
      divider1: divider1 ?? this.divider1,
      divider2: divider2 ?? this.divider2,
      comFFF: comFFF ?? this.comFFF,
      com000: com000 ?? this.com000,
      background: background ?? this.background,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      shimmerBaseColor: shimmerBaseColor ?? this.shimmerBaseColor,
      shimmerHighlightColor:
          shimmerHighlightColor ?? this.shimmerHighlightColor,
      red: red ?? this.red,
      green: green ?? this.green,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      text3: Color.lerp(text3, other.text3, t)!,
      text4: Color.lerp(text4, other.text4, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t)!,
      divider1: Color.lerp(divider1, other.divider1, t)!,
      divider2: Color.lerp(divider2, other.divider2, t)!,
      comFFF: Color.lerp(comFFF, other.comFFF, t)!,
      com000: Color.lerp(com000, other.com000, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t)!,
      shimmerBaseColor:
          Color.lerp(shimmerBaseColor, other.shimmerBaseColor, t)!,
      shimmerHighlightColor:
          Color.lerp(shimmerHighlightColor, other.shimmerHighlightColor, t)!,
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
    );
  }
}

const _appColors = AppColors(
  primary: Color(0xff5D4C30),
  secondary: Color(0xFFE85921),
  text1: Color(0xFF333333),
  text2: Color(0xFF525A60),
  text3: Color(0xFF8E959B),
  text4: Color(0xFF666666),
  textPlaceholder: Color(0xFF999999),
  textFieldFill: Color(0xFFFAFAFA),
  divider1: Color(0xFFFAFAFA),
  divider2: Color(0xFFEFEFEF),
  comFFF: Color(0xFFFFFFFF),
  com000: Color(0xFF000000),
  background: Color(0xFFf9f9f9),
  backgroundGrey: Color(0xFFFAFAFA),
  shimmerBaseColor: Color(0xFFDFDFDF),
  shimmerHighlightColor: Color(0xFFCCCCCC),
  red: Color(0xffFF1010),
  green: Color(0xff2AC769),
);

/// 默认主题配置
final appThemeData = ThemeData(
  fontFamily: 'Poppins',
  textSelectionTheme: TextSelectionThemeData(cursorColor: _appColors.primary),
  primaryColor: _appColors.primary,
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: _appColors.background,
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: _appColors.text1,
      // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
      fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
    ),
    // 大部分地方的文字颜色
    titleMedium: TextStyle(
      color: _appColors.text1,
      // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
      fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
    ),
  ),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    primaryColor: _appColors.primary,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        // fontFamily: 'PingFang SC',
        color: _appColors.text1,
        // Flutter 3.X，在苹果机上中文字重渲染有问题，需要指定字体修复
        fontFamilyFallback: Platform.isIOS ? const ['PingFang SC'] : null,
      ),
      navTitleTextStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: _appColors.text1,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _appColors.comFFF,
    iconTheme: IconThemeData(color: _appColors.text1),
    titleTextStyle: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: _appColors.text1,
    ),
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: kSystemUiOverlayStyle,
  ),
  dividerColor: _appColors.divider2,
  dividerTheme: DividerThemeData(
    color: _appColors.divider2,
    thickness: 1.w,
  ),
  highlightColor: Colors.black.withOpacity(0.05),
  extensions: const [_appColors],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    shape: const StadiumBorder(),
    elevation: 0,
  )),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    suffixIconColor: const Color(0xffc2c2c2),
    prefixIconColor: const Color(0xffc2c2c2),
    hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xff999999)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: const Color(0xffC2C2C2), // 自定义焦点时的边框颜色
        width: 1.w, // 自定义焦点时的边框宽度
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: const Color(0xffC2C2C2), // 自定义焦点时的边框颜色
        width: 1.w, // 自定义焦点时的边框宽度
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: const Color(0xffC2C2C2), // 自定义焦点时的边框颜色
        width: 1.w, // 自定义焦点时的边框宽度
      ),
    ),
  ),
);

const kDefaultAnimationDuration = Duration(milliseconds: 250);
const kDefaultPaddingLR = 16.0;
const kDefaultRadius = 4.0;

const kSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

const kSystemUiOverlayStyleDark = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

Widget bottomSlideAnimation(
  BuildContext context,
  Animation<double> animation,
  Widget child,
) {
  final slideAnimation =
      Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
          .chain(CurveTween(curve: Curves.easeOut))
          .animate(animation);
  return Align(
    alignment: Alignment.bottomCenter,
    child: SlideTransition(
      position: slideAnimation,
      child: child,
    ),
  );
}

Widget popFadeAnimation(
    BuildContext context, Animation<double> animation, Widget child) {
  Animation<double> curve = CurvedAnimation(
    parent: animation,
    curve: Curves.slowMiddle,
  );
  final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
  final scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: child,
    ),
  );
}
