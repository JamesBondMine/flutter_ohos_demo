import 'package:flutter/material.dart';
import 'package:otc_app/support_files/theme_base.dart';

class LightTheme extends BaseTheme {
  @override
  bool get isDark => false;

  @override
  Color get bgnav => const Color(0xFF000000);

  ///主色
  @override
  Color get bgpage => const Color(0xFF000000);

  @override
  Color get bgbtn => const Color(0xFFB7F1FC);

  @override
  Color get bgCard => const Color(0xFFB7F1FC);

  @override
  Color get bgMain => const Color(0xFF93D7E4);

  // @override
  // Color get blue => const Color(0xFF0075FF);

  // @override
  // Color get pink => const Color(0xFFF04E98);

  // @override
  // Color get yellow => const Color(0xFFFFB800);

  // @override
  // Color get cyanblue => const Color(0xFF1CBDB5);

  // @override
  // Color get lightPurple => const Color(0x1A7524F9);

  // @override
  // Color get lightLightPurple => const Color.fromARGB(26, 192, 156, 250);

  // @override
  // Color get lightBlueness => const Color(0x1A2AC8DD);

  // @override
  // Color get lightRed => const Color(0x1AF36464);

  // @override
  // Color get lightGreen => const Color(0x1A1BC89E);

  // @override
  // Color get lightOrange => const Color(0x1AFF8146);

  // @override
  // Color get lightBlue => const Color(0x1A64AEF3);

  // @override
  // Color get lightPink => const Color(0x1AF04E98);

  // @override
  // Color get lightYellow => const Color(0x1AFFB800);

  // @override
  // Color get lightCyanblue => const Color(0x1A1CBDB5);

  ///text color
  @override
  Color get text1 => const Color(0xFF333333);

  @override
  Color get text2 => const Color(0xFF042b32).withOpacity(0.5);

  @override
  Color get text3 => const Color(0xFF266d7a);

  @override
  Color get text4 => const Color(0xFF6d6d6d);

  @override
  Color get textVip => const Color.fromARGB(255, 101, 73, 40);

  @override
  Color get textLight => const Color.fromARGB(255, 221, 229, 229);

  ///widget background color
  @override
  Color get line =>
      const Color(0xFF042B32).withOpacity(0.2); //Color(0xFFF5F5F5);

  @override
  Color get bg1 => const Color(0xFFffffff).withOpacity(0.8);
  @override
  Color get bg2 => const Color(0xFFF2F2F5);
  @override
  Color get bg3 => const Color(0xFFa7f2ff);
  @override
  Color get bgw => const Color(0xFFFFFFFF);
  @override
  Color get bg5 => const Color(0xFF52d0f9);

  @override
  Color get bgVipbtn => const Color.fromARGB(255, 248, 216, 165);

  @override
  Color get bgline => const Color(0xFFE5E5E5);
  @override
  Color get bgdark => const Color(0xFF99E6ff);
  @override
  Color get bgdarkcard => const Color(0xFF242E3D).withAlpha(230);
  @override
  Color get bgdarkbtn => const Color(0xFF4F5763).withAlpha(150);
  @override
  Color get textdarktitle => const Color(0xFFE0E0E0);
  @override
  Color get textdarkdesc => const Color(0xFF9E9E9E);

  @override
  Color get bgblack => const Color.fromARGB(255, 3, 3, 3);

  @override
  Color get token_default => const Color(0xFF8F95AA);

  @override
  Color get base_layer => const Color(0xFFF8F8F9);

  @override
  Color get colorDisable => const Color(0xFFDADBDE);

  @override
  Color get colorBlack => Colors.black;

  @override
  Color get colorConstWhite => Colors.white;

  @override
  Color get buttonPress => const Color(0xFF2E40E5);

  @override
  Color get textFocus => const Color(0xFF495BFF);

  @override
  Color get colorBtnText => const Color(0xFFFFFFFF);

  @override
  Color get klineCurrentBg => const Color(0xFFEDEFFF);
}
