import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import '../../../widgets/button.dart';
import '../controllers/forgetpassword_controller.dart';

class ForgetpasswordView extends GetView<ForgetpasswordController> {
  const ForgetpasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AAppBar(
          backgroundColor: Colors.white,
          title: '忘记密码'.tr,
          leading: const CircleLeading(),
        ),
        body: SafeArea(
            child: Container(
          color: const Color(0xffffffff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '找回方式'.tr,
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 11.w,
              ),
              // GestureDetector(
              //   onTap: () {
              //     controller.usePhone.value = false;
              //     Get.toNamed(Routes.FORGETPASSWORDVERIFY);
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: 20.w, right: 20.w),
              //     width: MediaQuery.of(context).size.width - 40.w,
              //     height: 46.w,
              //     decoration: const BoxDecoration(
              //       color: Color(0xffF6F6F6),
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //     ),
              //     padding: const EdgeInsets.only(left: 10, right: 10),
              //     child:  Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           '邮箱找回'.tr,
              //           style: TextStyle(
              //             color: const Color(0xff333333),
              //             fontSize: 16.sp,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              GestureDetector(
                onTap: () {
                  controller.usePhone.value = true;
                  Get.toNamed(Routes.FORGETPASSWORDVERIFY);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  width: MediaQuery.of(context).size.width - 40.w,
                  height: 46.w,
                  decoration: const BoxDecoration(
                    color: Color(0xfff6f6f6),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '手机号找回'.tr,
                        style: const TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
