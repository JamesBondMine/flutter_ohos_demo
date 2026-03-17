import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/notification_icon.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/network/response/trade_coin_market_fon.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F5F7),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 204.w,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.97, 0.23),
                      end: Alignment(0.97, -0.23),
                      colors: [
                        Color(0xFFF6D944),
                        Color(0xFFF6C229),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AAppBar(
                  backgroundColor: Colors.transparent,
                  title: '',
                  isRootNavigator: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.NOTIFICATIONS);
                      },
                      icon: Obx(() => NotificationIcon(
                            showNotification: controller.unreadCount.value > 0,
                            child: SvgPicture.asset(
                              Assets.homeNotification,
                              width: 20.w,
                            ),
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        ChatService.to.goChatWithService();
                      },
                      icon: Obx(() => NotificationIcon(
                            showNotification: ChatService.to.unread > 0,
                            child: SvgPicture.asset(
                              Assets.imagesService,
                              width: 20.w,
                            ),
                          )),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: 0.80,
                          child: Text(
                            '${'余额'.tr}(${Config.coinName})',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.65),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      15.w.vb,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => Text(
                                    normalMoney((ApplicationController
                                                    .to.assets.value?.money ??
                                                0) +
                                            (ApplicationController
                                                    .to.assets.value?.deposit ??
                                                0))
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                    ),
                                  ))
                            ],
                          ),
                          Opacity(
                            opacity: 0.70,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.toNamed(Routes.RECHARGE);
                              },
                              child: Container(
                                width: 71.w,
                                height: 24.w,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: StadiumBorder(),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '购买'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      20.w.vb,
                      Container(
                        padding: const EdgeInsets.all(19).w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8).r),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.80,
                                  child: Text(
                                    '可用余额'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.65),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                2.w.vb,
                                Obx(() => Text(
                                      normalMoney(ApplicationController
                                                  .to.assets.value?.money ??
                                              0)
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ))
                              ],
                            ),
                            Container(
                              width: 1.w,
                              height: 30.w,
                              decoration:
                                  const BoxDecoration(color: Color(0xFFE5E5E5)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.80,
                                  child: Text(
                                    '冻结'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.65),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                2.w.vb,
                                Obx(() => Text(
                                      normalMoney(ApplicationController
                                                  .to.assets.value?.deposit ??
                                              0)
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ))
                              ],
                            ),
                            Container(
                              width: 1.w,
                              height: 30.w,
                              decoration:
                                  const BoxDecoration(color: Color(0xFFE5E5E5)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Opacity(
                                  opacity: 0.80,
                                  child: Text(
                                    '进行中'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.65),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                2.w.vb,
                                Obx(() => Text(
                                      normalMoney(ApplicationController.to
                                                  .assets.value?.tradeAmount ??
                                              0)
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      16.w.vb,
                      Container(
                        padding: const EdgeInsets.all(10).w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFE5E5E5)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 343.w,
                              height: 20.w,
                              child: Obx(() {
                                if (controller.notices.isEmpty) {
                                  return Container();
                                }
                                return Marquee(
                                  text: controller.notices.last.title ?? '',
                                  style: TextStyle(fontSize: 12.sp),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 400.0,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      13.w.vb,
                      Container(
                        padding: const EdgeInsets.only(
                                left: 17, top: 14, right: 7, bottom: 16)
                            .w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '当前汇率'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.65),
                                fontSize: 12.sp,
                              ),
                            ),
                            4.w.vb,
                            Row(
                              children: [
                                Obx(() => Text(
                                      '${controller.rcoinMarket?.price}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                // 21.w.hb,
                                // Obx(() => Text(
                                //   '${controller.rcoinMarket?.ud!.rtz}%',
                                //   style: TextStyle(
                                //       fontSize: 16.sp,
                                //       color: ((controller.rcoinMarket?.ud?? 0) > 0)
                                //           ? const Color(0xffF6465D)
                                //           : const Color(0xff04C2AD)),
                                // )),

                                const Expanded(child: SizedBox()),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Get.toNamed(Routes.WITHDRAW);
                                  },
                                  child: Opacity(
                                    opacity: 0.70,
                                    child: Container(
                                      width: 61.w,
                                      height: 24.w,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF7CC31),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '出售'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.w),
                      const _HotTokens(),
                    ],
                  ),
                ))
          ],
        ));
  }
}

class _QuickTools extends StatelessWidget {
  const _QuickTools({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomImage(Assets.homeCard),
        SizedBox(width: 5.w),
        Text(
          '快捷买卖',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: context.appColors.text1,
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          '交易自由，安全保证',
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class _HotTokens extends GetView<HomeController> {
  const _HotTokens({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '热门币种'.tr,
          style: TextStyle(
            fontSize: 15.sp,
            color: context.appColors.text1,
          ),
        ),
        11.w.vb,
        Container(
          alignment: Alignment.centerLeft,
          child: Obx(() => Wrap(
                spacing: 6.w,
                runSpacing: 6.w,
                children: controller.marketCoins
                    .map((element) => _TokenCard(element))
                    .toList(),
              )),
        )
      ],
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard(this.item, {super.key});

  final TradeCoinMarketFon item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4).r,
        color: const Color(0xfff6f9fc),
      ),
      padding: const EdgeInsets.all(6).w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.coinName!,
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${item.price}'.rtz,
                style:
                    TextStyle(fontSize: 13.sp, color: context.appColors.text1),
              ),
              10.w.vb,
              Text(
                '${item.ud!.rtz}%',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: item.ud! > 0
                        ? const Color(0xffF6465D)
                        : const Color(0xff04C2AD)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

normalMoney(double amount) {
  if (amount > 1000000) {
    return '${(amount / 1000).toStringAsFixed(1)}K';
  }
  return amount;
}

class ToolItem {
  final String assetPath;
  final String title;
  final GestureTapCallback onTap;

  ToolItem(this.assetPath, this.title, this.onTap);
}

class _Tools extends StatelessWidget {
  const _Tools({super.key});

  @override
  Widget build(BuildContext context) {
    List<ToolItem> list = <ToolItem>[
      ToolItem(Assets.homeReceive, '收款', () {
        Get.toNamed(Routes.RECEIPT);
      }),
      ToolItem(Assets.homeTransfer, '转账', () {
        Get.toNamed(Routes.TRANSFER);
      }),
      ToolItem(Assets.homeShare, '分享', () {
        Get.dialog(const ShareAppDialog());
      }),
      ToolItem(Assets.homeService, '在线客服', () async {
        ChatService.to.goChatWithService();
      }),
    ];
    return Container(
      padding: EdgeInsets.only(top: 13.w, bottom: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
          color: const Color(0xffefefef),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list
            .map((e) => Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: e.onTap,
                    child: Column(
                      children: [
                        CustomImage(
                          e.assetPath,
                          width: 20.w,
                          height: 20.w,
                          color: Config.kTheme!.text1,
                        ),
                        Text(
                          e.title,
                          style: TextStyle(
                              fontSize: 20.sp, color: Config.kTheme!.text1),
                        )
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
