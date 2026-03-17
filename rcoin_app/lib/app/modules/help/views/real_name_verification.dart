import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:otc_app/app.dart';

import '../controllers/help_controller.dart';

class HelpRealNameView extends GetView<HelpController> {
  const HelpRealNameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SizedBox(
                width: Get.width,
                height: 300 + MediaQuery.of(context).padding.top,
                child: const CustomImage(Assets.helpHeader),
              )),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerView(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    CustomImage(
                      Assets.helpAuthBig,
                      width: Get.width,
                      height: Get.width * 12931 / 1080,
                      fit: BoxFit.fill,
                    ),
                    // 20.w.vb,
                    // _card(Assets.helpStep1, Assets.helpAuth1, 356.w,
                    //     _cellHeaderView()),
                    // _card(Assets.helpStep2, Assets.helpAuth2, 356.w,
                    //     _cellHeaderView2()),
                    // _card(Assets.helpStep3, Assets.helpAuth3, 356.w,
                    //     _cellHeaderView3()),
                    // _card(Assets.helpStep4, Assets.helpAuth4, 390.w,
                    //     _cellHeaderView4()),
                    // _card(Assets.helpStep5, Assets.helpAuth5, 404.w,
                    //     _cellHeaderView5()),
                    // _card(Assets.helpStep6, Assets.helpAuth6, 394.w,
                    //     _cellHeaderView6()),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _cellHeaderView6() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "上传视频".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '\n${'上传录制好的视频，完成验证'.tr}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ))
    ]));
  }

  Widget _cellHeaderView5() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "视频认证".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '\n${'录制视频，朗读屏幕上的数字'.tr}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '\n${'时长不超过5秒'.tr}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ]));
  }

  Widget _cellHeaderView4() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "输入真实姓名和身份证号".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '\n${'确认完成'.tr}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ]));
  }

  Widget _cellHeaderView2() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "点击".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'上传身份证正面'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
    ]));
  }

  Widget _cellHeaderView3() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "点击".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'上传身份证反面'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
    ]));
  }

  Widget _cellHeaderView() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "点击".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'我的'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
      TextSpan(
          text: "选择".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'实名认证'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          ))
    ]));
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 0.w),
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.bgw,
                ),
              ),
            ),
            Text(
              '实名认证'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.bgw),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String ccontent, double ht, Widget header) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, left: 16, right: 16),
      width: Get.width - 32,
      height: ht,
      child: Stack(
        children: [
          Positioned(
              top: 20.w,
              left: 0,
              right: 0,
              child: Container(
                width: Get.width - 32,
                padding: EdgeInsets.only(bottom: 20.w),
                decoration: BoxDecoration(
                    color: Config.kTheme!.bg1,
                    borderRadius: BorderRadius.circular(10).w,
                    gradient: const LinearGradient(
                        colors: [Color(0xff131313), Color(0xff232221)]),
                    border: Border.all(
                        color: Color(0xff6d6d6d).withOpacity(0.6), width: 0.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.w, left: 15.w),
                      child: header,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w),
                      child: SizedBox(
                        width: Get.width - 70,
                        height: 223.w,
                        child: CustomImage(ccontent),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: 92.w,
                height: 44.w,
                child: CustomImage(title),
              ))
        ],
      ),
    );
  }
}
