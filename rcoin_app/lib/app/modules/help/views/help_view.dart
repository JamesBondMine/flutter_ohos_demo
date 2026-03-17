import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/help/views/htlp_video.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              _HelpLine(
                title: '实名认证'.tr,
                onTap: () {
                  Get.toNamed(Routes.HELPREALNAME);
                },
                icon: Assets.help1,
              ),
              8.w.vb,
              _HelpLine(
                title: '添加收付款'.tr,
                onTap: () {
                  Get.toNamed(Routes.HELPPAYMENT);
                },
                icon: Assets.help2,
              ),
              8.w.vb,
              _HelpLine(
                title: '卖币'.tr,
                onTap: () {
                  Get.toNamed(Routes.HELPSELLCOIN);
                },
                icon: Assets.help3,
              ),
              8.w.vb,
              _HelpLine(
                title: '买币'.tr,
                onTap: () {
                  Get.toNamed(Routes.HELPBUYCOIN);
                },
                icon: Assets.help4,
              ),
              8.w.vb,
              _HelpLine(
                title: '发布挂单'.tr,
                onTap: () {
                  Get.toNamed(Routes.HELPPUBLISH);
                },
                icon: Assets.help5,
              ),
              8.w.vb,
              _HelpLine(
                  title: '充值'.tr,
                  onTap: () {
                    Get.toNamed(Routes.HELPRECHAGE);
                  },
                  icon: Assets.help6),
              8.w.vb,
              _HelpLine(
                  title: 'video'.tr,
                  onTap: () {
                    Get.to(const HelpVideoPage());
                  },
                  icon: Assets.helpVideo),
              14.w.vb,
            ],
          ),
        ),
      ),
    );
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
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Text(
              '帮助中心'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.text1),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              child: CustomImage(
                Assets.newimagesCommentService,
                color: Config.kTheme!.text1,
                onTap: () {
                  ChatService.to.goChatWithService();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HelpLine extends StatelessWidget {
  const _HelpLine({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.w,
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
            // CustomImage(Assets.alertSoundNotifyComplete),
            Container(
              width: 32.w,
              height: 32.w,
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xff9b9b9b).withOpacity(0.5), width: 0.7),
                  borderRadius: BorderRadius.circular(8.w)),
              child: CustomImage(
                icon,
                color: Config.kTheme!.text1,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
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

class _TabBar extends StatelessWidget {
  const _TabBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20.w, bottom: 18.w, left: 3.w, right: 16.w),
      child: TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        indicator: null,
        unselectedLabelStyle: TextStyle(fontSize: 14.sp),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        labelColor: context.appColors.primary,
        unselectedLabelColor: const Color(0xff999999),
        labelPadding: EdgeInsets.symmetric(horizontal: 14.w),
        controller: controller,
        tabs: [
          Text('real name verification'.tr),
          Text('buy money'.tr),
          Text('cryptocurrency'.tr),
        ],
      ),
    );
  }
}
