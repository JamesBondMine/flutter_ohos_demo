import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/trade/controllers/buy_orders_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/sale_orders_controller.dart';
import 'package:otc_app/app/modules/trade/views/filter_bar.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/publish_order.dart';

import '../controllers/order_filter_controller.dart';
import '../controllers/trade_controller.dart';

class TradeView extends GetView<TradeController> {
  const TradeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaySide side = Get.arguments['side'] ?? PaySide.buy;
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AAppBar(
        backgroundColor: Colors.white,
        title: side == PaySide.sell ? '卖币'.tr : '买币'.tr,
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(12).w,
            padding: const EdgeInsets.symmetric(vertical: 6).w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).r,
              color: Colors.white,
            ),
            child: const FilterBar(),
          ),
          // SizedBox(height: 16.w),
          // const _Select(),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16).w,
                  child: side == PaySide.sell
                      ? SpeedyPagedList<PublishOrder>.separator(
                          controller: Get.find<SaleOrdersController>(),
                          refreshOnStart: true,
                          locatorMode: true,
                          emptyWidget: const EmptyList(),
                          itemBuilder: (context, index, item) {
                            return _PublishOrder(order: item);
                          },
                          separatorBuilder: (context, index) => 16.w.vb,
                        )
                      : SpeedyPagedList<PublishOrder>.separator(
                          controller: Get.find<BuyOrdersController>(),
                          refreshOnStart: true,
                          locatorMode: true,
                          emptyWidget: const EmptyList(),
                          itemBuilder: (context, index, item) {
                            return _PublishOrder(order: item);
                          },
                          separatorBuilder: (context, index) => 16.w.vb,
                        ),
                ),
                Obx(() => Visibility(
                      visible: controller.filterIndex.value != null,
                      child: Column(
                        children: [
                          buildFilterOption(),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.filterIndex.value = null;
                              },
                              child: Container(
                                color: Colors.black.withOpacity(.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFilterOption() {
    if (controller.filterIndex.value == 0) {
      return const _CooperateFilter();
    }
    if (controller.filterIndex.value == 1) {
      return NumberFilterOption(
        currentValue: Get.find<OrderFilterController>().filterMin.value,
        options:  [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          controller.filterIndex.value = null;
          Get.find<OrderFilterController>().filterMin.value = value;
          Get.find<OrderFilterController>().confirmOptions();
        },
      );
    }
    if (controller.filterIndex.value == 2) {
      return NumberFilterOption(
        currentValue: Get.find<OrderFilterController>().filterMax.value,
        options:  [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          controller.filterIndex.value = null;
          Get.find<OrderFilterController>().filterMax.value = value;
          Get.find<OrderFilterController>().confirmOptions();
        },
      );
    }
    if (controller.filterIndex.value == 3) {
      return const _PaymentTypeFilter();
    }
    return Container();
  }
}

class _PublishOrder extends StatelessWidget {
  const _PublishOrder({
    super.key,
    required this.order,
  });

  final PublishOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6).r,
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 9.w, bottom: 7.w),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xff999999),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.nickName}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("成单量".tr),
                          Text(" ${order.transactionCount}"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("成单率".tr),
                          Text(" ${order.closeRate}%"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.w),
                  Row(
                    children: [
                      const CustomImage(Assets.imagesTime),
                      3.w.hb,
                      Text('${order.transactionDuration}'),
                      Text('分钟'.tr),
                    ],
                  ),
                  SizedBox(height: 5.w),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '₹ ${removeTrailingZeros(order.price.toString())}',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                               Text('剩余金额 '.tr),
                              Text(
                                '${order.surplusNumber} ₹',
                                style: TextStyle(
                                  color: context.appColors.text1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.w),
                          Row(
                            children: [
                               Text('限额 '.tr),
                              Text(
                                '₹${order.minMoney}-${Config.coinName}${order.maxMoney}',
                                style: TextStyle(
                                  color: context.appColors.text1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 80.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: order.paymentTypes
                                  .map((e) => Text(
                                        e.text,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: context.appColors.primary,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppButton(
                      width: 63.w,
                      height: 28.w,
                      title: order.type == PaySide.sell.value ? '购买'.tr : '出售'.tr,
                      backgroundColor: order.type == PaySide.sell.value
                          ? context.appColors.green
                          : context.appColors.red,
                      onPressed: () {
                        Get.toNamed(Routes.CONFIRM_ORDER, arguments: {
                          'order': order,
                        });
                      },
                      radius: 6.w,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NumberFilterOption extends StatefulWidget {
  const NumberFilterOption(
      {super.key,
      this.currentValue,
      required this.options,
      required this.onConfirm});

  final double? currentValue;
  final List<(String, double)> options;
  final void Function(double? value) onConfirm;

  @override
  State<NumberFilterOption> createState() => _NumberFilterOptionState();
}

class _NumberFilterOptionState extends State<NumberFilterOption> {
  late TextEditingController controller;

  @override
  void initState() {
    controller =
        TextEditingController(text: widget.currentValue?.toString() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
              inputFormatters: [
                positiveNumberFormatter,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: outlineInputDecoration.copyWith(
                hintText: '例如 100'.tr,
              ),
            ),
            7.w.vb,
            Container(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 6.w,
                runSpacing: 6.w,
                children: List.generate(
                  widget.options.length,
                  (index) {
                    final option = widget.options[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.text =
                            removeTrailingZeros(option.$2.toString());
                      },
                      child: Container(
                        width: 97.w,
                        height: 35.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          color: const Color(0xffe8e8e8),
                        ),
                        child: Text(
                          option.$1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: context.appColors.text1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    widget.onConfirm(
                      (controller.isBlank ?? true)
                          ? null
                          : double.tryParse(controller.text),
                    );
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CooperateFilter extends GetView<OrderFilterController> {
  const _CooperateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("有过合作用户".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.text1,
                    )),
                GestureDetector(
                  onTap: () {
                    controller.cooperation.toggle();
                  },
                  child: Obx(() => controller.cooperation.value
                      ? Icon(
                          Icons.check_circle_outline_outlined,
                          size: 14.w,
                          color: context.appColors.primary,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          size: 14.w,
                          color: Color(0xffC1C1C1),
                        )),
                ),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.cooperation.value = false;
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.confirmOptions();
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _PaymentTypeFilter extends GetView<OrderFilterController> {
  const _PaymentTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 5,
                runSpacing: 10,
                children: [
                  for (var option in PaymentType.values.where((e) => ![
                        PaymentType.wechat,
                        PaymentType.alipay,
                        PaymentType.bank,
                        PaymentType.usdt
                      ].contains(e)))
                    Obx(() => GestureDetector(
                        onTap: () {
                          if (controller.payMethods.contains(option.value)) {
                            controller.payMethods.remove(option.value);
                          } else {
                            controller.payMethods.add(option.value);
                          }
                        },
                        child: Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: controller.payMethods.contains(option.value)
                                ? context.appColors.primary
                                : context.appColors.primary.withOpacity(.1),
                          ),
                          child: Text(
                            option.text,
                            style: TextStyle(
                              color:
                                  controller.payMethods.contains(option.value)
                                      ? Colors.white
                                      : context.appColors.text1,
                            ),
                          ),
                        )))
                ],
              ),
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.payMethods.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.confirmOptions();
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
