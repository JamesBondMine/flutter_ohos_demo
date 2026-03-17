import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app/routes/app_pages.dart';

class CircleLeading extends StatelessWidget {
  const CircleLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final navigator = Navigator.of(context);
        if (navigator.canPop()) {
          navigator.pop();
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      },
      child: UnconstrainedBox(
        child: Container(
          width: 42.w, // 设置宽度
          height: 42.w,
          decoration: const BoxDecoration(
            color: Color(0xffF6F6F6), // 设置灰色背景
            shape: BoxShape.circle, // 设置圆形
          ),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff121212),
            size: 30,
          ),
        ),
      ),
    );
  }
}
