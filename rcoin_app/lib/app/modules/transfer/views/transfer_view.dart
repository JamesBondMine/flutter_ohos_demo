import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/app/widgets/text_field.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/transfer_controller.dart';

class TransferView extends GetView<TransferController> {
  const TransferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AAppBar(
        title: '转账'.tr,
        leading: const CircleLeading(),
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(Routes.TRANSFER_LOGS);
              },
              child: Text(
                '转账记录'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.textPlaceholder,
                ),
              ))
        ],
      ),
      body: Container(
        color: Color(0xfff9f9f9),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: FillRemainWidget(
          topChildren: [
            InputField(
              title: '您的转账地址'.tr,
              textField: TextField(
                controller: controller.addressController,
                style: TextStyle(fontSize: 14.sp),
                decoration: outlineInputDecoration.copyWith(
                    hintText: '输入或粘贴地址'.tr,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CustomImage(
                        Assets.otherScan,
                        width: 40.w,
                        color: context.appColors.primary,
                        onTap: () async {
                          var scanData = await Get.toNamed(Routes.SCAN_PAGE);
                          if (scanData != null) {
                            var code = (scanData as Barcode).code;
                            controller.addressController.text = code ?? '';
                          }
                        },
                      ),
                    )),
              ),
            ),
            Obx(() => InputField(
                  title: '转账金额'.tr,
                  textField: TextField(
                    controller: controller.numController,
                    style: TextStyle(fontSize: 14.sp),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumberFormatter,
                    ],
                    decoration: outlineInputDecoration.copyWith(
                      hintText: controller.coin.value == null
                          ? ''
                          : '${'限额 '.tr}${controller.coin.value!.transMin?.rtz}-${controller.coin.value!.transMax?.rtz} ${controller.coin.value!.name}',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.numController.text =
                              (ApplicationController.to.assets.value?.money ??
                                      0)
                                  .toString();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text("全部".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.primary,
                              )),
                        ),
                      ),
                    ),
                  ),
                )),
            InputField(
              title: '手续费'.tr,
              textField: TextField(
                controller: controller.feeController,
                style: TextStyle(fontSize: 14.sp),
                readOnly: true,
                decoration: outlineInputDecoration.copyWith(
                  hintText: '-',
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(Config.coinName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.textPlaceholder,
                        )),
                  ),
                ),
              ),
            ),
            InputField(
              title: '实际到账'.tr,
              textField: TextField(
                controller: controller.realNumController,
                style: TextStyle(fontSize: 14.sp),
                readOnly: true,
                decoration: outlineInputDecoration.copyWith(
                  hintText: '-',
                ),
              ),
            ),
          ],
          bottomChild: Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: AppButton(
              height: 41.w,
              width: 334.w,
              onPressed: () {
                // controller.transfer();
              },
              title: '确定'.tr,
              radius: 40,
            ),
          ),
        ),
      ),
    );
  }
}
