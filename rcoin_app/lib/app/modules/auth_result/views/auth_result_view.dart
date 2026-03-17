import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/common/widgets/app_bar.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/auth_result_controller.dart';

class AuthResultView extends GetView<AuthResultController> {
  const AuthResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: '认证'.tr,
        shadow: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.imagesAuthSuccess,
                      width: 292.w,
                    ),
                    Text(
                      '提交成功!'.tr,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: context.appColors.text1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.w.vb,
                    AppButton(
                      width: 100.w,
                      height: 30.w,
                      onPressed: () {
                        ChatService.to.goChat(-1);
                      },
                      title: '联系客服'.tr,
                      titleStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
