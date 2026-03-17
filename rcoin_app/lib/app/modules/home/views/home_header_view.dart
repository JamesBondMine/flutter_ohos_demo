import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/home/auth/pages/auth_IDcard_page.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/home/model/home_banner.dart';
import 'package:otc_app/app/modules/home/views/home_botton_view.dart';
import 'package:otc_app/app/modules/home/views/home_swiper_view.dart';
import 'package:otc_app/app/modules/home/views/home_view_old.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_success.dart';
import 'package:otc_app/app/modules/trade/views/trade_buysell_page.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/services/chat_service.dart';

class HomeHeaderView extends GetView<HomeController> {
  const HomeHeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _welcomeView(context),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
              child: Container(
                // color: Colors.black,
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 4.w, bottom: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    8.w.vb,
                    _headCardView(),
                    _noticeView(),
                    Container(
                      padding: EdgeInsets.only(top: 14.w, bottom: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Config.kTheme!.bg1),
                      child: const HomeButtons(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.w),
                      padding: EdgeInsets.only(top: 16.w, bottom: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Config.kTheme!.bg1),
                      child: Column(
                        children: [
                          _coinDetailView(),
                          20.w.vb,
                          _tradeView(context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    _homeOrderView(context),
                    // _headCard1View()
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _homeOrderView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Get.toNamed(Routes.TRADE, arguments: {
            //   "side": PaySide.sell,
            // });
            Get.toNamed(Routes.ADVERTISE);
          },
          child: Container(
            width: Get.width / 2 - 20,
            height: 56.w,
            decoration: BoxDecoration(
                color: const Color(0xff3C3832),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Config.kTheme!.bg3, Color(0xffd8fff8)]),
                borderRadius: BorderRadius.circular(8.w)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  Assets.homeHung,
                  width: 18.w,
                ),
                3.w.hb,
                Text(
                  '我的挂单'.tr,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Config.kTheme!.text1,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Get.toNamed(Routes.TRADE, arguments: {
            //   "side": PaySide.buy,
            // });
            Get.toNamed(Routes.HISTORY_ORDERS);
          },
          child: Container(
            width: Get.width / 2 - 20,
            height: 56.w,
            decoration: BoxDecoration(
                color: const Color(0xff3C3832),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Config.kTheme!.bg3,
                      Color(0xffd8fff8),
                    ]),
                borderRadius: BorderRadius.circular(8.w)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  Assets.homeOrder,
                  width: 18.w,
                ),
                3.w.hb,
                Text(
                  '我的订单'.tr,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Config.kTheme!.text1,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  // 认证弹窗
  _userAuthEvent(BuildContext c, VoidCallback push) async {
    push();
    return;
    AuthModel? res = await controller.authApplyStateInfo();
    if (res != null && res.id != 0 && res.state == 0) {
      Toast.showInfo("审核中".tr);
      return;
    }
    if (res != null && res.state == 1) {
      // 通过
      push();
      return;
    }
    Get.dialog(Builder(builder: (context) {
      return Container(
          padding: EdgeInsets.only(
              bottom: (Get.height - 360) / 2,
              left: 20,
              right: 20,
              top: (Get.height - 360) / 2),
          child: Center(
              child: Container(
                  height: 200.w,
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xff232322),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: const CustomImage(
                            Assets.alertHead,
                          ),
                        ),
                      ),
                      Positioned.fill(child: _authAlertChildView(c))
                    ],
                  ))));
    }));
  }

  // 弹窗子视图
  Widget _authAlertChildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const SizedBox(
                width: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Material(
                child: Text(
                  '温馨提示'.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.close,
                  color: const Color(0xff9b9d9c),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
                child: Text(
              "Please complete".tr,
              style: TextStyle(
                fontSize: 15.sp,
                color: const Color(0xffaeaeae),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Material(
                child: Text(
              "'authentication'".tr,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ))
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: 'cancel'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: Colors.black.withOpacity(0),
                borderSide:
                    const BorderSide(color: Color(0xff5d4c30), width: 0.8),
                onPressed: () {
                  Get.back();
                },
                radius: 8.w,
              ),
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: 'user auth'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: const Color(0xfff4e0bd),
                onPressed: () {
                  Get.back();
                  Get.to(AuthIDCardPage());
                },
                radius: 8.w,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _tradeView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            // 判断是否实名认证
            _userAuthEvent(context, () {
              Get.to(TradeBuySellPage(index: 0));
            });
          },
          // backgroundColor: Config.kTheme!.bg3,
          // radius: 22.r,
          child: Container(
            width: Get.locale!.languageCode == 'zh' ? 76.w : 160.w,
            height: 44.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffA7F2FF), Color(0xff52D0F9)])),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  Assets.homeBuy,
                  width: 20.w,
                ),
                5.w.hb,
                Text(
                  '买币'.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Config.kTheme!.bgw,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppButton(
          width: Get.locale!.languageCode == 'zh' ? 76.w : 160.w,
          height: 44.w,
          onPressed: () {
            // 判断是否实名认证
            _userAuthEvent(context, () {
              Get.to(TradeBuySellPage(index: 1));
            });
          },
          backgroundColor: Colors.white.withOpacity(0),
          borderSide: BorderSide(
              color: Config.kTheme!.text2.withOpacity(0.5), width: 0.5),
          radius: 22.r,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                Assets.homeSell,
                width: 20.w,
              ),
              5.w.hb,
              Text(
                '卖币'.tr,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Config.kTheme!.text1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _coinDetailView() {
    TextStyle desc = TextStyle(
        color: Config.kTheme!.text2,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500);
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
      ),
      child: SizedBox(
        // height: 32.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(
                              ApplicationController.to.assets.value?.money ?? 0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '可用余额'.tr,
                  style: desc,
                ),
              ],
            ),
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(
                              ApplicationController.to.assets.value?.deposit ??
                                  0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '冻结中'.tr,
                  style: desc,
                ),
              ],
            ),
            Column(
              children: [
                Obx(() => Text(
                      normalMoney(ApplicationController
                                  .to.assets.value?.tradeAmount ??
                              0)
                          .toString(),
                      style: _amountStyle(),
                    )),
                3.w.vb,
                Text(
                  '交易中'.tr,
                  style: desc,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _amountStyle() {
    return TextStyle(
        color: Config.kTheme!.text1,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500);
  }

  Widget _noticeView() {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              Assets.homeotice,
              width: 18,
              height: 18,
              color: Config.kTheme!.text2,
            ),
            5.w.hb,
            Obx(() => Text(
                  controller.notices.isEmpty
                      ? ''
                      : (controller.notices.last.title ?? ''),
                  style:
                      TextStyle(color: Config.kTheme!.text2, fontSize: 13.sp),
                ))
          ],
        ));
  }

  Future<List> _bannerViewEvent() async {
    AppResponse res = await NetRepository.client.bannerList();
    final resdata = res.data;
    return resdata.list;
  }

  Widget _headCard1View() {
    return FutureBuilder(
        future: _bannerViewEvent(),
        builder: ((context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Container();
          }
          return Container(
            width: Get.width - 32,
            height: 120.w,
            margin: EdgeInsets.only(top: 8.w),
            child: HomeSwiperView(items: snapshot.data!),
          );
        }));
  }

  Widget _headCardView() {
    return GetBuilder<HomeController>(
        id: controller.amountEncryptRefreshId,
        builder: (v) {
          return Container(
            width: Get.width,
            height: 152.w,
            padding: EdgeInsets.only(top: 0.w, left: 16.w, bottom: 15.w),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(Assets.homeCard1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.amountEncryption =
                            !controller.amountEncryption;
                        controller.updateAmountEncryptRefresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          bottom: 20,
                        ),
                        child: Row(
                          children: [
                            Text('可用余额'.tr,
                                style: TextStyle(
                                    color: Config.kTheme!.text1,
                                    fontSize: 12.sp)),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomImage(
                              controller.amountEncryption
                                  ? Assets.homeEye2
                                  : Assets.homeEye1,
                              color: Config.kTheme!.text1,
                              width: 20.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    _actview(),
                  ],
                ),
                3.w.vb,
                Obx(() => Row(children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: controller.amountEncryption
                                  ? '********'
                                  : '${normalMoney(ApplicationController.to.assets.value?.money ?? 0)} ',
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Config.kTheme!.text1,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: Config.coinName,
                              style: TextStyle(
                                  color: Config.kTheme!.text1,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      )
                    ])),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    copyToClipboard(
                        ApplicationController.to.assets.value?.address ?? '');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text('wallet address: '.tr,
                            style: TextStyle(
                                color: Config.kTheme!.text1.withOpacity(0.7),
                                fontSize: 12.sp)),
                        Expanded(
                          child: Obx(() => Text(
                              ApplicationController.to.assets.value?.address ??
                                  '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Config.kTheme!.text1.withOpacity(0.7),
                                  fontSize: 12.sp))),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(Icons.copy,
                            size: 12.w,
                            color: Config.kTheme!.text1.withOpacity(0.7)),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<HomeBanner?> _actEvent() async {
    HomeBanner? banner = await Api.loadBannerListInfo();

    // 查询
    final box = Hive.box('app');
    String activityUrl = box.get("activityUrl") ?? "";

    // if (activityUrl.isNotEmpty &&
    //     banner != null &&
    //     banner.thumb == activityUrl) {
    //   return null;
    // }
    return banner;
  }

  Widget _actview() {
    return FutureBuilder(
        future: _actEvent(),
        builder: ((context, AsyncSnapshot<HomeBanner?> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Container();
          }
          return GestureDetector(
            onTap: () {
              HomeBanner bn = snapshot.data!;
              _alertView(bn.thumb!, bn.url!);
            },
            child: Container(
              height: 42,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 242),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      topRight: Radius.circular(12))),
              padding:
                  const EdgeInsets.only(left: 40, right: 10, top: 8, bottom: 8),
              child: Row(
                children: [
                  const CustomImage(
                    Assets.actGiftIcon,
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "REWARD".tr,
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "154".tr,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Text(
                            "INRU".tr,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: 38,
                    height: 24,
                    margin: const EdgeInsets.only(left: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(155)),
                    child: Text(
                      "Get".tr,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  _alertView(String pictureUrl, String tapUrl) async {
    Get.dialog(
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width - 30,
                child: Container(
                  width: Get.width - 32,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  // height: Get.width + 50,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff131313)),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: pictureUrl,
                        width: Get.width - 32,
                        placeholder: ((context, url) {
                          return Container();
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              width: Get.width / 2 - 80.w,
                              height: 44.w,
                              title: '关闭'.tr,
                              titleStyle:
                                  const TextStyle(color: Color(0xff5d4c30)),
                              backgroundColor: const Color(0xfff4e0bd),
                              onPressed: () {
                                Get.back();
                              },
                              radius: 8.w,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // color: Colors.amber,
        ),
        barrierDismissible: false);
  }

  Widget _welcomeView(BuildContext context) {
    return Container(
      // height: 120,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 0.w,
          left: 12.w,
          right: 12.w),
      decoration: const BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(
              image: AssetImage(
                Assets.homeHeaderbg,
              ),
              fit: BoxFit.fill)),
      child: Row(
        children: [
          5.w.hb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    children: [
                      Container(
                        child: Text(
                          UserService.to.user.value.nickName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp, color: Config.kTheme!.text3),
                        ),
                      ),
                      10.w.hb,
                    ],
                  )),
              2.w.vb,
              Text(
                'Welcome to Gopay',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const Spacer(),
          Container(
            width: 48.w,
            height: 48.w,
            child: Center(
              child: CustomImage(
                Assets.newimagesHomeService,
                color: Config.kTheme!.text1,
                onTap: () {
                  ChatService.to.goChatWithService();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
