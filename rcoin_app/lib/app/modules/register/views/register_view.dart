import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/login/views/login_view.dart';
import 'package:otc_app/app/modules/signin/views/signin_view.dart';
import 'package:otc_app/common/widgets/countdown_button.dart';
import '../controllers/register_controller.dart';

import 'package:otc_app/app/widgets/button.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(child: Container(child: _scrollBody(context))),
            _bigLogo(),
          ],
        ));
  }

  Widget _bigLogo() {
    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          width: 162.w,
          height: 162.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.registerFirsthr),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget _scrollBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _headerView(context),
          SizedBox(height: 20.w),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xfffffffff),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text("Register an account".tr,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Config.kTheme!.text1,
                      )),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.w),
                  child: Text("Please set up your payment password".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Config.kTheme!.text1.withOpacity(0.7),
                      )),
                ),
                // Column(
                //   children: [
                //     SizedBox(
                //       width: double.maxFinite,
                //       child: TabBar(
                //         tabs: [
                //           Text(''.tr),
                //           Text(''.tr),
                //         ],
                //         onTap: (int index) {
                //           controller.usePhone.value = index == 0;
                //         },
                //         isScrollable: true,
                //         labelStyle: TextStyle(
                //             fontSize: 16.sp, fontWeight: FontWeight.bold),
                //         labelColor: const Color(0xffC478FF),
                //         unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                //         unselectedLabelColor: const Color(0xff999999),
                //         controller: controller.tabController,
                //         labelPadding: EdgeInsets.all(16.w),
                //         indicatorColor: const Color(0xffFAFAFA),
                //         indicatorSize: TabBarIndicatorSize.tab,
                //         indicatorWeight: 3,
                //       ),
                //     ),
                //   ],
                // ),
                _inputWrap(LoginTextField(
                  controller: controller.fullName,
                  prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                      child: ImageIcon(
                        AssetImage(Assets.loginLoginTextfieldPerson),
                        color: Config.kTheme!.text1,
                        size: 18,
                      )),
                  labelText: '输入用户昵称'.tr,
                  obscure: false,
                )),
                SizedBox(height: 20.w),
                Obx(() => controller.showPassword1.value
                    ? _inputWrap(LoginTextField(
                        controller: controller.passwordCtrl,
                        prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 20, end: 20),
                            child: ImageIcon(
                              AssetImage(Assets.loginLoginTextfieldLock),
                              color: Config.kTheme!.text1,
                              size: 18,
                            )),
                        labelText: '请输入密码'.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.w, end: 10.w),
                          child: IconButton(
                            icon: ImageIcon(
                                AssetImage(Assets.loginLoginTextfieldEye),
                                color: Config.kTheme!.text1,
                                size: 18),
                            onPressed: () {
                              controller.showPassword1.toggle();
                            },
                          ),
                        ),
                        obscure: true,
                      ))
                    : _inputWrap(LoginTextField(
                        controller: controller.passwordCtrl,
                        prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 20, end: 20),
                            child: ImageIcon(
                              AssetImage(Assets.loginLoginTextfieldLock),
                              color: Config.kTheme!.text1,
                              size: 18,
                            )),
                        labelText: '请输入密码'.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.w, end: 10.w),
                          child: IconButton(
                            icon: ImageIcon(
                                AssetImage(Assets.loginLoginTextfieldEyeOff),
                                color: Config.kTheme!.text1,
                                size: 18),
                            onPressed: () {
                              controller.showPassword1.toggle();
                            },
                          ),
                        ),
                        obscure: false,
                      ))),
                SizedBox(height: 20.w),
                Obx(
                  () => controller.showPassword.value
                      ? _inputWrap(LoginTextField(
                          controller: controller.passwordConfirmCtrl,
                          prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 20, end: 20),
                              child: ImageIcon(
                                AssetImage(Assets.loginLoginTextfieldLock),
                                color: Config.kTheme!.text1,
                                size: 18,
                              )),
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 20.w, end: 10.w),
                            child: IconButton(
                              icon: ImageIcon(
                                  AssetImage(Assets.loginLoginTextfieldEye),
                                  color: Config.kTheme!.text1,
                                  size: 18),
                              onPressed: () {
                                controller.showPassword.toggle();
                              },
                            ),
                          ),
                          labelText: '二次确认密码'.tr,
                          obscure: true,
                        ))
                      : _inputWrap(LoginTextField(
                          controller: controller.passwordConfirmCtrl,
                          prefixIcon:
                              _inputIcon(), // Assets.loginLoginTextfieldLock,
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 20.w, end: 10.w),
                            child: IconButton(
                              icon: ImageIcon(
                                  AssetImage(Assets.loginLoginTextfieldEyeOff),
                                  color: Config.kTheme!.text1,
                                  size: 18),
                              onPressed: () {
                                controller.showPassword.toggle();
                              },
                            ),
                          ),
                          labelText: '二次确认密码'.tr,
                          obscure: false,
                        )),
                ),
                SizedBox(height: 20.w),
                _phoneView(),
                SizedBox(height: 20.w),
                _verifyCode(),
                SizedBox(height: 26.w),
                _nextStepView(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _nextStepView(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: AppButton(
          width: MediaQuery.of(context).size.width - 40.w,
          height: 52.w,
          title: '下一步'.tr,
          // titleStyle: TextStyle(color: Color(0xff5d4c30)),
          // backgroundColor: const Color(0xfff4e0bd),
          onPressed: () {
            controller.next();
          },
          radius: 8.w,
        ));
  }

  Widget _inputIcon() {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
        child: ImageIcon(
          AssetImage(Assets.loginRegisterCapthcaIcon),
          color: Config.kTheme!.text1,
          size: 18,
        ));
  }

  Widget _verBtn() {
    return Container(
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 0.8,
            height: 20,
            color: Color(0xff666666),
          ),
          CountdownButton(
            padding: const EdgeInsets.only(right: 20),
            title: '获取验证码'.tr,
            titleStyle: TextStyle(fontSize: 14, color: Config.kTheme!.text1),
            onPressed: controller.sendCode,
          )
        ],
      ),
    );
  }

  Widget _verifyCode() {
    return _inputWrap(LoginTextField(
      controller: controller.codeCtrl,
      prefixIcon: _inputIcon(),
      suffixIcon: _verBtn(),
      labelText: '验证码'.tr,
      obscure: false,
    ));
  }

  Widget _phoneView() {
    return Obx(
      () => controller.usePhone.value
          ? _inputWrap(LoginTextField(
              controller: controller.accountCtrl,
              prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
                  child: TextButton(
                    onPressed: () async {
                      // final code = await countryPicker
                      //     .showPicker(context: context);
                      // if(code !=null){
                      //   controller.areaCode.value = code.dialCode;
                      // }
                    },
                    child: Obx(
                      () => Text(
                        controller.areaCode.value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Config.kTheme!.text1,
                        ),
                      ),
                    ),
                  )),
              labelText: '输入您的手机号'.tr,
              obscure: false,
            ))
          : _inputWrap(LoginTextField(
              controller: controller.accountCtrl,
              prefixIcon: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: ImageIcon(
                    AssetImage(Assets.loginLoginTextfieldPerson),
                    size: 18,
                  )),
              labelText: '输入您的邮箱'.tr,
              obscure: false,
            )),
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

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(left: 24.w),
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xff6d6d6d).withOpacity(0.5),
                        width: 0.8),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(0xff333333),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
