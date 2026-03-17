import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:otc_app/app.dart';

import '../controllers/help_controller.dart';

class HelpRechageView extends GetView<HelpController> {
  const HelpRechageView({Key? key}) : super(key: key);
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
                child: CustomImage(Assets.helpHeader),
              )),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerView(context),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.w.vb,
                    _card(Assets.helpStep1, Assets.helpRec1, 376.w,
                        _cellHeaderView()),
                    _card(
                        Assets.helpStep2,
                        Assets.helpRec2,
                        Get.locale!.languageCode == 'en' ? 400.w : 416.w,
                        _cellHeaderView2()),
                    _card(
                        Assets.helpStep3,
                        Assets.helpRec3,
                        Get.locale!.languageCode == 'en' ? 390.w : 376.w,
                        _cellHeaderView3()),
                    _card(Assets.helpStep4, Assets.helpRec4, 416.w,
                        _cellHeaderView4())
                  ],
                ),
              ))
            ],
          ))
        ],
      ),
    );
  }

  Widget _cellHeaderView4() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "在详情中，可在充值明细页面进行查看".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ]));
  }

  Widget _cellHeaderView2() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "选择存款充值通道,输入充值金额,点击".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'提交'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
      TextSpan(
          text: "进行下一步".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ]));
  }

  Widget _cellHeaderView3() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "确认充值信息，确认后可进入".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'详情'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
    ]));
  }

  Widget _cellHeaderView() {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "您可经由APP首页的".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
      TextSpan(
          text: '"${'充值'.tr}"',
          style: TextStyle(
            fontSize: 16.sp,
            color: Config.kTheme!.text1,
          )),
      TextSpan(
          text: "功能进行充值".tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          )),
    ]));
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - 16),
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Text(
              '充值'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffffffff),
              ),
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
                      padding: EdgeInsets.only(top: 18.w, left: 15.w),
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
