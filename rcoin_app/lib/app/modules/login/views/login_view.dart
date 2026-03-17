import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/login/controllers/login_controller.dart';
import 'package:otc_app/app/modules/signin/views/signin_view.dart';
import 'package:otc_app/app/widgets/button.dart';

import '../../../../common/widgets/countdown_button.dart';
import '../../../widgets/country_picker.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _headerView(context),
            Container(
              padding: const EdgeInsets.only(top: 16),
              width: Get.width,
              color: Colors.white,
              child: Text(
                "欢迎回来".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32.w,
                    height: 1.2,
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w500),
              ),
            ),
            // SizedBox(height: 13.w),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.w),
                  Text(
                    "Log in to your account".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.w,
                        color: Config.kTheme!.text1.withOpacity(0.5),
                        height: 1),
                  ),
                  SizedBox(height: 33.w),
                  Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: TabBar(
                          tabs: [Text(' '.tr), Text(' '.tr)],
                          onTap: (int index) {
                            // controller.usePhone.value = index == 0;
                          },
                          isScrollable: false,
                          // labelStyle: TextStyle(
                          //     fontSize: 16.sp, fontWeight: FontWeight.bold),
                          // labelColor: const Color(0xffC478FF),
                          unselectedLabelStyle: TextStyle(fontSize: 9.sp),
                          unselectedLabelColor: const Color(0xff999999),
                          controller: controller.tabController,
                          // labelPadding: EdgeInsets.all(16.w),
                          indicatorColor: const Color(0xffFAFAFA),
                          indicatorSize: TabBarIndicatorSize.tab,
                          // indicatorWeight: 3,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => controller.usePhone.value
                        ? _inputWrap(LoginTextField(
                            controller: controller.accountCtrl,
                            prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 0, end: 0),
                                child: GestureDetector(
                                  child: Obx(
                                    () => Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      width: 60,
                                      child: Row(
                                        children: [
                                          Text(
                                            controller.areaCode.value,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Config.kTheme!.text1,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Config.kTheme!.text1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            labelText: '输入您的手机号'.tr,
                            obscure: false,
                          ))
                        : _inputWrap(LoginTextField(
                            controller: controller.accountCtrl,
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: 20.w, end: 20.w),
                                child: const ImageIcon(
                                  AssetImage(Assets.loginLoginTextfieldPerson),
                                  size: 18,
                                )),
                            labelText: '输入您的邮箱'.tr,
                            obscure: false,
                          )),
                  ),
                  SizedBox(height: 16.w),
                  Obx(() => controller.usePassword.value
                      ? _inputWrap(LoginTextField(
                          controller: controller.passwordCtrl,
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 20.w),
                              child: ImageIcon(
                                AssetImage(Assets.loginLoginTextfieldLock),
                                color: Config.kTheme!.text1,
                                size: 18,
                              )),
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 20.w, end: 10.w),
                            child: IconButton(
                              icon: CustomImage(
                                controller.showPassword.value
                                    ? Assets.homeEye2
                                    : Assets.homeEye1,
                                color: Config.kTheme!.text1,
                                width: 18,
                              ),
                              onPressed: () {
                                controller.showPassword.toggle();
                              },
                            ),
                          ),
                          labelText: '密码'.tr,
                          obscure: controller.showPassword.value ? true : false,
                        ))
                      : _inputWrap(LoginTextField(
                          controller: controller.passwordCtrl,
                          prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 20,
                                end: 20,
                              ),
                              child: ImageIcon(
                                const AssetImage(
                                    Assets.loginRegisterCapthcaIcon),
                                size: 18,
                                color: Config.kTheme!.text1,
                              )),
                          suffixIcon: SizedBox(
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 0.8,
                                  height: 20.w,
                                  margin: EdgeInsets.only(right: 10),
                                  color: Color(0xff6d6d6d),
                                ),
                                CountdownButton(
                                  padding: const EdgeInsets.only(right: 10),
                                  title: '接收验证码'.tr,
                                  titleStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Config.kTheme!.text1),
                                  onPressed: controller.sendCode,
                                )
                              ],
                            ),
                          ),
                          labelText: '验证码'.tr,
                          obscure: false,
                        ))),
                  Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Obx(() => controller.usePassword.value
                              ? TextButton(
                                  onPressed: () {
                                    controller.usePassword.toggle();
                                  },
                                  child: Text(
                                    '接收验证码'.tr,
                                    style: TextStyle(
                                        color: Config.kTheme!.text1,
                                        fontSize: 14.sp),
                                  ))
                              : TextButton(
                                  onPressed: () {
                                    controller.usePassword.toggle();
                                  },
                                  child: Text(
                                    '密码登录'.tr,
                                    style: TextStyle(
                                        color: Config.kTheme!.text1,
                                        fontSize: 14.sp),
                                  ))),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.FORGETPASSWORDVERIFY);
                              },
                              child: Text(
                                '忘记密码'.tr,
                                style: TextStyle(
                                    color: Config.kTheme!.text1,
                                    fontSize: 14.sp),
                              ))
                        ],
                      )),
                  SizedBox(height: 48.w),
                  Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: AppButton(
                        width: MediaQuery.of(context).size.width - 40.w,
                        height: 60.w,
                        title: '登录'.tr,
                        // titleStyle: TextStyle(color: Color(0xff5d4c30)),
                        // backgroundColor: Config.kTheme!.bgbtn,
                        onPressed: () {
                          controller.login();
                        },
                        radius: 8.w,
                      )),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '没有帐号？'.tr,
                          style: TextStyle(
                              color: Config.kTheme!.text1.withOpacity(0.5),
                              fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: Text(
                              '前去注册'.tr,
                              style: TextStyle(
                                  color: Config.kTheme!.text1, fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 48.w),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputWrap(Widget child) {
    return Container(
        height: 52.w,
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Config.kTheme!.text2.withOpacity(0.1)),
        padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 8.w, bottom: 8),
        child: child);
  }

  Widget _headerView(BuildContext context) {
    return Container(
      width: Get.width,
      height: 320.w,
      padding: const EdgeInsets.only(
        left: 0,
        bottom: 60,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.bgFirstBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GuidPage(click: () => Get.toNamed(Routes.LANGUAGE_SWITCH)),
          const Spacer(),
          CustomImage(
            Assets.iconIcon1,
            width: 220.w,
            // height: 80.w,
          ),
        ],
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.labelText,
    required this.obscure,
    this.onTap,
    required this.controller,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final bool obscure;
  final GestureTapCallback? onTap;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          hintText: labelText,
          // hintStyle: TextStyle(
          //   fontSize: 16.sp,
          // ),
          // labelText: labelText,
          // floatingLabelStyle: TextStyle(
          //   color: context.appColors.primary,
          //   fontSize: 16.sp,
          // ),
          // labelStyle: TextStyle(
          //   fontSize: 16.sp,
          // ),
          focusedBorder: InputBorder.none,
          prefixIcon: prefixIcon ?? prefixIcon,
          suffixIcon: suffixIcon ?? suffixIcon,
          enabledBorder: InputBorder.none,
          border: OutlineInputBorder()),
    );
  }
}
