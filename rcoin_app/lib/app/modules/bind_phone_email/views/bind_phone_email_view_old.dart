import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/country_picker.dart';

import '../controllers/bind_phone_email_controller.dart';

class BindPhoneEmailView extends GetView<BindPhoneEmailController> {
  const BindPhoneEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = mapGet(Get.arguments, 'type') ?? 1;

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide.none,
    );

    final typeName = type == 1 ? '手机' : '邮箱';
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AAppBar(title: '开启$typeName验证'.tr),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.w),
              CustomImage(
                Assets.mineBindPhone,
                width: 100.w,
                height: 100.w,
              ),
              SizedBox(height: 21.w),
              Text(
                '开启$typeName验证'.tr,
                style: TextStyle(fontSize: 17.sp, color: Colors.black),
              ),
              SizedBox(height: 12.w),
              Text(
                '为您的账户提供更安全的保护。'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.textPlaceholder,
                ),
              ),
              SizedBox(height: 20.w),
              TextField(
                controller: controller.textEditingController,
                autofocus: true,
                keyboardType: type == 1
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '请输入$typeName号'.tr,
                  prefixIcon: type == 1? GestureDetector(
                    onTap: () async {
                      final code = await countryPicker.showPicker(
                          context: context);
                      if (code != null) {
                        controller.areaCode.value = code.dialCode;
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        15.w.hb,
                        Obx(
                              () => Text(
                            controller.areaCode.value,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff1C1C1C),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: context.appColors.primary,
                        )
                      ],
                    ),
                  ): null,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: context.appColors.textPlaceholder,
                  ),
                ),
              ),
              SizedBox(height: 58.w),
              AppButton(
                width: 117.w,
                height: 40.w,
                onPressed: () {
                  controller.sendCaptcha(type);
                },
                title: '下一步'.tr,
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
