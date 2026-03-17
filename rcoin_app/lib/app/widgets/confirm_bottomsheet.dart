import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import 'button.dart';

class ConfirmBottomSheet extends StatelessWidget {
  const ConfirmBottomSheet(
      {super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 350,
        // padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
        child: Stack(
          children: [
            // const Positioned(
            //     left: 0,
            //     right: 0,
            //     top: 0,
            //     child: CustomImage(Assets.alertHead)),
            Positioned(
                left: 20,
                top: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 42.w,
                      height: 6.w,
                    ),
                    14.w.vb,
                    CustomImage(
                      Assets.publishC,
                      width: 140.w,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Config.kTheme!.text1,
                      ),
                    ),
                    5.w.vb,
                    Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Config.kTheme!.text2,
                      ),
                    ),
                    30.w.vb,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          width: 162.w,
                          height: 52.w,
                          onPressed: () {
                            Get.back();
                          },
                          backgroundColor: Colors.transparent,
                          title: '取消'.tr,
                          radius: 8,
                          titleStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Config.kTheme!.text2),
                          borderSide: BorderSide(
                              color: Config.kTheme!.text2.withOpacity(0.5),
                              width: 0.8),
                        ),
                        AppButton(
                          width: 162.w,
                          height: 52.w,
                          onPressed: () {
                            Get.back(result: true);
                          },
                          // backgroundColor: Config.kTheme!.bgbtn,
                          title: '确定'.tr,
                          radius: 8,
                          // titleStyle: TextStyle(
                          //     fontSize: 14.sp,
                          //     fontWeight: FontWeight.bold,
                          //     color: Config.kTheme!.text1),
                          // borderSide: BorderSide(color: Config.kTheme!.text1),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
