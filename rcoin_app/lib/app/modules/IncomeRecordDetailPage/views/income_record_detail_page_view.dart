import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/widgets/app_bar.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/income_statistics.dart';
import 'package:otc_app/network/response/trade_by_payment.dart';

import '../controllers/income_record_detail_page_controller.dart';

class IncomeRecordDetailPageView
    extends GetView<IncomeRecordDetailPageController> {
  const IncomeRecordDetailPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AAppBar(
        title: '收益明细'.tr,
        shadow: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async{
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(controller.day.value),
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now(),
                      helpText: "请选择日期".tr,
                      cancelText: "取消".tr,
                      confirmText: "确定".tr,
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData(
                              colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: context.appColors.primary,
                              ),
                            ),
                            child: child!);
                      },
                    );
                    if (picked != null) {
                      controller.day.value = picked.format(format: 'yyyy-MM-dd');
                      controller.onRefresh();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Text(
                        controller.day.value,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      )),
                      9.w.hb,
                      Icon(Icons.keyboard_arrow_down,
                          color: context.appColors.textPlaceholder),
                    ],
                  ),
                ),
                Obx(() => Text(
                  '${'收入'.tr} ${controller.total.value.rtz}',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12.sp,
                  ),
                ))
              ],
            ),
            const Divider(),
            Expanded(
                child: SpeedyPagedList<TradeCtcTradeByPaymentFon>.separator(
                  controller: controller,
                  refreshOnStart: true,
                  locatorMode: true,
                  emptyWidget: const EmptyList(title: '',),
                  itemBuilder: (context, index, item) {
                    return _Item(key: ValueKey(item), data: item);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ))
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.data});

  final TradeCtcTradeByPaymentFon data;

  @override
  Widget build(BuildContext context) {
    PaymentType paymentType = PaymentType.fromValue(data.payMethod);
    return Column(
      children: [
        12.w.vb,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '+${data.amount.rtz}',
              style: TextStyle(
                color: const Color(0xFFFF0000),
                fontSize: 14.sp,
              ),
            )
          ],
        ),
        13.w.vb,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${'原订单号'.tr}：${data.orderSn}',
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: 14.sp,
              ),
            ),
            Text(
              formatDateTime(data.createdAt),
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 12.sp,
              ),
            )
          ],
        )
      ],
    );
  }
}
