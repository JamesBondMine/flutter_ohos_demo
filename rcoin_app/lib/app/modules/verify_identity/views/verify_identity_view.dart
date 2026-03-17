import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';

import '../controllers/verify_identity_controller.dart';

class VerifyIdentityView extends GetView<VerifyIdentityController> {
  const VerifyIdentityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        TextStyle(fontSize: 14.sp, color: context.appColors.textPlaceholder);
    return Scaffold(
        appBar: AAppBar(
          title: '验证身份'.tr,
          shadow: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 21.w),
                  Text(
                    '身份认证'.tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.text1,
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    '请选择您要成为的身份'.tr,
                    style: defaultStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12.w,
                  )
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.mineVerifyEmail,
                    width: 24.w,
                  ),
                  SizedBox(width: 9.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '承兑'.tr,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: context.appColors.text1,
                        ),
                      ),
                      Text(
                        '自动接单'.tr,
                        style: defaultStyle,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  AppButton(
                    width: 83.w,
                    height: 34.w,
                    onPressed: () {
                      Get.toNamed(Routes.AUTH_ROLE, arguments: {
                        'type': 1,
                      });
                    },
                    title: '去完成'.tr,
                    radius: 24.w,
                    titleStyle: TextStyle(
                      fontSize: 17.sp,
                      color: context.appColors.text1,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12.w,
                  )
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.mineVerifyPerson,
                    width: 24.w,
                  ),
                  SizedBox(width: 9.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '商家'.tr,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: context.appColors.text1,
                        ),
                      ),
                      Text(
                        '发布广告'.tr,
                        style: defaultStyle,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  AppButton(
                    width: 83.w,
                    height: 34.w,
                    onPressed: () {
                      Get.toNamed(Routes.AUTH_ROLE, arguments: {
                        'type': 2,
                      });
                    },
                    title: '去完成'.tr,
                    radius: 24.w,
                    titleStyle: TextStyle(
                      fontSize: 17.sp,
                      color: context.appColors.text1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
