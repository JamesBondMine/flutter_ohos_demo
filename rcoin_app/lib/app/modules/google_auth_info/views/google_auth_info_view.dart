import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import '../controllers/google_auth_info_controller.dart';

class GoogleAuthInfoView extends GetView<GoogleAuthInfoController> {
  const GoogleAuthInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AAppBar(
        title: '谷歌验证'.tr,
      ),
      body: Column(
        children: [
          15.w.vb,
          Container(
            color: Colors.white,
            padding:
                EdgeInsets.only(left: 26.w, top: 7.w, bottom: 7.w, right: 6.w),
            child: Row(
              children: [
                Container(
                  width: 26.w,
                  height: 26.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.appColors.primary,
                  ),
                  alignment: Alignment.center,
                  child: CustomImage(
                    Assets.mineGoogleAuthIcon,
                    width: 18.w,
                  ),
                ),
                9.w.hb,
                Text(
                  '谷歌验证身份'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.BIND_GOOGLE_AUTH);
                    },
                    icon: const CustomImage(Assets.mineEdit)),
                IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.DELETE_GOOGLE_AUTH);
                    },
                    icon: const CustomImage(Assets.mineDelete)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
