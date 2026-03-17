import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/widgets/app_bar.dart';
import 'package:otc_app/common/widgets/circle_leading.dart';

import '../controllers/accout_binding_controller.dart';

class AccoutBindingView extends GetView<AccoutBindingController> {
  const AccoutBindingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: '账号绑定'.tr,
        leading: const CircleLeading(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '手机号绑定'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff171717),
                fontWeight: FontWeight.bold,
              ),
            ),
            5.w.vb,
            Stack(
              children: [
                TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: context.appColors.text1,
                  ),
                  readOnly: true,
                  decoration: outlineInputDecoration.copyWith(
                      hintText: controller.haveBindPhone ? null : '未绑定'.tr),
                  onTap: () {
                    Get.toNamed(Routes.BIND_PHONE_EMAIL, arguments: {
                      "type": 1,
                    });
                  },
                ),
                if (controller.haveBindPhone)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: CustomImage(
                        Assets.otherLangChecked,
                        width: 28.w,
                        height: 28.w,
                        fit: BoxFit.scaleDown,
                      )),
              ],
            ),
            22.w.vb,
            // Text(
            //   '邮箱绑定'.tr,
            //   style: TextStyle(
            //     fontSize: 16.sp,
            //     color: const Color(0xff171717),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // 5.w.vb,
            // Stack(
            //   children: [
            //     TextField(
            //       controller: controller.emailController,
            //       keyboardType: TextInputType.emailAddress,
            //       readOnly: true,
            //       style: TextStyle(
            //         fontSize: 16.sp,
            //         color: context.appColors.text1,
            //       ),
            //       decoration: outlineInputDecoration.copyWith(
            //           hintText: controller.haveBindEmail ? null : '未绑定'.tr),
            //       onTap: () {
            //         Get.toNamed(Routes.BIND_PHONE_EMAIL, arguments: {
            //           "type": 2,
            //         });
            //       },
            //     ),
            //     if (controller.haveBindEmail)
            //       Positioned(
            //           right: 0,
            //           top: 0,
            //           child: CustomImage(
            //             Assets.otherLangChecked,
            //             width: 28.w,
            //             height: 28.w,
            //             fit: BoxFit.scaleDown,
            //           )),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
