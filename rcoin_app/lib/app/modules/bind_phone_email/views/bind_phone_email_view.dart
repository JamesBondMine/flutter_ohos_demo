import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';
import '../../../widgets/country_picker.dart';

import '../../forgetpassword/views/forgetpassword_verify_view.dart';
import '../controllers/bind_phone_email_controller.dart';

class BindPhoneEmailView extends GetView<BindPhoneEmailController> {
  const BindPhoneEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //type: 1手机 2邮箱
    final type = mapGet(Get.arguments, 'type') ?? 1;
    return Scaffold(
      appBar: AAppBar(
        title: type == 1 ? '手机号绑定'.tr : '邮箱绑定'.tr,
        leading: const CircleLeading(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
          child: FillRemainWidget(
            topChildren: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type == 1 ? '手机号绑定'.tr : '邮箱绑定'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff171717),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.w.vb,
                  if (type == 1)
                    BindTextField(
                      controller: controller.textEditingController,
                      prefixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 0, end: 0),
                          child: TextButton(
                            onPressed: () async {
                              // final code = await countryPicker.showPicker(context: context);
                              // if (code != null) {
                              //   controller.areaCode.value =
                              //       code.dialCode;
                              // }
                            },
                            child: Obx(
                              () => Text(
                                controller.areaCode.value,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff1C1C1C),
                                ),
                              ),
                            ),
                          )),
                      labelText: '输入您的手机号'.tr,
                      obscure: false,
                    )
                  else
                    TextField(
                      controller: controller.textEditingController,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: context.appColors.text1,
                      ),
                      decoration: outlineInputDecoration.copyWith(
                        hintText: '输入您的邮箱'.tr,
                      ),
                    ),
                  // BindTextField(
                  //   controller: controller.textEditingController,
                  //   prefixIcon: Padding(
                  //       padding: EdgeInsetsDirectional.only(
                  //           start: 20.w, end: 20.w),
                  //       child: const ImageIcon(
                  //         AssetImage(
                  //             Assets.loginLoginTextfieldPerson),
                  //         size: 18,
                  //       )),
                  //   labelText: '输入您的邮箱',
                  //   obscure: false,
                  // ),
                  // Container(
                  //     padding:
                  //     EdgeInsets.only(left: 20.w, right: 20.w),
                  //     child: ),
                  // TextField(
                  //   controller: controller.textEditingController,
                  //
                  //   style: TextStyle(
                  //     fontSize: 16.sp,
                  //     color: context.appColors.text1,
                  //   ),
                  //   decoration: outlineInputDecoration.copyWith(
                  //       hintText:
                  //           type == 1 ? '输入您的手机号'.tr : '输入您的邮箱'.tr),
                  // ),
                  Row(
                    children: [
                      Text(
                        '验证码'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xff171717),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CountdownButton(
                        duration: 60,
                        title: '获取验证码'.tr,
                        titleStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xffC478FF),
                          fontWeight: FontWeight.bold,
                        ),
                        runningTitleBuilder: (int time) {
                          return '${'重新获取'.tr} ($time)';
                        },
                        runningTitleStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xffC478FF),
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () async {
                          return await controller.sendCaptcha(type);
                        },
                      )
                    ],
                  ),
                  5.w.vb,
                  TextField(
                    controller: controller.codeController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.appColors.text1,
                    ),
                    decoration:
                        outlineInputDecoration.copyWith(hintText: '请输入验证码'.tr),
                  ),
                ],
              )
            ],
            bottomChild: Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => AppButton(
                    width: 334.w,
                    height: 41.w,
                    backgroundColor: controller.btnEnable.value
                        ? context.appColors.primary
                        : const Color(0xffC478FF).withOpacity(.3),
                    radius: 40,
                    title: '确定'.tr,
                    titleStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (!controller.btnEnable.value) {
                        return;
                      }
                      controller.postBind();
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class BindTextField extends StatelessWidget {
  const BindTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.labelText,
    required this.obscure,
    required this.controller,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final bool obscure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: outlineInputDecoration.copyWith(
        border: InputBorder.none,
        filled: true,
        hintText: labelText,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        prefixIcon: prefixIcon ?? prefixIcon,
        suffixIcon: suffixIcon ?? suffixIcon,
      ),
    );
  }
}
