import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/app/widgets/trade_orders_tab.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';

import '../controllers/acceptance_controller.dart';
import '../controllers/all_order_controller.dart';
import '../controllers/canceled_order_controller.dart';
import '../controllers/complete_order_controller.dart';
import '../controllers/ongoing_order_controller.dart';

class AcceptanceView extends GetView<AcceptanceController> {
  const AcceptanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        shadow: true,
        isRootNavigator: true,
        titleWidget: Text(
          '交易'.tr,
          style: TextStyle(
            color: const Color(0xff3C4E52),
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("可用余额".tr,
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff666666),
                        )),
                    SizedBox(width: 4.w),
                    Obx(() => GestureDetector(
                          onTap: () {
                            controller.showAssets.toggle();
                          },
                          child: Icon(
                            controller.showAssets.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: context.appColors.text4,
                            size: 15.w,
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.INCOME_RECORD_PAGE);
                      },
                      child: Text(
                        ' ${'更多'.tr} >',
                        style: TextStyle(
                          color: const Color(0xFFF6C944),
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Text(
                        "${controller.showAssets.value ? (ApplicationController.to.assets.value?.money ?? '0') : '----'}",
                        style: TextStyle(
                          fontSize: 29.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ))),
                  ],
                ),
                // Obx(
                //   () => Text(
                //       '冻结交易金额：${controller.showAssets.value ? (ApplicationController.to.assets.value?.deposit ?? '0') : '----'}',
                //       style: TextStyle(
                //         fontSize: 17.sp,
                //         color: const Color(0xff666666),
                //       )),
                // ),
                Row(
                  children: [
                    Text(
                      '${'今日收益'.tr}：',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: const Color(0xff666666),
                      ),
                    ),
                    Obx(() => Text(
                          '${controller.showAssets.value ? (ApplicationController.to.assets.value?.todayEarnings ?? '0') : '----'}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: const Color(0xff04C2AD),
                          ),
                        )),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 161.w,
                  height: 32.w,
                  child: Obx(() => ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.RECEIVE_SETTING, arguments: {
                            'type': PaySide.buy,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                UserService.to.user.value.payReceivingOrders ==
                                        1
                                    ? context.appColors.green
                                    : const Color(0xff48484a),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        child: Text(
                            UserService.to.user.value.payReceivingOrders == 1
                                ? '${'买币'.tr}(${'匹配中'.tr})'
                                : '买币'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: UserService
                                          .to.user.value.payReceivingOrders ==
                                      1
                                  ? context.appColors.text1
                                  : const Color(0xffF6C944),
                            )),
                      )),
                ),
                SizedBox(
                  width: 161.w,
                  height: 32.w,
                  child: Obx(() => ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.RECEIVE_SETTING, arguments: {
                            'type': PaySide.sell,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                UserService.to.user.value.receivingOrders == 1
                                    ? context.appColors.green
                                    : const Color(0xff48484a),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            )),
                        child: Text(
                            UserService.to.user.value.receivingOrders == 1
                                ? '${'卖币'.tr}(${'匹配中'.tr})'
                                : '卖币'.tr,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  UserService.to.user.value.receivingOrders == 1
                                      ? context.appColors.text1
                                      : const Color(0xffF6C944),
                            )),
                      )),
                ),
              ],
            ),
            SizedBox(height: 17.w),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("交易订单"),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    child: TradeOrdersTab(
                        labelPadding: EdgeInsets.only(right: 15.w),
                        controller: controller.tabController),
                  )),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     const Text("开启接单"),
                  //     SizedBox(width: 6.w),
                  //     Obx(() => FlutterSwitch(
                  //           width: 39.w,
                  //           height: 20.w,
                  //           padding: 1,
                  //           // valueFontSize: 12.0,
                  //           toggleSize: 20.w,
                  //           activeColor: const Color(0xff48484a),
                  //           inactiveColor: const Color(0xffdadada),
                  //           activeToggleColor: context.appColors.primary,
                  //           value:
                  //               UserService.to.user.value.receivingOrders == 1,
                  //           onToggle: (val) {
                  //             controller.acceptSwitch(val);
                  //           },
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(height: 17.w),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  buildAllList(Get.find<AcceptanceAllOrderController>()),
                  buildAllList(Get.find<AcceptanceOngoingOrderController>()),
                  buildAllList(Get.find<AcceptanceCompleteOrderController>()),
                  buildAllList(Get.find<AcceptanceCanceledOrderController>()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAllList(PagingMixin<TradeDetail> c) {
    return SpeedyPagedList<TradeDetail>.separator(
      controller: c,
      refreshOnStart: true,
      locatorMode: true,
      emptyWidget: const EmptyList(),
      itemBuilder: (context, index, item) {
        return OrderItem(key: ValueKey(item), data: item);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem extends HookWidget {
  const OrderItem({super.key, required this.data});

  final TradeDetail data;

  @override
  Widget build(BuildContext context) {
    var detailX = useState(data);
    var detail = detailX.value;
    useEffect(() {
      if ([2, 3, 4].contains(detail.state)) {
        return null;
      }
      var pub = AppService.bus.on<TradeEvent>().listen((event) async {
        if (event.tradeId != detail.id) {
          return;
        }
        final res = await NetRepository.client.tradeDetail(event.tradeId);
        if (res.code == 0) {
          detailX.value = res.data;
        }
      });
      return pub.cancel;
    }, []);
    Color color;
    Text text;
    if (detail.state == 3) {
      color = context.appColors.primary;
      text = Text(
        '已完成',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff48484A),
        ),
      );
    } else if (detail.state == 4 || detail.state == 5) {
      color = const Color(0xffdedede);
      text = Text('已取消',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff999999),
          ));
    } else {
      color = const Color(0xff48484a);
      text = Text(
        detail.stateDesc,
        style: TextStyle(
          fontSize: 14.sp,
          color: context.appColors.primary,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.ORDER_DETAIL, arguments: {
          'id': detail.id,
        });
      },
      child: Container(
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 14.sp, color: context.appColors.text4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        detail.type == 1 ? '买入' : '卖出',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              Color(detail.type == 1 ? 0xff09C3AF : 0xffF6465D),
                        ),
                      ),
                      10.w.hb,
                      Text(
                        formatDateTime(detail.CreatedAt ?? ''),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 63.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: color),
                    child: text,
                  )
                ],
              ),
              SizedBox(height: 7.w),
              _Line(
                  title: detail.type == 1 ? '购买'.tr : '出售'.tr,
                  content: Config.coinName),
              _Line(title: '数量', content: '${detail.number}'),
              // _Line(title: '单价', content: '₹${detail.price}'),
              _Line(title: '总金额', content: '₹${detail.amount}'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('支付方式'),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          PaymentType.fromValue(detail.payMethod!).text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: detail.paymentState == 1
                                ? const Color(0xffD81E06)
                                : Colors.black,
                          ),
                        ),
                        Visibility(
                          visible: detail.paymentState == 1,
                          child: const Icon(
                            Icons.info_outline,
                            size: 12,
                            color: Color(0xffD81E06),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              _Line(title: '备注码', content: detail.remarkCode ?? ''),
              SizedBox(height: 9.w),
            ],
          ),
        ),
      ),
    );
  }
}
