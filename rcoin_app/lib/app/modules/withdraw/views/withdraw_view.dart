import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/app/widgets/text_field.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/chain_type.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../application/controllers/application_controller.dart';
import '../controllers/withdraw_controller.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle inputStyle =
        TextStyle(fontSize: 14.sp, color: context.appColors.text1);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AAppBar(
        leading: const CircleLeading(),
        title: '提现'.tr,
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(Routes.WITHDRAW_LOGS);
              },
              child: Text(
                '明细'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xff999999),
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 17.w, right: 24.w),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18.w,
                  ),
                  Text(
                    '选择公链协议'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: context.appColors.text1,
                    ),
                  ),
                  10.w.vb,
                  const Chains(),
                ],
              ),
              InputField(
                title: '收款地址'.tr,
                textField: TextField(
                  controller: controller.addrCtrl,
                  style: inputStyle,
                  inputFormatters: [],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  decoration: outlineInputDecoration.copyWith(
                    hintText: '请输入收款地址'.tr,
                    suffixIcon: CustomImage(
                      Assets.otherScan,
                      width: 40.w,
                      color: context.appColors.primary,
                      onTap: () async {
                        var scanData = await Get.toNamed(Routes.SCAN_PAGE);
                        if (scanData != null) {
                          var code = (scanData as Barcode).code;
                          controller.addrCtrl.text = code ?? '';
                        }
                      },
                    ),
                  ),
                ),
              ),
              InputField(
                title: '提现金额'.tr,
                textField: TextField(
                  controller: controller.numberCtrl,
                  style: inputStyle,
                  inputFormatters: [
                    positiveNumberFormatter,
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  decoration: outlineInputDecoration.copyWith(
                    hintText: '请输入提现金额'.tr,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.numberCtrl.text =
                            (ApplicationController
                                .to.assets.value?.money ??
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
              ),
              InputField(
                title: '手续费'.tr,
                textField: TextField(
                  controller: controller.feeCtrl,
                  style: TextStyle(fontSize: 14.sp),
                  readOnly: true,
                  decoration: outlineInputDecoration.copyWith(
                    hintText: '-',
                    suffixIcon: Text(Config.coinName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.textPlaceholder,
                        )),
                  ),
                ),
              ),
              InputField(
                title: '将收到'.tr,
                textField: TextField(
                  controller: controller.usdtCtrl,
                  style: inputStyle,
                  readOnly: true,
                  decoration: outlineInputDecoration.copyWith(
                    prefixIcon: Text(
                      '≈',
                      style: inputStyle,
                    ),
                    suffixIcon: Text(
                      'USDT',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              InputField(
                title: '备注'.tr,
                textField: TextField(
                  controller: controller.remarkCtrl,
                  style: inputStyle,
                  decoration: outlineInputDecoration.copyWith(hintText: '请输入您要留下的备注'.tr),
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 315.w,
                height: 38.w,
                child: ElevatedButton(
                  onPressed: () async {
                    bool? confirm = await confirmBottomSheet(title: '您确认要提现吗'.tr, subTitle: '');
                    if (confirm != null && confirm) {
                      controller.publish();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                  ),
                  child: Text(
                    '确定提现'.tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              20.w.vb,
            ],
          ),
        ),
      ),
    );
  }
}

class Chains extends GetView<WithdrawController> {
  const Chains({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => ChainOption(
            title: 'TRC20',
            logo: Assets.rechargeTrc,
            selected: controller.chainType.value == ChainType.trc20,
            onTap: () {
              controller.chainType.value = ChainType.trc20;
            })),
        21.w.hb,
        Obx(() => ChainOption(
            title: 'ERC20',
            logo: Assets.rechargeErc,
            selected: controller.chainType.value == ChainType.erc20,
            onTap: () {
              controller.chainType.value = ChainType.erc20;
            })),
      ],
    );
  }
}

class ChainOption extends StatelessWidget {
  const ChainOption(
      {super.key,
      required this.title,
      required this.logo,
      required this.selected,
      required this.onTap});

  final String title;
  final String logo;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4).r,
                color: const Color(0xff48484a),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(
                    logo,
                    width: 18.w,
                  ),
                  3.w.hb,
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomImage(
                Assets.rechargeIntersect,
                width: 27.w,
              ),
            )
          ],
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 32.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: Colors.white,
          border: Border.all(color: const Color(0xffE7E7E7), width: 1.w),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              logo,
              width: 18.w,
            ),
            3.w.hb,
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xffAEAEAE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
