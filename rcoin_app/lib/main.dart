import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/extensions/custom_scroll_extension.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:otc_app/services/pusher.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'intl/intl.dart';
import 'notification_controller.dart';

init() async {
  await Config.init();
  //初始化存储
  await _initStorage();
  //初始化用户和系统服务
  _initBinding();
  //初始化通知
  await notificationInit();
  //初始化推送
  await Pusher.getInstance().init();
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  // if (Platform.isAndroid && !kDebugMode) {
  // checkUpgrade();
  //   Timer.periodic(const Duration(minutes: 1), (timer) {
  //     checkUpgrade();
  //   });
  // }
}

_initBinding() {
  Get.put(AppService());
  Get.put(UserService());
  Get.put(ChatService());
}

_initStorage() async {
  await Hive.initFlutter();
  await Hive.openBox('app');
}

OverlayEntry? overlayEntry;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    //请求通知授权
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    FlutterNativeSplash.remove();

    //设置默认语言
    AppService.to.setLocale(locales.first.$1);
  }

  @override
  void dispose() {
    AppService.to.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          translations: IntlMessages(),
          locale: AppService.to.getLocale(),
          fallbackLocale: AppService.to.defaultLocale,
          theme: appThemeData,
          initialRoute: Routes.APPLICATION,
          getPages: AppPages.routes,
          scrollBehavior: CustomScrollBehavior(),
          routingCallback: (Routing? value) {
            // if (value?.current == Routes.APPLICATION) {
            //   tryCatch(() {
            //     showFloatButton(show: ApplicationController.to.navIndex.value == 0);
            //   });
            //
            // } else {
            //   showFloatButton(show: false);
            // }
            // 切换页面清空当前 Toast
            Toast.hideLoading();
            overlayEntry?.remove();
            overlayEntry = null;
          },
          navigatorObservers: [
            Toast.toastNavigatorObserver(),
          ],
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            flc.CountryLocalizations.delegate,
          ],
          supportedLocales: [
            ...locales.map((e) => e.$1).toList(),
            ...flc.supportedLocales.map(Locale.new),
          ],
          transitionDuration: const Duration(milliseconds: 150),
          defaultTransition: Transition.cupertino,
          builder: (context, child) {
            child = GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => hideKeyboard(context),
              child: child!,
            );
            return Toast.init(context, child);
          },
        );
      },
    );
  }
}
