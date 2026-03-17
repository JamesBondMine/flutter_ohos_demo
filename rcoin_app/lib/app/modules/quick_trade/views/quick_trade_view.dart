import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/payment_type.dart';

import '../controllers/quick_trade_controller.dart';

class QuickTradeView extends GetView<QuickTradeController> {
  const QuickTradeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        titleWidget: Text("快捷买币",
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1C1C1C),
            )),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: const Color(0xfff4f4f4),
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Obx(
                    () => controller.isBuy.value
                        ? SvgPicture.asset(Assets.quickTradeLeftPanel,
                            width: 339.w)
                        : SvgPicture.asset(Assets.quickTradeRightPanel,
                            width: 339.w),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.text1,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 44.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  controller.isBuy.value = true;
                                },
                                child: Obx(
                                  () => Container(
                                      padding: EdgeInsets.only(
                                          top: controller.isBuy.value
                                              ? 20.w
                                              : 0),
                                      alignment: Alignment.center,
                                      child: const Text('买币')),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.isBuy.value = false;
                              },
                              child: Obx(() => Container(
                                  padding: EdgeInsets.only(
                                      top: controller.isBuy.value ? 0 : 20.w),
                                  alignment: Alignment.center,
                                  child: const Text('卖币'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: 339.w,
                padding: EdgeInsets.only(left: 10.w, right: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(4.w)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.w),
                    Obx(() => _Field(
                          controller: controller.inputController,
                          title: '我想支付',
                          hintText: '',
                          readOnly: false,
                          suffixText: controller.isBuy.value ? 'USDT' : 'R',
                          onChanged: (String value) {
                            if (value.isEmpty) {
                              controller.valueController.clear();
                              return;
                            }
                            var price = controller.isBuy.value
                                ? controller.usdPrice.value
                                : controller.rPrice;
                            final num = double.tryParse(value) ?? 0;
                            controller.valueController.text =
                                '≈ ${removeTrailingZeros(((price * num).toPrecision(2)).toString())}';
                          },
                        )),
                    Obx(() => _Field(
                          controller: controller.valueController,
                          title: '我会收到',
                          hintText: '',
                          readOnly: true,
                          suffixText: controller.isBuy.value ? 'R' : 'USDT',
                        )),
                    Row(
                      children: [
                        Text(
                          '参考价格：',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Obx(() => Text(
                              '${controller.rPrice}USDT',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.primary,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 6.w),
                    SizedBox(
                        width: 315.w,
                        height: 40.w,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: controller.num.value == 0
                                ? null
                                : () async {
                                    if (controller.num.value == 0) {
                                      return;
                                    }
                                    PaymentType? paymentType =
                                        await Get.bottomSheet(
                                      _BottomSheet(),
                                      isScrollControlled: true,
                                    );
                                    if (paymentType == null) {
                                      return;
                                    }
                                    controller.quickTrade(paymentType);
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              backgroundColor: controller.isBuy.value
                                  ? const Color(0xff04c2ad)
                                  : const Color(0xfff6465d),
                            ),
                            child: Text(
                              controller.isBuy.value ? "买入" : '卖出',
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 18.w),
                  ],
                ),
              ),
              SizedBox(height: 16.w),
              Obx(() => Text(
                    controller.isBuy.value ? "如何购买加密货币？" : '如何出售加密货币？',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )),
              SizedBox(height: 16.w),
              Obx(() => controller.isBuy.value
                  ? const _Step(steps: [
                      '选择购买选项，选择您要支付的法币和收到的加密货币，并输入您要支付的金额或收到的数量',
                      '点击购买并选择一个合适的付款方式。',
                      '确认付款后，您购买的加密货币将自动转入您的账户。',
                    ])
                  : const _Step(steps: [
                      '选择卖出选项，选择您要出售的加密货币和收到的法币，并输入您要出售的数量或收到的金额。',
                      '点击卖出，并选择一种付款方式让买方以您选定的加密货币付款。',
                      '订单处理完毕后，买家将通过您选择的付款方式和您所选的加密货币进行付款。',
                    ])),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheet extends GetView<QuickTradeController> {
  _BottomSheet({super.key});

  Rx<PaymentType?> paymentType = Rx(null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.w))),
      padding: EdgeInsets.all(20.w),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text("确认${controller.isBuy.value ? '购买' : '出售'}",
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.black,
                    )),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    Assets.imagesClose,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 19.w),
            Text(
                controller.isBuy.value
                    ? '₹ ${controller.inputController.text}'
                    : '${controller.inputController.text} R',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 10.w),
            Text(
                "我将收到${!controller.isBuy.value ? '${controller.valueController.text} USDT' : '${controller.valueController.text} R'}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff48484A),
                )),
            SizedBox(height: 16.w),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('选择支付方式'),
                // Text('Config.coinName单价'),
              ],
            ),
            SizedBox(height: 7.w),
            ...PaymentType.values
                .map((e) => Obx(
                      () => PayMethod(
                          color: e.color,
                          title: e.text,
                          price: '₹${controller.usdPrice.value}',
                          checked: paymentType.value == e,
                          onTap: () {
                            paymentType.value = e;
                          }),
                    ))
              ..toList(),
            SizedBox(height: 24.w),
            SizedBox(
              width: 333.w,
              height: 40.w,
              child: Obx(() => ElevatedButton(
                    onPressed: paymentType.value == null
                        ? null
                        : () {
                            if (paymentType.value == null) {
                              return;
                            }
                            Get.back(result: paymentType.value);
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.appColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w))),
                    child: Text(
                      "确认${controller.isBuy.value ? '购买' : '出售'}",
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        color: context.appColors.text1,
                      ),
                    ),
                  )),
            ),
            SizedBox(height: 24.w),
          ],
        ),
      ),
    );
  }
}

