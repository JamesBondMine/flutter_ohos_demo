import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/login/controllers/login_controller.dart';
import 'package:otc_app/app/modules/signin/views/guid_launch_page.dart';
import 'package:otc_app/upgrade.dart';

class SignInView extends GetView<LoginController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Config.kTheme!.bgMain,
        body: Stack(
      children: [
        Positioned.fill(child: _bodyView(context)),
        Positioned.fill(
            child: GuidLaunchPage(
          disappear: () {},
        ))
      ],
    ));
  }

  Widget _bodyView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Config.kTheme!.bgMain
          // image: DecorationImage(
          //   image: AssetImage(Assets.loginGuidBg),
          //   fit: BoxFit.cover,
          // ),
          ),
      // padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GuidPage(click: () => Get.toNamed(Routes.LANGUAGE_SWITCH)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomImage(
                    Assets.iconIconIos,
                    width: 64.w,
                    height: 64.w,
                  ),
                ),
                // SizedBox(height: 16.w),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 10.w, top: 20.w),
                  child: Text(
                    "welcome".tr,
                    style: TextStyle(
                        fontSize: 20.w,
                        color: Colors.white,
                        height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 10, bottom: 18),
                  child: Text(
                    "${"to".tr} Gopay",
                    style: TextStyle(
                        fontSize: 20.w,
                        color: Colors.white,
                        height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text(
                    "Payment is very simple".tr,
                    style: TextStyle(
                        fontSize: 20.w,
                        color: Colors.white,
                        height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 170.sp),
                Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: MaterialButton(
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                            color: Config.kTheme!.bgbtn,
                            gradient: LinearGradient(
                                colors: [Color(0xFFD8FFF8), Color(0xFFB7F1FC)]),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              '创建账户'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Config.kTheme!.text1, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                    )),
                SizedBox(height: 0.w),
                Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: MaterialButton(
                      height: 52.w,
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '已有账户'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Config.kTheme!.text2, fontSize: 16),
                          ))
                        ],
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 95),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GuidPage extends StatefulWidget {
  const GuidPage({Key? key, required this.click}) : super(key: key);

  final VoidCallback click;

  @override
  State<StatefulWidget> createState() {
    return GuidPageState();
  }
}

class GuidPageState extends State<GuidPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      checkUpgrade();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.click();
      },
      child: Container(
        width: Get.width,
        height: 64.w,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top > 30
                ? MediaQuery.of(context).padding.top - 10
                : MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        child: Container(
          width: 48,
          height: 48,
          // decoration: BoxDecoration(
          //     border: Border.all(color: Color(0xff333333)),
          //     borderRadius: BorderRadius.circular(5)),
          child: CustomImage(Assets.mineLanguage),
        ),
      ),
    );
  }
}

class LoginButtonArrow extends StatelessWidget {
  const LoginButtonArrow({
    super.key,
    required this.iconPath,
    required this.title,
    required this.textColor,
    required this.buttonBgColor,
    required this.onTap,
  });
  final String iconPath;
  final String title;
  final Color? textColor;
  final Color? buttonBgColor;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonBgColor,
            borderRadius: BorderRadius.circular(20).w,
          ),
          padding:
              const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14.w, color: textColor),
              ),
              CustomImage(
                iconPath,
                width: 23.w,
              ),
            ],
          ),
        ));
  }
}
