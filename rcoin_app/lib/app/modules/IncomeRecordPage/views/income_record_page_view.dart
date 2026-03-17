import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/tab_indicator.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/income_statistics.dart';

import '../controllers/income_record_page_controller.dart';

class IncomeRecordPageView extends GetView<IncomeRecordPageController> {
  const IncomeRecordPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              CustomImage(
                Assets.incomeBg,
                width: Get.width,
              ),
              Expanded(child: Container())
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AAppBar(
            backgroundColor: Colors.transparent,
            title: '收益记录'.tr,
          ),
          body: Container(
            padding: const EdgeInsets.all(20).w,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Text('今日'.tr),
                    Text('昨日'.tr),
                  ],
                  onTap: (int index) {
                    if (controller.tabController.previousIndex == index) {
                      return;
                    }
                    controller.fetchData(
                        day: index == 0 ? 'today' : 'yesterday');
                  },
                  labelStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  labelColor: Colors.white,
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                  unselectedLabelColor: Colors.white,
                  controller: controller.tabController,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: CustomUnderlineDecoration(
                    borderSide: BorderSide(color: Colors.white, width: 1.w),
                    width: 10.w,
                  ),
                ),
                7.w.vb,
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20).w,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${'今日收益'.tr}()',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12.sp,
                        ),
                      ),
                      10.w.vb,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => Text(
                                '+${controller.data.value.tradeFinishAmount}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFFFF0000),
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ))
                        ],
                      ),
                      27.w.vb,
                      Obx(() => Text(
                            '${'进行中订单'.tr}  ￥${controller.data.value.tradingAmount}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() => ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 18.w),
                      itemBuilder: (BuildContext context, int index) =>
                          _IncomeItem(
                              data: controller
                                  .data.value.ctcTradeStatistic!.where(
                                      (e) => e?.payMethod != PaymentType.usdt.value).toList()[index]!),
                      separatorBuilder: (BuildContext context, int index) =>
                          22.w.vb,
                      itemCount: controller.data.value.ctcTradeStatistic
                              ?.where(
                                  (e) => e?.payMethod != PaymentType.usdt.value)
                              .length ??
                          0)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IncomeItem extends StatelessWidget {
  const _IncomeItem({super.key, required this.data});

  final TradeCtcTradeStatisticByPayment data;

  @override
  Widget build(BuildContext context) {
    final paymentType = PaymentType.fromValue(data.payWay!);
    final paymentIcon = paymentType.icon;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.INCOME_RECORD_DETAIL_PAGE, arguments: {
          'day': Get.find<IncomeRecordPageController>().tabController.index == 0
              ? DateTime.now().format(format: 'yyyy-MM-dd')
              : DateTime.now()
                  .subtract(const Duration(days: 1))
                  .format(format: 'yyyy-MM-dd'),
          'paymentType': data.payMethod,
        });
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, top: 11, right: 11, bottom: 17).w,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImage(
                      paymentIcon,
                      width: 22.w,
                    ),
                    8.w.hb,
                    Text(
                      '${data.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Opacity(
                  opacity: 0.40,
                  child: Text(
                    '>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            29.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '代收金额'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${data.receiveAmount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '代付金额'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${data.payAmount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '总收益'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '${data.totalAmount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
