import 'package:cached_network_image/cached_network_image.dart';
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

class TradeChildView extends StatefulWidget {
  TradeChildView({Key? key, required this.side}) : super(key: key);

  final PaySide side;

  @override
  State<StatefulWidget> createState() {
    return TradeChildViewState();
  }
}

class TradeChildViewState extends State<TradeChildView> {
  BuyOrdersController _buyOrdersController = BuyOrdersController();

  SaleOrdersController _saleOrdersController = SaleOrdersController();

  PaySide side = PaySide.buy;

  @override
  void initState() {
    side = widget.side;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.all(12).w,
            padding: const EdgeInsets.symmetric(vertical: 6).w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).r,
              // color: Colors.white,
            ),
            child: const FilterBar(),
          ),
          // SizedBox(height: 16.w),
          // const _Select(),
          Expanded(
            child: _bodyview(),
            // child: GetBuilder<TradeController>(
            //     id: TradeController.to.tradeChildRefreshId,
            //     builder: (v) {
            //       return _bodyview();
            //     }),
          )
        ],
      ),
    );
  }

  Widget _bodyview() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6).w,
          child: side == PaySide.sell
              ? SpeedyPagedList<PublishOrder>.separator(
                  controller: _saleOrdersController,
                  refreshOnStart: true,
                  locatorMode: true,
                  emptyWidget: const EmptyList(),
                  itemBuilder: (context, index, item) {
                    return _PublishOrder(order: item);
                  },
                  separatorBuilder: (context, index) => 16.w.vb,
                )
              : SpeedyPagedList<PublishOrder>.separator(
                  controller: _buyOrdersController,
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
              visible: TradeController.to.filterIndex.value != null,
              child: Column(
                children: [
                  buildFilterOption(),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        TradeController.to.filterIndex.value = null;
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
    );
  }

  Widget buildFilterOption() {
    if (TradeController.to.filterIndex.value == 0) {
      return _CooperateFilter(
        confirm: (int value) {
          if (side == PaySide.buy) {
            _buyOrdersController.filters.cooperated = value;
            _buyOrdersController.fetchData(0);
            return;
          }
          _saleOrdersController.filters.cooperated = value;
          _saleOrdersController.fetchData(0);
        },
      );
    }
    if (TradeController.to.filterIndex.value == 1) {
      return NumberFilterOption(
        currentValue: OrderFilterController.to.filterMin.value ?? 0,
        options: [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          TradeController.to.filterIndex.value = null;
          OrderFilterController.to.filterMin.value = value;
          OrderFilterController.to.confirmOptions();
          if (side == PaySide.buy) {
            _buyOrdersController.filters.minAmount = value;
            _buyOrdersController.fetchData(0);
            return;
          }
          _saleOrdersController.filters.minAmount = value;
          _saleOrdersController.fetchData(0);
        },
      );
    }
    if (TradeController.to.filterIndex.value == 2) {
      return NumberFilterOption(
        currentValue: Get.find<OrderFilterController>().filterMax.value,
        options: [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          TradeController.to.filterIndex.value = null;
          Get.find<OrderFilterController>().filterMax.value = value;
          Get.find<OrderFilterController>().confirmOptions();

          if (side == PaySide.buy) {
            _buyOrdersController.filters.maxAmount = value;
            _buyOrdersController.fetchData(0);
            return;
          }
          _saleOrdersController.filters.maxAmount = value;
          _saleOrdersController.fetchData(0);
        },
      );
    }
    if (TradeController.to.filterIndex.value == 3) {
      return _PaymentTypeFilter(confirm: (value) {
        if (side == PaySide.buy) {
          _buyOrdersController.filters.paymentMethods = value;
          _buyOrdersController.fetchData(0);
          return;
        }
        _saleOrdersController.filters.paymentMethods = value;
        _saleOrdersController.fetchData(0);
      });
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
        borderRadius: BorderRadius.circular(12).r,
        color: Config.kTheme!.bg1,
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
              Container(
                width: 30.w,
                height: 30.w,
                margin: EdgeInsets.only(right: 10.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.fromBorderSide(
                        BorderSide(color: Config.kTheme!.line, width: 0.8))),
                child: Text(
                  "₹",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Config.kTheme!.text1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 商家ID
                  Row(
                    children: [
                      ClipOval(
                        child:
                            order.headerImg == null || order.headerImg!.isEmpty
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    color: Config.kTheme!.text2,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: order.headerImg!,
                                    width: 20,
                                    height: 20,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        width: 20,
                                        height: 20,
                                        color: Config.kTheme!.text2,
                                      );
                                    },
                                  ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "ID:${order.userId}",
                        style: TextStyle(
                            color: Config.kTheme!.text1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "L${order.level}",
                        style: TextStyle(
                            color: Config.kTheme!.text1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  6.w.vb,
                  Text(
                    "${'剩余金额 '.tr}:\n${order.surplusNumber} RSO",
                    style: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  6.w.vb,
                  Text(
                    'limit ₹${order.minMoney} - ₹${order.maxMoney}',
                    style: TextStyle(
                      color: Config.kTheme!.text2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "${order.nickName}",
                        style: TextStyle(
                            fontSize: 11.sp, color: Config.kTheme!.text2)),
                    TextSpan(
                        text:
                            " ${"成单量".tr} ${order.transactionCount} |\n${"成单率".tr} ${order.closeRate}%",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Config.kTheme!.text2,
                        ))
                  ])),
                  SizedBox(height: 5.w),
                  _payment(order),
                  SizedBox(height: 6.w),
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
                      child: Row(
                        children: [
                          CustomImage(
                            Assets.ordertime1,
                            color: Config.kTheme!.text2,
                          ),
                          3.w.hb,
                          Text(
                            '${order.transactionDuration}',
                            style: TextStyle(color: Config.kTheme!.text2),
                          ),
                          Text(
                            '分钟'.tr,
                            style: TextStyle(color: Config.kTheme!.text2),
                          ),
                        ],
                      ),
                    ),
                    AppButton(
                      width: 63.w,
                      height: 28.w,
                      titleStyle: const TextStyle(color: Colors.white),
                      title:
                          order.type == PaySide.sell.value ? '购买'.tr : '出售'.tr,
                      backgroundColor: order.type == PaySide.sell.value
                          ? const Color(0xff2abf5b)
                          : const Color(0xffe73463),
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

  Widget _payment(PublishOrder order) {
    List<Widget> children = [];
    List<String> methods = order.payMethod.split(",");
    for (var i = 0; i < methods.length; i++) {
      children.add(Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: CustomImage(
          pts["${methods[i]}"],
          height: 20.w,
          color: Config.kTheme!.text2,
        ),
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: children,
      ),
    );
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
  late TextEditingController textEditcontroller;

  @override
  void initState() {
    textEditcontroller =
        TextEditingController(text: widget.currentValue?.toString() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    textEditcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Color(0xff232323),
        padding:
            EdgeInsets.only(left: 31.w, top: 20.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            TextField(
              controller: textEditcontroller,
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
                        textEditcontroller.text =
                            removeTrailingZeros(option.$2.toString());
                      },
                      child: Container(
                        width: (Get.width - 75.w) / 3,
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
                  height: 40.w,
                  onPressed: () {
                    textEditcontroller.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 40.w,
                  onPressed: () {
                    widget.onConfirm(
                      (textEditcontroller.isBlank ?? true)
                          ? null
                          : double.tryParse(textEditcontroller.text),
                    );
                  },
                  backgroundColor: Config.kTheme!.bgbtn,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Config.kTheme!.text1,
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
  _CooperateFilter({super.key, required this.confirm});

  final ValueChanged<int> confirm;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Color(0xff232323),
        padding:
            EdgeInsets.only(left: 31.w, top: 20.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("有过合作用户".tr,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
                GestureDetector(
                  onTap: () {
                    OrderFilterController.to.cooperation.toggle();
                  },
                  child: Obx(() => OrderFilterController.to.cooperation.value
                      ? Icon(
                          Icons.check_circle_outline_outlined,
                          size: 20.w,
                          color: Config.kTheme!.text2,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          size: 20.w,
                          color: Color(0xffC1C1C1),
                        )),
                ),
              ],
            ),
            24.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 40.w,
                  onPressed: () {
                    confirm(0);
                    OrderFilterController.to.cooperation.value = false;
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 40.w,
                  onPressed: () {
                    confirm(1);
                    OrderFilterController.to.confirmOptions();
                  },
                  backgroundColor: Config.kTheme!.bgbtn,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Config.kTheme!.text1,
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
  _PaymentTypeFilter({super.key, required this.confirm});

  final ValueChanged<List<int>> confirm;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Color(0xff232323),
        padding:
            EdgeInsets.only(left: 31.w, top: 20.w, right: 31.w, bottom: 17.w),
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
                          if (OrderFilterController.to.payMethods
                              .contains(option.value)) {
                            OrderFilterController.to.payMethods
                                .remove(option.value);
                          } else {
                            OrderFilterController.to.payMethods
                                .add(option.value);
                          }
                        },
                        child: Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: OrderFilterController.to.payMethods
                                    .contains(option.value)
                                ? Colors.white
                                : Colors.white.withOpacity(0.8),
                          ),
                          child: Text(
                            option.text,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )))
                ],
              ),
            ),
            24.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 40.w,
                  onPressed: () {
                    confirm([]);
                    OrderFilterController.to.payMethods.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 40.w,
                  onPressed: () {
                    // ignore: invalid_use_of_protected_member
                    confirm(OrderFilterController.to.payMethods.value);
                    OrderFilterController.to.confirmOptions();
                  },
                  backgroundColor: Config.kTheme!.bgbtn,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Config.kTheme!.text1,
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
