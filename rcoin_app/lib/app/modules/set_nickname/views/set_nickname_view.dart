import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import '../controllers/set_nickname_controller.dart';

class SetNicknameView extends GetView<SetNicknameController> {
  const SetNicknameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide.none,
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff4f4f4),
        appBar: AAppBar(
          title: '昵称'.tr,
          actions: [
            TextButton(
                onPressed: () {
                  controller.save();
                },
                child: Text("保存".tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.primary,
                    )))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.w.vb,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  controller: controller.controller,
                  autofocus: true,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.only(
                      left: 9.w,
                      right: 9.w,
                      top: 11.w,
                      bottom: 8.w,
                    ),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '请输入昵称'.tr,
                  ),
                ),
              ),
              14.w.vb,
              Container(
                padding: EdgeInsets.only(left: 25.w),
                child: Text("5-12位字母或数字，请勿使用特殊符号".tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff666666),
                    )),
              )
            ],
          ),
        ));
  }
}
