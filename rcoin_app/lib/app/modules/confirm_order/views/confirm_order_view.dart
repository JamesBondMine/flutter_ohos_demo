import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/confirm_order/views/pament_select_bottm_view.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/services/chat_service.dart';
import '../controllers/confirm_order_controller.dart';

class ConfirmOrderView extends GetView<ConfirmOrderController> {
  const ConfirmOrderView({Key? key}) : super(key: key);

  PublishOrder get order => controller.order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20).w,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 7, bottom: 13)
                    .w,
                child: Column(
                  children: [_cardDetail(), _cardAmount(), 12.w.vb],
                ),
              ),
              14.w.vb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text('交易须知'.tr,
                        style: TextStyle(
                            color: Config.kTheme!.text1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                  10.w.vb,
                  Container(
                    padding: const EdgeInsets.only(
                            left: 12, right: 19, top: 5, bottom: 6)
                        .w,
                    child: Text(
                      'tradeTerms'.tr,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Config.kTheme!.text2,
                      ),
                    ),
                  ),
                  12.w.vb,
                ],
              ),
              10.w.vb,
              AppButton(
                width: 334.w,
                height: 52.w,
                titleStyle:
                    TextStyle(color: Config.kTheme!.text1, fontSize: 16.sp),
                title: order.type == PaySide.sell.value ? '买入'.tr : '卖出'.tr,
                radius: 8,
                onPressed: () {
                  controller.send();
                },
              ),
              20.w.vb,
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardAmount() {
    return Container(
        margin: EdgeInsets.only(top: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: Config.kTheme!.bg1,
        ),
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 9.w, bottom: 27.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Pay'.tr,
            style: TextStyle(color: Config.kTheme!.text1, fontSize: 16.sp),
          ),
          24.w.vb,
          Container(
            height: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Config.kTheme!.text2.withOpacity(0.5), width: 0.8)),
            child: TextField(
              controller: controller.inputController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                positiveNumberFormatter,
              ],
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Config.kTheme!.text1,
                  fontWeight: FontWeight.bold),
              decoration: outlineInputDecoration.copyWith(
                hintText: '例如 100'.tr,
                hintStyle: TextStyle(color: Config.kTheme!.text2, fontSize: 13),
                fillColor: Colors.white.withOpacity(0),
                suffixIcon: Container(
                  padding: EdgeInsets.only(right: 11.w),
                  child: GestureDetector(
                    onTap: () {
                      controller.inputMax();
                    },
                    child: Text(
                      '全部'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff28A1FF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          24.w.vb,
          Container(
            alignment: Alignment.centerLeft,
            child: Obx(() {
              var options = controller.options.toList();
              return Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: List.generate(
                  options.length,
                  (index) => GestureDetector(
                    onTap: () {
                      controller.optionIndex.value = index;
                      controller.inputController.text =
                          options[index].toString();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Config.kTheme!.bgbtn),
                      height: 52.w,
                      width: (Get.width - 90) / 3,
                      child: Text(
                        "${options[index]}",
                        style: TextStyle(
                            fontSize: 16.sp, color: Config.kTheme!.text1),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          24.w.vb,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('金额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2)),
              Obx(() => Text(
                  '${order.type == PaySide.sell.value ? '+' : '-'} ${removeTrailingZeros(controller.equivalentQuantity.value.toString())}RSO',
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text1))),
            ],
          ),
          24.w.vb,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('总额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2)),
              Obx(() => Text(
                  '${order.type == PaySide.sell.value ? '-' : '+'} ${controller.equivalentAmount.value.rtz}RSO',
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text1))),
            ],
          ),
        ]));
  }

  Widget _cardDetail() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: Config.kTheme!.bg1,
        ),
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 9.w, bottom: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order info'.tr,
              style: TextStyle(color: Config.kTheme!.text1, fontSize: 16.sp),
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '单价'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  "₹${order.price}",
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text1),
                ),
              ],
            ),
            20.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '限制额度'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                // Spacer(),
                Text(
                    '₹${removeTrailingZeros(order.minMoney.toString())} - ₹${removeTrailingZeros(order.maxMoney.toString())}',
                    style: TextStyle(
                        color: Config.kTheme!.text1, fontSize: 14.sp)),
              ],
            ),
            20.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '付款时限'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Spacer(),
                CustomImage(Assets.ordertime2, width: 16.w),
                2.w.hb,
                Text("${order.transactionDuration} ${'分钟'.tr}",
                    style: TextStyle(
                        color: Config.kTheme!.text1, fontSize: 14.sp)),
              ],
            ),
            20.w.vb,
            GestureDetector(
              onTap: () {
                _paymentSelectEvent();
              },
              child: _paymentMethodView(order),
            ),
            20.w.vb,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.type == PaySide.buy.value ? '买' : '卖'}家留言'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                SizedBox(
                  width: Get.width - 200,
                  child: Text(
                    '${order.remark}',
                    maxLines: 5,
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(fontSize: 14.sp, color: Config.kTheme!.text1),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Future<String> _delayPayment(PublishOrder order) async {
    if (controller.payMethod.isEmpty) {
      return "";
    }
    String method = order.payMethod.split(",").first;
    if (controller.payMethod.isEmpty) {
      controller.payMethod = method;
    }
    if (controller.payMethod.split(",").length > 1) {
      controller.payMethod = controller.payMethod.split(",").first;
      return pts[controller.payMethod.split(",").first];
    }
    return pts[controller.payMethod];
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

  // paymentMethod
  _paymentMethodView(PublishOrder order) {
    controller.payMethod = order.payMethod;
    return GetBuilder<ConfirmOrderController>(
        id: controller.orderConfirmPaymentRefreshId,
        builder: (value) {
          return FutureBuilder(
              future: _delayPayment(order),
              builder: ((context, AsyncSnapshot<String> snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '交易方式'.tr,
                      style: TextStyle(
                          fontSize: 14.sp, color: Config.kTheme!.text2),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: !snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.isEmpty
                          ? Container()
                          : CustomImage(
                              snapshot.data!,
                              height: 20.w,
                              color: Config.kTheme!.text2,
                            ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Config.kTheme!.text1,
                    )
                  ],
                );
              }));
        });
  }

  _paymentSelectEvent() async {
    List<PaymentType> pamentList = [];
    Get.bottomSheet(
        PaymentSelectView(
          paymentTypes: pamentList.toSet(),
          title: '收款类型'.tr,
          select: (List<PaymentType> value) {
            if (value.isNotEmpty) {
              controller.payMethod = value.first.value.toString();
              controller.updateOrderConfirmPaymentRefresh();
            }
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
              '确认订单'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              child: CustomImage(
                Assets.newimagesCommentService,
                color: Config.kTheme!.text1,
                onTap: () {
                  ChatService.to.goChatWithService();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatefulWidget {
  const _Tab({super.key, required this.onTap, required this.tabs});

  final Function(int index) onTap;
  final List<String> tabs;

  @override
  State<_Tab> createState() => _TabState();
}

class _TabState extends State<_Tab> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      var title = widget.tabs[i];
      children.add(GestureDetector(
        onTap: () {
          if (index != i) {
            setState(() {
              index = i;
            });
            widget.onTap(i);
          }
        },
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: index == i ? FontWeight.bold : FontWeight.w400,
              ),
            ),
            if (index == i)
              Container(
                width: 30.w,
                height: 2.w,
                color: context.appColors.primary,
              )
          ],
        ),
      ));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: children,
    );
  }
}
