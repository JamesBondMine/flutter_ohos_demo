import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/bottom_select.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // spacing: 72.w,
      // runSpacing: 10.w,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Button(
          // color: const Color(0xffedf8db),
          icon: const CustomImage(Assets.homeWorkIcon1),
          title: '收款账户'.tr,
          onTap: () {
            Get.toNamed(Routes.PAYMENT_METHOD);
          },
        ),
        _Button(
          icon: const CustomImage("assets/newimages/home/home_work_icon2.svg"),
          title: 'bill'.tr,
          onTap: () async {
            Get.toNamed(Routes.BILL_LOGS);
          },
        ),
        // _Button(
        //   color: const Color.fromRGBO(255, 182, 109, 0.15),
        //   icon: const CustomImage(Assets.homeHomeBillingIcon),
        //   title: '账单记录'.tr,
        //   onTap: () {
        //     Get.toNamed(Routes.BILL_LOGS);
        //   },
        // ),
        // _Button(
        //   color: const Color(0xffe9f8f5),
        //   icon: const CustomImage(Assets.homeTeams),
        //   title: '我的团队'.tr,
        //   onTap: () {
        //     Get.toNamed(Routes.TEAMS);
        //   },
        // ),

        _Button(
          // color: const Color.fromRGBO(134, 162, 248, 0.15),
          icon: const CustomImage(Assets.homeWorkIcon3),
          title: '代币充值'.tr,
          onTap: () {
            Get.toNamed(Routes.RECHARGE);
          },
        ),
        _Button(
          // color: const Color(0xfffee1e3),
          icon: const CustomImage(Assets.homeWorkIcon4),
          title: '帮助中心'.tr,
          onTap: () {
            Get.toNamed(Routes.HELP);
          },
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    this.color,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final Color? color;
  final Widget icon;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)).r,
              color: color,
            ),
            alignment: Alignment.center,
            child: icon,
          ),
          10.w.vb,
          Text(
            title,
            style: TextStyle(
                fontSize: 12.sp,
                color: Config.kTheme!.text1,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
