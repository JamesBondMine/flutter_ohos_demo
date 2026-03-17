import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/confirm_order/views/pament_select_bottm_view.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_success.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/payment_type.dart';

import '../controllers/post_order_controller.dart';

class PostOrderSellView extends GetView<PostOrderController> {
  const PostOrderSellView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle inputStyle =
        TextStyle(fontSize: 14.sp, color: context.appColors.text1);
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      resizeToAvoidBottomInset: false,
      appBar: _headerView(context),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            _sellerView(),
            20.w.vb,
            AppButton(
              width: Get.width - 32.w,
              height: 52.w,
              radius: 8.w,
              onPressed: () async {
                final bool? confirm = await confirmBottomSheet(
                    title: '您确认要发布该广告嘛'.tr, subTitle: '');
                if (confirm != null && confirm) {
                  controller.publish(1);
                }
              },
              title: '发布订单'.tr,
            ),
            80.w.vb,
          ],
        ),
      )),
    );
  }

  Widget _sellerView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 10.w, right: 10),
                  child: Text(
                    '出售信息'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: Text('销售量'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Config.kTheme!.text2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 35,
                width: Get.width - 170,
                // color: Colors.amber,
                child: TextField(
                  controller: controller.numberCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  inputFormatters: [
                    positiveNumberFormatter,
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  style: TextStyle(color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入销售金额'.tr,
                      hintStyle: TextStyle(
                          color: Config.kTheme!.text2, fontSize: 13.sp),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: Text('单个销售上限'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp, color: Config.kTheme!.text2)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 35,
                width: Get.width - 170,
                // color: Colors.amber,
                child: TextField(
                  controller: controller.maxCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  inputFormatters: [
                    positiveNumberFormatter,
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  style: TextStyle(color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入最大金额'.tr,
                      hintStyle: TextStyle(
                          color: Config.kTheme!.text2, fontSize: 13.sp),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: Text('单个销售下限'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Config.kTheme!.text2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 35,
                width: Get.width - 170,
                // color: Colors.amber,
                child: TextField(
                  controller: controller.minCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  inputFormatters: [
                    positiveNumberFormatter,
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  style: TextStyle(color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入最小金额'.tr,
                      hintStyle: TextStyle(
                          color: Config.kTheme!.text2, fontSize: 13.sp),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: Text('备注'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Config.kTheme!.text2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 35,
                width: Get.width - 170,
                // color: Colors.amber,
                child: TextField(
                  controller: controller.remarkCtrl,
                  enabled: true,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      hintText: '请输入您要留下的备注'.tr,
                      hintStyle: TextStyle(
                          color: Config.kTheme!.text2, fontSize: 13.sp),
                      focusColor: Colors.white,
                      fillColor: Colors.black.withOpacity(0)),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              _paymentSelectEvent();
            },
            child: _paymentMethodView(),
          ),
        ]));
  }

  Map<String, dynamic> get pts => {
        "5": Assets.orderPpment1,
        "6": Assets.orderPpment3,
        "7": Assets.orderPpment2,
        "8": Assets.orderPpment4,
        "9": Assets.orderPpment5,
        "10": Assets.orderPpment6,
        // 默认
        "1": Assets.orderPpment1,
        "2": Assets.orderPpment1,
        "3": Assets.orderPpment1,
        "4": Assets.orderPpment1
      };

  _paymentMethodView() {
    return GetBuilder<PostOrderController>(
        id: controller.orderPostPaymentRefreshId,
        builder: (value) {
          List<Widget> selectList = [];
          for (var i = 0; i < controller.selectPaymentList.length; i++) {
            if (i != 0) {
              selectList.add(SizedBox(
                width: 6.w,
              ));
            }
            String path = pts["${controller.selectPaymentList[i].value}"];
            selectList.add(CustomImage(path));
          }
          return SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '收款类型'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: selectList.isEmpty
                      ? Text(
                          "Please select".tr,
                          style: TextStyle(
                              color: Config.kTheme!.text2, fontSize: 13.sp),
                        )
                      : Row(
                          children: selectList,
                        ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Config.kTheme!.text2,
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          );
        });
  }

  _success(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostOrderSuccess()),
    );
  }

  _paymentSelectEvent() async {
    List<PaymentType> pamentList = controller.payMethods.value;
    Get.bottomSheet(
        PaymentSelectView(
          paymentTypes: pamentList.toSet(),
          title: '收款类型'.tr,
          onlySingleSelect: false,
          select: (List<PaymentType> value) {
            controller.selectPaymentList = value;
            controller.updateOrderPostPaymentRefresh();
            controller.payMethods.value = value;
          },
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ));
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
              '发布出售'.tr,
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

class SelectedPayments extends StatelessWidget {
  const SelectedPayments({super.key, required this.payments});

  final Set<PaymentType> payments;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final payment in payments) {
      children.add(buildPayment(context, payment));
      // children.add(10.w.hb);
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 15,
        children: children,
      ),
    );
  }

  buildPayment(BuildContext context, PaymentType paymentType) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5).w,
        color: context.appColors.primary.withOpacity(.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            paymentType.text,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.appColors.text1,
            ),
          )
        ],
      ),
    );
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
    List<Widget> options = [];
    for (final paymentType in PaymentType.values.where((e) => [
          PaymentType.wechat,
          PaymentType.alipay,
          PaymentType.bank,
          // PaymentType.usdt
        ].contains(e))) {
      options.add(_PaymentLine(
        title: paymentType.text,
        onTap: () {
          if (paymentTypes.contains(paymentType)) {
            paymentTypes.remove(paymentType);
          } else {
            paymentTypes.add(paymentType);
          }
          setState(() {});
        },
        selected: paymentTypes.contains(paymentType),
      ));
    }

    Widget bottomSheet = Container(
      width: 1.sw,
      // width: 355.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 20).w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.w.vb,
          Align(
            alignment: Alignment.center,
            child: Text(widget.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.text1,
                )),
          ),
          10.w.vb,
          Text(
            "收款渠道".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.appColors.text1,
              fontWeight: FontWeight.bold,
            ),
          ),
          12.w.vb,
          Column(
            children: options,
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
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                '确认渠道'.tr,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
    required this.onTap,
  });

  final String title;
  final bool selected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: context.appColors.primary.withOpacity(.1),
        ),
        margin: EdgeInsets.only(bottom: 12).w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
      ),
    );
  }
}
