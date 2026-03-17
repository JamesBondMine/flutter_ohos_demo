import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';

import '../../../widgets/input_decoration.dart';
import '../controllers/set_pay_password_controller.dart';

class forgetPayPasswordView extends GetView<SetPayPasswordController> {
  const forgetPayPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      resizeToAvoidBottomInset: false,
      appBar: _headerView(context),
      body: SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 22.w, right: 19.w),
          child: Column(
            children: [
              SizedBox(height: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _card([
                    _cell2(() {}, "设置新密码".tr),
                    _cell3(() {}, "确认新密码".tr),
                    _cell(() {}, "手机号码".tr,
                        des: UserService.to.user.value.phone ?? "",
                        showArrow: false),
                    _cell4(() {}, "验证码".tr),
                  ]),
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              AppButton(
                width: Get.width - 32,
                height: 52.w,
                // backgroundColor: Config.kTheme!.text2,
                onPressed: () {
                  controller.save();
                },
                radius: 8.w,
                title: '找回支付密码'.tr,
                // titleStyle: TextStyle(
                //   color: controller.passwordConfirmCtrl.text.isEmpty
                //       ? Config.kTheme!.text1.withOpacity(0.5)
                //       : Config.kTheme!.text1,
                //   fontSize: 17.sp,
                //   // fontWeight: FontWeight.bold,
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cell(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            // CustomImage(Assets.alertSoundNotifyComplete),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff9b9b9b),
              ),
            ),
            Spacer(),
            Text(
              des,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff9b9b9b),
              ),
            ),
            showArrow
                ? Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff6d6d6d),
                    size: 20,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _card(List<Widget> childrren) {
    return Container(
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      child: Column(children: childrren),
    );
  }

  Widget _cell2(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: Obx(() => Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff9b9b9b),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 44,
                child: TextField(
                  controller: controller.passwordNewCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  obscureText: controller.showPassword2.value,
                  style: TextStyle(color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入'.tr,
                      hintStyle:
                          TextStyle(fontSize: 13.sp, color: Color(0xff6d6d6d)),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )),
              GestureDetector(
                onTap: () {
                  // _nickController.text = "";
                  controller.showPassword2.value =
                      !controller.showPassword2.value;
                },
                child: Container(
                  width: 20,
                  height: 56,
                  margin: EdgeInsets.only(right: 13.w),
                  alignment: Alignment.center,
                  child: CustomImage(
                    controller.showPassword2.value
                        ? Assets.homeEye2
                        : Assets.homeEye1,
                    color: Color(0xff6d6d6d),
                    width: 18,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _cell3(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: Obx(() => Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff9b9b9b),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 44,
                child: TextField(
                  controller: controller.passwordConfirmCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  obscureText: controller.showPassword3.value,
                  style: TextStyle(color: Config.kTheme!.text1),
                  onChanged: (value) {},
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入'.tr,
                      hintStyle:
                          TextStyle(fontSize: 13.sp, color: Color(0xff6d6d6d)),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )),
              GestureDetector(
                onTap: () {
                  // _nickController.text = "";
                  controller.showPassword3.value =
                      !controller.showPassword3.value;
                },
                child: Container(
                  width: 20,
                  height: 56,
                  margin: EdgeInsets.only(right: 13.w),
                  alignment: Alignment.center,
                  child: CustomImage(
                    controller.showPassword3.value
                        ? Assets.homeEye2
                        : Assets.homeEye1,
                    color: Color(0xff6d6d6d),
                    width: 18,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _cell4(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: Obx(() => Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff9b9b9b),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 44,
                child: TextField(
                  controller: controller.codeCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  obscureText: controller.showPassword3.value,
                  style: TextStyle(color: Config.kTheme!.text1),
                  onChanged: (value) {},
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入验证码'.tr,
                      hintStyle:
                          TextStyle(fontSize: 13.sp, color: Color(0xff6d6d6d)),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )),
              Container(
                width: 1,
                height: 14,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Config.kTheme!.bgbtn,
              ),
              CountdownButton(
                padding: EdgeInsets.zero,
                title: '获取验证码'.tr,
                titleStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Config.kTheme!.text2,
                ),
                onPressed: controller.sendCode,
              )
            ],
          )),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            SizedBox(
              width: Get.width - 160,
              child: Text(
                '找回支付密码'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
