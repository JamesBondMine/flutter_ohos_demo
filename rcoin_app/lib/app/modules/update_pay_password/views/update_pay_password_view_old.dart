import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/app/widgets/text_field.dart';
import '../controllers/update_pay_password_controller.dart';

class UpdatePayPasswordView extends GetView<UpdatePayPasswordController> {
  const UpdatePayPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AAppBar(
        shadow: true,
        titleWidget: Text(
          controller.passwordType == 1 ? '修改登录密码'.tr : '修改资金密码'.tr,
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1c1c1c),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                controller.postUpdate();
              },
              child: Text(
                '保存'.tr,
                style: TextStyle(
                  fontSize: 19.sp,
                  color: context.appColors.text1,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 22.w, right: 19.w),
          child: Column(
            children: [
              SizedBox(height: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    title: '旧密码'.tr,
                    textField: TextField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      obscureText: true,
                      controller: controller.oldPasswordCtrl,
                      decoration: inputDecoration.copyWith(hintText: '请输入旧密码'.tr),
                    ),
                  ),
                  InputField(
                    title: '密码'.tr,
                    textField: TextField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      obscureText: true,
                      controller: controller.passwordCtrl,
                      decoration: inputDecoration.copyWith(
                          hintText: '请输入密码'.tr),
                    ),
                  ),
                  InputField(
                    title: '确认密码'.tr,
                    textField: TextField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      obscureText: true,
                      controller: controller.passwordConfirmCtrl,
                      decoration: inputDecoration.copyWith(
                          hintText: '请输入密码'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
