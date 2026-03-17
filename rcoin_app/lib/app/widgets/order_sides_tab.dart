import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/config.dart';
import 'package:otc_app/support_files/theme.dart';

class OrderSidesTab extends HookWidget {
  const OrderSidesTab({super.key, this.onTap});

  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = useTabController(initialLength: 2);
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4).w,
      //   color: const Color(0xff48484a),
      // ),
      padding: EdgeInsets.all(3.w),
      child: TabBar(
        isScrollable: true,
        onTap: onTap,
        labelPadding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Config.kTheme!.text1,
        unselectedLabelColor: Config.kTheme!.text2,
        labelStyle: TextStyle(
            fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          // color: context.appColors.primary,
        ),
        tabs: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
            child: Text('我的购买'.tr),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
            child: Text('我的出售'.tr),
          ),
        ],
        controller: controller,
      ),
    );
  }
}
