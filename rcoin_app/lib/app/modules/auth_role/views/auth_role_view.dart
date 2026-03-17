import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/bottom_widget.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/app/widgets/text_field.dart';

import '../controllers/auth_role_controller.dart';

class AuthRoleView extends GetView<AuthRoleController> {
  const AuthRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = Get.arguments['type'] ?? 1;
    return Scaffold(
      appBar: AAppBar(
        title: '认证'.tr,
        shadow: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 17.w, right: 24.w),
              child: Column(
                children: [
                  InputField(
                    title: type == 2 ? '商户名称'.tr : '昵称'.tr,
                    textField: TextField(
                      controller: controller.nickNameCtrl,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      decoration: InputDecoration(
                          hintText: '请输入您的${type == 2 ? '商户名称' : '昵称'}'.tr),
                    ),
                  ),
                  InputField(
                    title: '联系方式',
                    textField: TextField(
                      controller: controller.contactCtrl,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                      decoration: InputDecoration(hintText: '请输入您的联系方式'.tr),
                    ),
                  ),
                  Visibility(
                    visible: type == 2,
                    child: InputField(
                      title: '地址链接'.tr,
                      textField: TextField(
                        controller: controller.urlCtrl,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.text1,
                        ),
                        decoration: InputDecoration(hintText: '请输入您的地址链接'.tr),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            BottomWidget(child: SizedBox(
              width: 315.w,
              height: 38.w,
              child: ElevatedButton(
                onPressed: () {
                  controller.auth();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
                child: Text(
                  '提交'.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.text1,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