class PayMethod extends StatelessWidget {
  const PayMethod(
      {super.key,
      required this.color,
      required this.title,
      required this.price,
      required this.checked,
      required this.onTap});

  final Color color;
  final String title;
  final String price;
  final bool checked;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle style = checked
        ? TextStyle(fontSize: 14.sp, color: context.appColors.primary)
        : TextStyle(fontSize: 14.sp, color: context.appColors.text1);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.w),
        padding:
            EdgeInsets.only(left: 6.w, right: 10.w, top: 11.w, bottom: 11.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: checked ? const Color(0xff48484A) : const Color(0xfff6f6f6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 11.w,
                  width: 3.w,
                  decoration: ShapeDecoration(
                    color: color,
                    shape: const StadiumBorder(),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(title, style: style),
              ],
            ),
            // Text(price, style: style),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.readOnly,
    required this.suffixText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool readOnly;
  final String suffixText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp),
        ),
        SizedBox(height: 6.w),
        TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 17.sp,
          ),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputFormatters: [
            positiveNumberFormatter,
          ],
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: outlineInputDecoration.copyWith(
              hintText: hintText,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    alignment: Alignment.centerRight,
                    child: Text(
                      suffixText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.text1,
                      ),
                    ),
                  ),
                  6.w.hb,
                  // Icon(
                  //   Icons.keyboard_arrow_down,
                  //   color: context.appColors.primary,
                  // ),
                  // 6.w.hb,
                ],
              )),
        ),
        SizedBox(height: 16.w),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({super.key, required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    // List<String> steps = [
    //   '选择购买选项，选择您要支付的法币和收到的加密获批，并输入您要支付的金额或收到的数量',
    //   '点击购买并选择一个合适的付款方式。',
    //   '确认付款后，您购买的加密货币将自动转入您的账户。',
    // ];
    for (var i = 0; i < steps.length; i++) {
      final circle = Container(
        width: 27.w,
        height: 27.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: context.appColors.primary,
              width: 1.w,
            )),
        alignment: Alignment.center,
        child: Text("${i + 1}",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            )),
      );
      final dash = DashedLine(
        height: 31.w,
        dashWidth: 1.w,
        dashHeight: 3.w,
        color: context.appColors.primary,
      );
      children.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          i < steps.length - 1
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    circle,
                    dash,
                  ],
                )
              : circle,
          SizedBox(width: 9.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.w),
              child: Text(
                steps[i],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ));
    }
    return Column(
      children: children,
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final Color color;

  DashedLine({
    super.key,
    required this.height,
    required this.dashWidth,
    required this.dashHeight,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final dashCount = (height / (2 * dashHeight)).floor();

    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dashCount, (_) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: dashHeight / 2),
            width: dashWidth,
            height: dashHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
      ),
    );
  }
}
