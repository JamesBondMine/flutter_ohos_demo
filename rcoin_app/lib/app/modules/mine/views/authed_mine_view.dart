import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/mine_controller.dart';

class AuthedMineView extends GetView<MineController> {
  const AuthedMineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerView(context),
            _Line(
              iconPath: Assets.whatsappIcon,
              title: UserService.to.user.value.userType == 1
                  ? 'Whatsapp'.tr
                  : '加入我们'.tr,
              onTap: () {
                if (UserService.to.user.value.userType != 1) {
                  _alertView();
                  return;
                }
                launchUrl(Uri.parse('https://wa.me/'));
              },
            ),
            6.w.vb,
            _Line(
              iconPath: Assets.userIcon1,
              title: '账号管理'.tr,
              onTap: () {
                Get.toNamed(Routes.ACCOUNT_DETAIL);
              },
            ),
            // 6.w.vb,
            // _Line(
            //   iconPath: Assets.userIcon2,
            //   title: '实名认证'.tr,
            //   onTap: () async {
            //     //判断
            //     AuthModel? res = await HomeController.to.authApplyStateInfo();
            //     if (res != null && res.id != 0 && res.state == 0) {
            //       Toast.showInfo("审核中".tr);
            //       return;
            //     }
            //     if (res == null || res.id == 0) {
            //       // 未认证直接去认证
            //       Get.to(AuthIDCardPage());
            //       return;
            //     }
            //     if (res != null && res.state == 1) {
            //       // 审核中
            //       Get.to(AuthResultPage(success: true));
            //       return;
            //     }
            //     Get.to(AuthResultPage(success: false));
            //   },
            // ),
            6.w.vb,
            _Line(
              iconPath: Assets.userIcon3,
              title: '语言切换'.tr,
              onTap: () {
                Get.toNamed(Routes.LANGUAGE_SWITCH);
              },
            ),
            // 14.w.vb,
            // _Line(
            //   iconPath: Assets.mineWithdraw,
            //   title: '提现'.tr,
            //   onTap: () {
            //     Get.toNamed(Routes.WITHDRAW);
            //   },
            // ),
            // 20.w.vb,
            // Text(
            //   '密码与安全'.tr,
            //   style: TextStyle(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xff171717),
            //   ),
            // ),
            // 12.w.vb,
            // _Line(
            //   iconPath: Assets.userIcon3,
            //   title: '交易密码'.tr,
            //   onTap: () {
            //     Get.toNamed(Routes.SET_PAY_PASSWORD, arguments: {
            //       "type": 2,
            //     });
            //   },
            // ),
            // 14.w.vb,
            // _Line(
            //   iconPath: Assets.userIcon4,
            //   title: '登录密码'.tr,
            //   onTap: () {
            //     Get.toNamed(Routes.UPDATE_PAY_PASSWORD, arguments: {
            //       "type": 1,
            //     });
            //   },
            // ),
            // 20.w.vb,
            // Text(
            //   '其他'.tr,
            //   style: TextStyle(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xff171717),
            //   ),
            // ),
            // 12.w.vb,
            // _Line(
            //   iconPath: Assets.userIcon5,
            //   title: '分享有礼'.tr,
            //   onTap: () {
            //     Get.toNamed(Routes.SHARE_PAGE);
            //   },
            // ),
            6.w.vb,
            _Line(
              iconPath: Assets.userIcon4,
              title: '关于我们'.tr,
              onTap: () {
                Get.toNamed(Routes.ABOUT_US);
              },
            ),
            6.w.vb,
            _AppVersion(),
            20.w.vb
          ],
        ),
      ),
    );
  }

  _alertView() async {
    Get.dialog(
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width - 30,
                child: Container(
                  width: Get.width - 32,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      CustomImage(
                        Assets.joinInvate,
                        width: Get.width - 32,
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
                                  TextStyle(color: Config.kTheme!.text2),
                              backgroundColor:
                                  const Color(0xfff4e0bd).withOpacity(0),
                              borderSide: BorderSide(
                                  width: 0.8, color: Config.kTheme!.text1),
                              onPressed: () {
                                Get.back();
                              },
                              radius: 22.w,
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

  Future<int> _authState() async {
    //判断
    AuthModel? res = await HomeController.to.authApplyStateInfo();
    if (res != null && res.id != 0 && res.state == 0) {
      return 1;
    }
    if (res == null || res.id == 0) {
      return 3;
    }
    if (res.state == 1) {
      return 2;
    }
    return 1;
  }

  Widget _authTagView() {
    return Container();
    return GetBuilder<MineController>(
        id: controller.userAuthRefreshId,
        builder: (value) {
          return FutureBuilder(
              future: _authState(),
              builder: ((context, AsyncSnapshot<int> snapshot) {
                if (!snapshot.hasData || snapshot.data == 0) {
                  return Container();
                }
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 6.w, top: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red),
                  child: Text(
                    snapshot.data == 3
                        ? "未认证".tr
                        : snapshot.data == 1
                            ? "审核中".tr
                            : '已认证'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }));
        });
  }

  Widget _headerView(BuildContext context) {
    return Container(
      width: Get.width,
      // color: Colors.black,
      // height: MediaQuery.of(context).padding.top + 150.w,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.walletHeader), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top - 8.w, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.SHARE_PAGE);
                    },
                    icon: CustomImage(
                      Assets.userIcon6,
                      width: 25.w,
                      height: 25.w,
                      color: Config.kTheme!.text1,
                    ))
              ],
            ),
          ),
          Obx(() => Padding(
                padding: EdgeInsets.only(top: 0.w, bottom: 1.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        UserService.to.uploadAvatar(context);
                      },
                      child: Container(
                        width: 88.w,
                        height: 88.w,
                        margin: EdgeInsets.only(left: 16.w, right: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(44.w),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Config.kTheme!.bgbtn,
                                  Color(0xff3BD6F4)
                                ])),
                        child: Stack(
                          children: [
                            UserService.to.user.value.headerImg != null
                                ? Positioned.fill(
                                    child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: UserService
                                                .to.user.value.headerImg ??
                                            "",
                                        errorWidget: (context, url, error) {
                                          return CustomImage(
                                            Assets.userIcon7,
                                            width: 80.w,
                                            height: 80.w,
                                            color: Config.kTheme!.text1,
                                          );
                                        },
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ))
                                : Positioned(
                                    left: 20,
                                    top: 20,
                                    right: 20,
                                    bottom: 20,
                                    child: CustomImage(
                                      Assets.userIcon7,
                                      width: 80.w,
                                      height: 80.w,
                                    )),
                            Positioned(
                                right: 3,
                                bottom: 3,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      border: Border.all(
                                          color: const Color(0xff6d6d6d),
                                          width: 0.6)),
                                  child: CustomImage(
                                    Assets.mineuHead,
                                    width: 15.w,
                                    height: 15.w,
                                    color: Config.kTheme!.text1,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _authTagView(),
                            Obx(() => Text(
                                UserService.to.user.value.nickName ?? "",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Config.kTheme!.text1,
                                    fontWeight: FontWeight.w600))),
                          ],
                        ),
                        10.w.vb,
                        Row(
                          children: [
                            UserService.to.user.value.id != null
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        "${'ID'.tr}： ${UserService.to.user.value.id}",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Config.kTheme!.text2,
                                            fontWeight: FontWeight.w600)))
                                : Container(),
                            CopyBtn(
                                text: "${UserService.to.user.value.id}",
                                color: Config.kTheme!.text2,
                                size: 12.w),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
          // 10.w.vb,
          SizedBox(
            width: Get.width - 50,
            // height: 30,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${'钱包地址'.tr}:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Config.kTheme!.text2,
                      )),
                  Expanded(
                      child: Text(
                          ApplicationController.to.assets.value?.address ?? '',
                          maxLines: 3,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Config.kTheme!.text2,
                          ))),
                  CopyBtn(
                      text:
                          ApplicationController.to.assets.value?.address ?? "",
                      color: Color(0xff28a1ff),
                      size: 12.w),
                ],
              ),
            ),
          ),
          20.w.vb,
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  final String iconPath;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 187, 187, 187), width: 0.8),
                  borderRadius: BorderRadius.circular(12)),
              child: CustomImage(
                iconPath,
                color: Color(0xff042b32),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          color: Color(0xff6d6d6d),
          size: 20,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          image: const DecorationImage(
            image: AssetImage(Assets.mineBg),
          )
          // color: Colors.deepOrangeAccent,
          ),
      padding:
          const EdgeInsets.only(left: 14, bottom: 10, top: 15, right: 14).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {},
                child: SizedBox(
                  width: 47.w,
                  height: 47.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      child: Obx(() =>
                          (UserService.to.user.value.headerImg?.isEmpty ?? true)
                              ? Container(
                                  width: 56.w,
                                  height: 56.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffEDEDED),
                                  ),
                                )
                              : CustomImage(
                                  UserService.to.user.value.headerImg!,
                                  width: 56.w,
                                  height: 56.w,
                                )),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Obx(() => SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (UserService.to.user.value.email?.isNotEmpty ?? false)
                              ? UserService.to.user.value.email!
                              : UserService.to.user.value.phone ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color(0xffF4F4F4),
                          ),
                        ),
                        5.w.vb,
                        Text(
                          "${UserService.to.user.value.nickName}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ACCOUNT_DETAIL);
                },
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(6)).r,
            ),
            child: Row(
              children: [
                7.w.hb,
                SizedBox(
                  width: 240.w,
                  child: Text(
                    '${'邀请码'.tr}: ${UserService.to.user.value.inviteCode ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      copyToClipboard(
                          UserService.to.user.value.inviteCode ?? '');
                    },
                    icon: const CustomImage(Assets.newimagesHomeCopy)),
                15.w.hb,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppVersion extends StatelessWidget {
  const _AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff6d6d6d), width: 0.8),
                  borderRadius: BorderRadius.circular(12)),
              child: const CustomImage(
                Assets.userIcon5,
                color: Color(0xff042b32),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              '当前版本'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
          ],
        ),
        trailing: Obx(() {
          return Text(
            AppService.to.packageInfo.value?.version ?? '',
            style: TextStyle(
              color: Config.kTheme!.text2,
              fontSize: 14.sp,
            ),
          );
        }),
      ),
    );
  }
}
