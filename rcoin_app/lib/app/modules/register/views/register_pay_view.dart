import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import '../../../../common/widgets/countdown_button.dart';
import '../controllers/register_controller.dart';

import 'package:otc_app/app/widgets/button.dart';

class RegisterPayView extends GetView<RegisterController> {
  const RegisterPayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(child: Container(child: _scrollBody(context))),
            _bigLogo(),
            _nextStepView(context)
          ],
        ));
  }

  Widget _nextStepView(BuildContext context) {
    return Positioned(
        left: 0,
        bottom: MediaQuery.of(context).padding.bottom + 30.w,
        right: 0,
        child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: GetBuilder<RegisterController>(
                id: controller.pinConfirmBtnRefreshId,
                builder: (c) {
                  return AppButton(
                    width: MediaQuery.of(context).size.width - 40.w,
                    height: 52.w,
                    title: '确定'.tr,
                    titleStyle: TextStyle(
                        color: controller.pinFinish
                            ? Color(0xff5d4c30)
                            : Color(0xff5d4c30).withOpacity(0.3)),
                    backgroundColor: const Color(0xfff4e0bd),
                    onPressed: () {
                      _surePinEvent(context);
                    },
                    radius: 8.w,
                  );
                })));
  }

  _surePinEvent(BuildContext context) {
    Get.dialog(
        Container(
          padding: EdgeInsets.only(
              bottom: (Get.height - 450) / 2,
              left: 20,
              right: 20,
              top: (Get.height - 450) / 2),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.close,
                            color: Color(0xff9b9d9c),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.loginRegisterPinSuccess),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 20),
                      child: Text("让我们开始吧！".tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff5d4c30),
                          )),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: AppButton(
                      width: MediaQuery.of(context).size.width - 80.w,
                      height: 52.w,
                      title: 'I know'.tr,
                      titleStyle: TextStyle(
                          color: controller.pinFinish
                              ? Color(0xff5d4c30)
                              : Color(0xff5d4c30).withOpacity(0.3)),
                      backgroundColor: const Color(0xfff4e0bd),
                      onPressed: () {
                        Get.back();
                        controller.register();
                      },
                      radius: 8.w,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false);
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
          SizedBox(height: 16.w),
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
                      child: Text("Payment password".tr,
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              color: Config.kTheme!.text1)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Text("Please set up your payment password".tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Config.kTheme!.text1.withOpacity(0.7),
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 40.w, left: 20.w, right: 20.w),
                      child: CodeInput(onCompleted: (String res) {
                        controller.pinFinish = false;
                        if (res.length >= 6) {
                          controller.pinFinish = true;
                          controller.paypasswordStr = res;
                        }
                        controller.updatePinConfirmRefresh();
                      }),
                    ),
                  ]))
        ]));
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
                    border:
                        Border.all(color: const Color(0xff999999), width: 0.8),
                    borderRadius: BorderRadius.circular(8)),
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
