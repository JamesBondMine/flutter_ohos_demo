import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import '../controllers/update_pay_password_controller.dart';

class UpdatePayPasswordView extends GetView<UpdatePayPasswordController> {
  UpdatePayPasswordView({Key? key}) : super(key: key);

  final RxBool pwdVisible = false.obs;
  final RxBool newPwdVisible = false.obs;
  final RxBool confirmPwdVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: controller.passwordType == 1
            ? '登录密码'.tr
            : '交易密码'.tr,
        leading: const CircleLeading(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        child: FillRemainWidget(
          crossAxisAlignment: CrossAxisAlignment.start,
          topChildren: [
            Text(
              '请输入当前密码'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff171717),
                fontWeight: FontWeight.bold,
              ),
            ),
            5.w.vb,
            Obx(() => TextField(
              controller: controller.oldPasswordCtrl,
              style: TextStyle(
                fontSize: 16.sp,
                color: context.appColors.text1,
              ),
              obscureText: !pwdVisible.value,
              decoration: outlineInputDecoration.copyWith(
                  prefixIcon: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: const CustomImage(Assets.otherLock)),
                  hintText: '密码输入'.tr,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      pwdVisible.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        pwdVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.appColors.primary,
                      ),
                    ),
                  )
              ),
            )),
            22.w.vb,
            Text(
              '请输入新密码'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff171717),
                fontWeight: FontWeight.bold,
              ),
            ),
            5.w.vb,
            Obx(() =>
                TextField(
                  controller: controller.passwordCtrl,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: context.appColors.text1,
                  ),
                  obscureText: !newPwdVisible.value,
                  decoration: outlineInputDecoration.copyWith(
                    prefixIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: const CustomImage(Assets.otherLock)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        newPwdVisible.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Icon(
                          newPwdVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: context.appColors.primary,
                        ),
                      ),
                    ),
                    hintText: '密码输入'.tr,
                  ),
                )),
            22.w.vb,
            Text(
              '再次输入新密码'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xff171717),
                fontWeight: FontWeight.bold,
              ),
            ),
            5.w.vb,
            Obx(() =>
                TextField(
                  controller: controller.passwordConfirmCtrl,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: context.appColors.text1,
                  ),
                  obscureText: !confirmPwdVisible.value,
                  decoration: outlineInputDecoration.copyWith(
                    prefixIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: const CustomImage(Assets.otherLock)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        confirmPwdVisible.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Icon(
                          confirmPwdVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: context.appColors.primary,
                        ),
                      ),
                    ),
                    hintText: '密码输入'.tr,
                  ),
                )),
          ],
          bottomChild: AppButton(
            width: 334.w,
            height: 41.w,
            title: '确定'.tr,
            radius: 40,
            onPressed: () async {
              bool? confirm = await confirmBottomSheet(
                  title: '您想要修改密码吗？'.tr,
                  subTitle: '');
              if (confirm == true) {
                controller.postUpdate();
              }
            },
          ),
        ),
      ),
    );
  }
}
