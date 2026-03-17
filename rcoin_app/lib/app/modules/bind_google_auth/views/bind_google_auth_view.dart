import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';

import '../controllers/bind_google_auth_controller.dart';

class BindGoogleAuthView extends GetView<BindGoogleAuthController> {
  const BindGoogleAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AAppBar(
        title: '谷歌验证'.tr,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12.w,
                  )
                ],
              ),
              child: Column(
                children: [
                  10.w.vb,
                  CustomImage(
                    Assets.mineGoogleAuthenticator,
                    width: 140.w,
                  ),
                  4.w.vb,
                  Text(
                    '请在手机上安装谷歌身份验证器'.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.appColors.textPlaceholder,
                    ),
                  ),
                  4.w.vb,
                  Text(
                    '（Google Authenticator）',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.appColors.textPlaceholder,
                    ),
                  ),
                  10.w.vb,
                ],
              ),
            ),
            37.w.vb,
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12.w,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.secret,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: controller.secret));
                      Toast.showSuccess('复制成功'.tr);
                    },
                    child: Text(
                      '复制密钥'.tr,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: context.appColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.w.vb,
            Text(
              '二维码'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            16.w.vb,
            Container(
              width: 135.w,
              height: 135.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.appColors.primary,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: UnconstrainedBox(
                child: QrImageView(
                  size: 120.w,
                  data: controller.qrcodeUrl(),
                ),
              ),
            ),
            40.w.vb,
            AppButton(
              width: double.maxFinite,
              height: 40.w,
              onPressed: () {
                Get.toNamed(Routes.BIND_GOOGLE_AUTH_NEXT, arguments: {
                  'secret': controller.secret,
                });
              },
              title: '下一步'.tr,
              titleStyle: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
              ),
              radius: 8.w,
              elevation: 2,
            )
          ],
        ),
      ),
    );
  }
}
