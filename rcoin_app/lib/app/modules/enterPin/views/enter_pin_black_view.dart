// import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import 'package:otc_app/models/pay_side.dart';
import '../controllers/enter_pin_controller.dart';

class EnterPinBlackView extends GetView<EnterPinController> {
  const EnterPinBlackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function(String)? fn = Get.arguments['onCompleted'];
    PaySide paySide = Get.arguments['paySide'];
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Column(
        children: [
          11.w.vb,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12), bottom: Radius.circular(24))
                  .r,
              color: Config.kTheme!.bg1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '输入密码'.tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff838FA0),
                  ),
                ),
                10.w.vb,
                Text(
                  '为了安全起见，请输入您的交易密码以继续交易'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff5A6981),
                  ),
                ),
                20.w.vb,
                CodeInput(onCompleted: (String res) {
                  controller.pin.value = res;
                }),
                32.w.vb,
                Obx(() => AppButton(
                      width: 334.w,
                      height: 52.w,
                      radius: 8,
                      titleStyle: TextStyle(color: Config.kTheme!.text1),
                      title: paySide == PaySide.sell ? '买入'.tr : '卖出'.tr,
                      onPressed: controller.pin.isEmpty
                          ? null
                          : () {
                              fn?.call(controller.pin.value);
                            },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Text(
              '输入密码支付'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            )
          ],
        ),
      ),
    );
  }
}
