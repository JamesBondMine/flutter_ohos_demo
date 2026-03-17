import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import 'package:otc_app/common/widgets/app_bar.dart';

import '../../bind_phone_email_next/views/bind_phone_email_next_view.dart';
import '../controllers/delete_google_auth_controller.dart';

class DeleteGoogleAuthView extends GetView<DeleteGoogleAuthController> {
  const DeleteGoogleAuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        appBar: AAppBar(title: '删除谷歌验证'),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 19.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 19.w),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("请输入6位验证码",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 20.w),
              CodeInput(
                onCompleted: (pin) {
                  controller.captcha = pin;
                },
              ),
              SizedBox(height: 20.w),

              AppButton(
                width: 117.w,
                height: 40.w,
                onPressed: () {
                  controller.deleteSecret();
                },
                title: '确定删除',
                backgroundColor: Color(0xff48484a),
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
