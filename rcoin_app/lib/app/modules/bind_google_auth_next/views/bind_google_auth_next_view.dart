import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';
import 'package:pinput/pinput.dart';

import '../controllers/bind_google_auth_next_controller.dart';

class BindGoogleAuthNextView extends GetView<BindGoogleAuthNextController> {
  const BindGoogleAuthNextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AAppBar(title: '开启谷歌验证'.tr),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 19.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 19.w),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("请输入6位验证码".tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 20.w),
              CodeInput(
                onCompleted: (String pin) {
                  controller.captcha = pin;
                },
              ),
              SizedBox(height: 20.w),
              AppButton(
                width: 117.w,
                height: 40.w,
                onPressed: () {
                  controller.bindSecret();
                },
                title: '确定'.tr,
                backgroundColor: const Color(0xff48484a),
                radius: 8.w,
                titleStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primary,
                ),
              )
            ],
          ),
        ));
  }
}

