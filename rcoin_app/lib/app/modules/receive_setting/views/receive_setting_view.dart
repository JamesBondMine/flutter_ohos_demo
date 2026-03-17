import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/receive_setting/widgets/PaymentsSelect.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/app/widgets/text_field.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';

import '../controllers/receive_setting_controller.dart';

class ReceiveSettingView extends GetView<ReceiveSettingController> {
  const ReceiveSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle inputStyle =
        TextStyle(fontSize: 14.sp, color: context.appColors.text1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AAppBar(
        title: '发布${controller.paySide == PaySide.buy ? '买入' : '卖出'}'.tr,
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 17.w, right: 24.w),
        child: Column(
          children: [
            InputField(
              title:
                  '今日${controller.paySide == PaySide.buy ? '购买' : '卖出'}上限'.tr,
              textField: TextField(
                controller: controller.numberCtrl,
                style: inputStyle,
                inputFormatters: [
                  positiveNumberFormatter,
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(hintText: '请输入购买数量'.tr),
              ),
            ),
            InputField(
              title:
                  '单次${controller.paySide == PaySide.buy ? '购买' : '卖出'}上限'.tr,
              textField: TextField(
                controller: controller.maxCtrl,
                style: inputStyle,
                inputFormatters: [
                  positiveNumberFormatter,
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(hintText: '请输入最大金额'.tr),
              ),
            ),
            InputField(
              title:
                  '单次${controller.paySide == PaySide.buy ? '购买' : '卖出'}下限'.tr,
              textField: TextField(
                controller: controller.minCtrl,
                readOnly: true,
                enabled: false,
                style: inputStyle,
                inputFormatters: [
                  positiveNumberFormatter,
                ],
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(hintText: '请输入最小金额'.tr),
              ),
            ),
            ListTile(
              onTap: () async {
                final List<TradePaymentChannel>? res = await Get.bottomSheet(
                    PaymentsSelect(
                      selectedChannels: controller.selectedChannels.toList(),
                    ),
                    isScrollControlled: true);
                if (res != null) {
                  controller.selectedChannels.value = res;
                }
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Text(
                '${controller.paySide == PaySide.buy ? '付' : '收'}款类型'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text1,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xff999999),
              ),
            ),
            Obx(() => Align(
                  alignment: Alignment.centerLeft,
                  child: SelectedPayments(
                      payments: controller.paymentTypes.toSet()),
                )),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150.w,
                  height: 38.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.updateSetting();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                    ),
                    child: Text(
                      '保存配置'.tr,
                      style: TextStyle(
                        fontSize:
                            Get.locale == const Locale('zh_CN') ? 17.sp : 12.sp,
                        fontWeight: FontWeight.bold,
                        color: context.appColors.text1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  height: 38.w,
                  child: Obx(() => ElevatedButton(
                      onPressed: () async {
                        controller.toggleOpen();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.setting.value.state == 1
                            ? context.appColors.red
                            : context.appColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                      child: Text(
                        controller.setting.value.state == 1
                            ? '停止接单'.tr
                            : '开启接单'.tr,
                        style: TextStyle(
                          fontSize: Get.locale == const Locale('zh_CN') ? 17.sp : 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))),
                ),
              ],
            ),
            20.w.vb,
          ],
        ),
      )),
    );
  }
}

class SelectedPayments extends StatelessWidget {
  const SelectedPayments({super.key, required this.payments});

  final Set<PaymentType> payments;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final payment in payments) {
      children.add(buildPayment(context, payment));
      children.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          18.w.hb,
          Container(
            width: 1.w,
            height: 10.w,
            color: const Color(0xffEFEFEF),
          ),
          18.w.hb,
        ],
      ));
    }
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return Wrap(runSpacing: 18.w, children: children);
  }

  buildPayment(BuildContext context, PaymentType paymentType) {
    return switch (paymentType) {
      PaymentType.wechat => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              Assets.imagesWechat,
              width: 16.w,
            ),
            6.w.hb,
            Text(
              '微信',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.appColors.text1,
              ),
            )
          ],
        ),
      PaymentType.alipay => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              Assets.imagesAlipay,
              width: 16.w,
            ),
            6.w.hb,
            Text(
              ' 支付宝',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.appColors.text1,
              ),
            )
          ],
        ),
      PaymentType.bank => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              Assets.imagesBank,
              width: 16.w,
            ),
            6.w.hb,
            Text(
              '银行卡',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.appColors.text1,
              ),
            )
          ],
        ),
      PaymentType.usdt => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              Assets.imagesUsdt,
              width: 16.w,
            ),
            6.w.hb,
            Text(
              'USDT',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.appColors.text1,
              ),
            )
          ],
        ),
      _ => Container(),
    };
  }
}

class PaymentMethodSelect extends StatefulWidget {
  const PaymentMethodSelect(
      {super.key, required this.paymentTypes, required this.title});

  final Set<PaymentType> paymentTypes;
  final String title;

  @override
  State<PaymentMethodSelect> createState() => _PaymentMethodSelectState();
}

class _PaymentMethodSelectState extends State<PaymentMethodSelect> {
  late final Set<PaymentType> paymentTypes;

  @override
  void initState() {
    paymentTypes = widget.paymentTypes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ReceiveSettingController>();
    final availablePaymentMethods =
        controller.paymentMethods.map((e) => e.id!).toSet();
    final List<Widget> methods = [];

    var paymentMethods = PaymentType.values
        .where((e) => availablePaymentMethods.contains(e.value));
    // if (controller.paySide == PaySide.sell) {
    //   paymentMethods = paymentMethods.where((e) => !e.smallAmount).toList();
    // }
    for (var paymentType in paymentMethods) {
      methods.addAll([
        const Divider(),
        _PaymentLine(
          title: paymentType.text,
          iconPath: paymentType.icon,
          onTap: () {
            if (paymentTypes.contains(paymentType)) {
              paymentTypes.remove(paymentType);
            } else {
              paymentTypes.add(paymentType);
            }
            setState(() {});
          },
          selected: paymentTypes.contains(paymentType),
        ),
      ]);
    }

    Widget bottomSheet = Container(
      width: 355.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(4.w))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.w.vb,
          Text(widget.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: context.appColors.text1,
              )),
          10.w.vb,
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(4.w),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "收款渠道",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff999999),
                  ),
                ),
                ...methods,
              ],
            ),
          ),
          10.w.vb,
          SizedBox(
            width: 315.w,
            height: 38.w,
            child: ElevatedButton(
              onPressed: () {
                Get.back(result: paymentTypes);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.w),
                ),
              ),
              child: Text(
                '确认渠道',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.text1,
                ),
              ),
            ),
          ),
          30.w.vb,
        ],
      ),
    );

    bottomSheet = UnconstrainedBox(
      child: Stack(
        children: [
          bottomSheet,
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xff999999),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );

    return bottomSheet;
  }
}

class _PaymentLine extends StatelessWidget {
  const _PaymentLine({
    super.key,
    required this.selected,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final bool selected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.w.hb,
              Container(
                  height: 20.w,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(iconPath, width: 16.w)),
              6.w.hb,
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text1,
                ),
              ),
            ],
          ),
          Visibility(
            visible: selected,
            child: SvgPicture.asset(
              Assets.tradeChecked,
              width: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}
