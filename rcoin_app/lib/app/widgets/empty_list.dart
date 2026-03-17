import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.title = "暂无订单信息～"});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            Assets.otherEmptyList,
            width: 120.w,
            height: 120.w,
          ),
          SizedBox(height: 14.w),
          Text(
            title.tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: Config.kTheme!.text2,
            ),
          )
        ],
      ),
    );
  }
}
