import 'package:appbyflutter/pages/auth/login_page.dart';
import 'package:appbyflutter/pages/auth/display_mode_selection_page.dart';
import 'package:appbyflutter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/controllers/auth_controller.dart';
import 'package:appbyflutter/controllers/display_mode_controller.dart';
import 'package:appbyflutter/core/constants/app_constants.dart';
import 'package:appbyflutter/core/theme/app_theme.dart';

/// 应用根 Widget：GetX + 主题 + 普通/长辈模式（字体缩放）
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayModeController());
    Get.put(AuthController());

    final displayController = Get.find<DisplayModeController>();

    return Obx(() {
      final textScale = displayController.textScaleFactor;
      return GetMaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.theme,
        home: const AppEntry(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: textScale,
            ),
            child: child!,
          );
        },
      );
    });
  }
}

/// 根据「是否已选显示模式」+「登录状态」决定首屏：模式选择页 / 登录页 / 首页
class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final displayController = Get.find<DisplayModeController>();
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (!displayController.hasChosenDisplayMode.value) {
        return const DisplayModeSelectionPage();
      }
      if (!authController.isLoggedIn.value) {
        return const LoginPage();
      }
      return const HomePage();
    });
  }
}
