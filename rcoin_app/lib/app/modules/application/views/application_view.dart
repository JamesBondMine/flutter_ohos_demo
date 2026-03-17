import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/bindings/home_binding.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/home/views/home_view.dart';
import 'package:otc_app/app/modules/mine/bindings/mine_binding.dart';
import 'package:otc_app/app/modules/mine/views/mine_view.dart';
import 'package:otc_app/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:otc_app/app/modules/notifications/views/notifications_view.dart';
import 'package:otc_app/app/modules/transfer/bindings/transfer_binding.dart';
import 'package:otc_app/app/modules/transfer/views/wallet_page.dart';
import 'package:otc_app/app/widgets/double_click_exit.dart';
import 'package:otc_app/app/widgets/service_button.dart';
import 'package:otc_app/network/api.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/application_controller.dart';

class ApplicationView extends GetView<ApplicationController>
    with DoubleClickExit {
  ApplicationView({Key? key}) : super(key: key);

  Route? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.HOME => GetPageRoute(
          settings: settings,
          page: () => const HomeView(),
          binding: HomeBinding(),
          transition: Transition.noTransition,
        ),
      Routes.POST_BUY_ORDER => GetPageRoute(
          settings: settings,
          page: () => const WalletPage(),
          binding: TransferBinding(),
          transition: Transition.noTransition,
        ),
      Routes.NOTIFICATIONS => GetPageRoute(
          settings: settings,
          page: () => const NotificationsView(),
          binding: NotificationsBinding(),
          transition: Transition.noTransition,
        ),
      Routes.MINE => GetPageRoute(
          settings: settings,
          page: () => const MineView(),
          binding: MineBinding(),
          transition: Transition.noTransition,
        ),
      _ => null
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handlerExit('再按一次退出应用'.tr),
      child: Scaffold(
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: Routes.HOME,
          onGenerateRoute: onGenerateRoute,
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //     //悬浮按钮
        //     backgroundColor: const Color(0xffc478ff),
        //     elevation: 0,
        //     shape: const CircleBorder(),
        //     child: GestureDetector(
        //       behavior: HitTestBehavior.translucent,
        //       onTap: () async {
        //         var scanData = await Get.toNamed(Routes.SCAN_PAGE);
        //         if (scanData != null) {
        //           if (scanData is String) {
        //             controller.postUserCoinPay(scanData);
        //             return;
        //           }
        //           String? code = (scanData as Barcode).code;
        //           logger.e('code>>>>>>>>>>111>>>', code);
        //           controller.postUserCoinPay(code!);
        //         }
        //       },
        //       child: Container(
        //         width: 48.w,
        //         height: 48.w,
        //         decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //         ),
        //         alignment: Alignment.center,
        //         child: CustomImage(
        //           Assets.otherScanBarcode,
        //           color: Colors.white,
        //           width: 24.w,
        //         ),
        //       ),
        //     ),
        //     onPressed: () {}),
        bottomNavigationBar: bottomNavigationBar(context, (index) {
          if (controller.navIndex.value == index) {
            return;
          }
          if (index == 1) {
            Api.payments();
          }
          showFloatButton(show: index == 0);

          var route = controller.navs[index].$4;
          if ([
            Routes.MINE,
          ].contains(route)) {
            if (!UserService.to.isLogin) {
              UserService.to.logout();
              return;
            }
          }
          Get.toNamed(route, id: 1);
          Get.find<HomeController>().fetchData();
          controller.navIndex.value = index;
        }),
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context, Function(int) onTap) {
    return BottomAppBar(
      height: 65.w,
      color: Config.kTheme!.bgbtn,
      shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              onTap(0);
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              // width: 60,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        controller.navIndex.value == 0
                            ? Assets.navHomeLight
                            : Assets.navHome,
                        color: controller.navIndex.value == 0
                            ? Config.kTheme!.text1
                            : Config.kTheme!.text2,
                        // color: controller.navIndex.value == 0
                        //     ? context.appColors.primary
                        //     : const Color(0xffC1C1C1),
                      ),
                      Text(
                        '首页'.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: controller.navIndex.value == 0
                              ? Config.kTheme!.text1
                              : Config.kTheme!.text2,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap(1);
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              // width: 60,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        controller.navIndex.value == 1
                            ? Assets.navMerchantLight
                            : Assets.navMerchant,
                        color: controller.navIndex.value == 1
                            ? Config.kTheme!.text1
                            : Config.kTheme!.text2,
                      ),
                      Text(
                        '钱包'.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: controller.navIndex.value == 1
                              ? Config.kTheme!.text1
                              : Config.kTheme!.text2,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          // Padding(padding: EdgeInsets.only(left: 4.w)),
          _scanView(),
          GestureDetector(
            onTap: () {
              onTap(2);
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              // width: 60,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                              child: Padding(
                            padding: EdgeInsets.only(
                                left: 5.w, right: 5.w, top: 3.w),
                            child: CustomImage(
                              controller.navIndex.value == 2
                                  ? Assets.navExchangeLight
                                  : Assets.navExchange,
                              color: controller.navIndex.value == 2
                                  ? Config.kTheme!.text1
                                  : Config.kTheme!.text2,
                            ),
                          )),
                          HomeController.to.unreadCount.value < 1
                              ? Container()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.sp),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        color: Colors.red),
                                    child: Text(
                                      "${HomeController.to.unreadCount.value}",
                                      style: TextStyle(
                                          fontSize: 9.sp, color: Colors.white),
                                    ),
                                  ))
                        ],
                      ),

                      //
                      Text('消息'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: controller.navIndex.value == 2
                                ? Config.kTheme!.text1
                                : Config.kTheme!.text2,
                          )),
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap(3);
            },
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              // width: 60,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        controller.navIndex.value == 3
                            ? Assets.navMineLight
                            : Assets.navMine,
                        color: controller.navIndex.value == 3
                            ? Config.kTheme!.text1
                            : Config.kTheme!.text2,
                      ),
                      Text(
                        '我的'.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: controller.navIndex.value == 3
                              ? Config.kTheme!.text1
                              : Config.kTheme!.text2,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ], //均分底部导航栏横向空间
      ),
    );
  }

  Widget _scanView() {
    return GestureDetector(
      onTap: () {
        // onTap(1);
        _scanEvent();
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        // width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              Assets.otherScanBarcode,
              // color: Colors.white,
              width: 44.w,
            )
          ],
        ),
      ),
    );
  }

  Future _scanEvent() async {
    var scanData = await Get.toNamed(Routes.SCAN_PAGE);
    if (scanData != null) {
      if (scanData is String) {
        controller.postUserCoinPay(scanData);
        return;
      }
      String? code = (scanData as Barcode).code;
      logger.e('code>>>>>>>>>>111>>>', error: code);
      controller.postUserCoinPay(code!);
    }
  }
}
