import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/country_picker.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';

import '../../../widgets/text_field.dart';
import '../../../widgets/input_decoration.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AAppBar(
        shadow: true,
        titleWidget: Text(
          '重置密码'.tr,
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1c1c1c),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 22.w, right: 19.w),
          child: Column(
            children: [
              SizedBox(height: 16.w),
              Select(
                items: [
                  SelectItem(
                    title: '手机'.tr,
                    icon: Assets.signinPhone,
                    activeIcon: Assets.signinPhoneSelect,
                  ),
                  SelectItem(
                    title: '邮箱'.tr,
                    icon: Assets.signinEmail,
                    activeIcon: Assets.signinEmailSelect,
                  ),
                ],
                onTap: (int index) {
                  controller.usePhone.value = index == 0;
                },
              ),
              SizedBox(height: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Visibility(
                        visible: !controller.usePhone.value,
                        child: InputField(
                          title: '邮箱'.tr,
                          textField: TextField(
                            controller: controller.emailCtrl,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: context.appColors.text1,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                inputDecoration.copyWith(hintText: '请输入邮箱'.tr),
                          ),
                        ),
                      )),
                  Obx(
                    () => Visibility(
                      visible: controller.usePhone.value,
                      child: InputField(
                        title: '手机号码'.tr,
                        textField: TextField(
                          controller: controller.phoneCtrl,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: context.appColors.text1,
                          ),
                          decoration: inputDecoration.copyWith(
                            hintText: '请输入手机号'.tr,
                            prefixIcon: GestureDetector(
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InputField(
                    title: '验证码'.tr,
                    textField: TextField(
                      controller: controller.codeCtrl,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      decoration: inputDecoration.copyWith(
                          hintText: '请输入验证码'.tr,
                          suffixIcon: CountdownButton(
                            padding: EdgeInsets.zero,
                            title: '获取验证码'.tr,
                            titleStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.primary,
                            ),
                            onPressed: controller.sendCode,
                          )),
                    ),
                  ),
                  ObxValue(
                      (data) => InputField(
                            title: '密码'.tr,
                            textField: TextField(
                              controller: controller.passwordCtrl,
                              obscureText: data.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.text1,
                              ),
                              decoration: inputDecoration.copyWith(
                                  hintText: '请输入密码'.tr,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      data.toggle();
                                    },
                                    child: CustomImage(
                                      data.value
                                          ? Assets.signinHide
                                          : Assets.signinShow,
                                      width: 16.w,
                                      height: 16.w,
                                    ),
                                  )),
                            ),
                          ),
                      true.obs),
                  InputField(
                    title: '确认密码'.tr,
                    textField: TextField(
                      keyboardType: TextInputType.visiblePassword,
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
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 343.w,
                height: 40.w,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.submit();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      )),
                  child: Text(
                    '确认重置'.tr,
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.w),
            ],
          ),
        ),
      ),
    );
  }
}
