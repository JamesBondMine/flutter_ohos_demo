import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import 'package:otc_app/common/extensions/intl.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';
import '../controllers/bind_phone_email_next_controller.dart';

class BindPhoneEmailNextView extends GetView<BindPhoneEmailNextController> {
  const BindPhoneEmailNextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typeName = controller.type == 1 ? '手机' : '邮箱';
    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        appBar: AAppBar(title: '开启$typeName验证'.tr),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 19.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 19.w),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('请输入发送至手机号 phone的6位验证码'.trans({
                  'phone': UserService.to.user.value.phone,
                }),
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
              Container(
                alignment: Alignment.centerRight,
                child: CountdownButton(
                  color: context.appColors.primary,
                  disabledColor: const Color(0xffd9d9d9),
                  padding: EdgeInsets.all(5.w),
                  borderRadius: BorderRadius.circular(5.w),
                  title: '重新获取'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff48484A),
                  ),
                  runningTitleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff999999),
                  ),
                  onPressed: () async {
                    return true;
                  },
                  runningTitleBuilder: (int s) {
                    return '重新获取(seconds秒)'.trans({
                      'seconds': s,
                    });
                  },
                ),
              ),
              SizedBox(height: 58.w),
              AppButton(
                width: 117.w,
                height: 40.w,
                onPressed: () {
                  controller.postBind();
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
