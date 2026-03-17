import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/config.dart';

import '../../../../common/widgets/custom_image.dart';
import '../../../../generated/assets.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/button.dart';
import '../controllers/user_coin_pay_controller.dart';

class UserCoinPayView extends GetView<UserCoinPayController> {
  const UserCoinPayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(Assets.loginLoginBackdrop),
            //   fit: BoxFit.cover,
            // ),
            color: Config.kTheme!.bgMain),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  CustomImage(
                    Assets.iconIconIos,
                    width: 80.w,
                    height: 80.w,
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Text(
                    controller.msg.tr,
                    style: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70.w,
                  ),
                  Text(
                    //₹150,00
                    '₹${controller.amount}',
                    style: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (controller.type == 0)
                Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: AppButton(
                      width: MediaQuery.of(context).size.width - 40.w,
                      height: 60.w,
                      title: '完成'.tr,
                      titleStyle: TextStyle(color: Config.kTheme!.text1),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Get.back();
                        // Get.toNamed(Routes.CONFIRM_ORDER);
                      },
                      radius: 30.w,
                    )),
              if (controller.type == 1)
                Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                          width: 100.w,
                          height: 41.w,
                          title: '取消'.tr,
                          titleStyle: TextStyle(color: Config.kTheme!.text1),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Get.back();
                            // Get.toNamed(Routes.CONFIRM_ORDER);
                          },
                          radius: 30.w,
                        ),
                        AppButton(
                          width: 100.w,
                          height: 41.w,
                          title: '充值'.tr,
                          titleStyle: TextStyle(color: Config.kTheme!.text1),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Get.offNamed(Routes.RECHARGE);
                            // Get.toNamed(Routes.CONFIRM_ORDER);
                          },
                          radius: 30.w,
                        ),
                      ],
                    )),
              if (controller.type == 2)
                Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: AppButton(
                      width: MediaQuery.of(context).size.width - 40.w,
                      height: 60.w,
                      title: '取消'.tr,
                      titleStyle: TextStyle(color: Config.kTheme!.text1),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Get.back();
                        // Get.toNamed(Routes.CONFIRM_ORDER);
                      },
                      radius: 30.w,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
