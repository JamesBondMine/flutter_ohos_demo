import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import 'button.dart';

class SelectBottomSheet<T> extends StatelessWidget {
  const SelectBottomSheet({super.key, required this.options, required this.title});

  final List<(String, T)> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final option in options) {
      children.add(GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.back(result: option.$2);
        },
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 11.w, bottom: 9.w),
          child: Text(
            option.$1,
            style: TextStyle(
              fontSize: 19.sp,
              color: context.appColors.text1,
            ),
          ),
        ),
      ));
      children.add(Container(
        padding: EdgeInsets.only(left: 15.w, right: 9.w),
        color: const Color(0xffE3E3E3),
        height: 1.w,
      ));
    }
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 19.sp,
                color: Colors.white,
              )),
          SizedBox(height: 11.w),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffebebeb),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
          SizedBox(height: 7.w),
          SizedBox(
            width: 361.w,
            height: 37.w,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                )
              ),
              child: Text('取消'.tr, style: TextStyle(
                fontSize: 19.sp,
                color: Colors.black,
              ),),
            ),
          ),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }
}