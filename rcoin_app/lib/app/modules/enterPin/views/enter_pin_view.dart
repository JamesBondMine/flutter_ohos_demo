import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/code_input.dart';
import 'package:otc_app/models/pay_side.dart';

import '../controllers/enter_pin_controller.dart';

class EnterPinView extends GetView<EnterPinController> {
  const EnterPinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function(String)? fn = Get.arguments['onCompleted'];
    PaySide paySide = Get.arguments['paySide'];

    return Scaffold(
      appBar: AAppBar(
        title: '输入密码支付'.tr,
        leading: CircleLeading(),
      ),
      body: Column(
        children: [
          11.w.vb,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)).r,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(24).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '为了安全起见，请输入您的交易密码以继续交易'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff5A6981),
                    ),
                  ),
                  20.w.vb,
                  Text(
                    '输入密码'.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff838FA0),
                    ),
                  ),
                  14.w.vb,
                  CodeInput(onCompleted: (String res) {
                    controller.pin.value = res;
                  }),
                  32.w.vb,
                  Obx(() => AppButton(
                        width: 334.w,
                        height: 41.w,
                        title: paySide == PaySide.sell ? '买入'.tr : '卖出'.tr,
                        onPressed: controller.pin.isEmpty ? null : () {
                          fn?.call(controller.pin.value);
                        },
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
