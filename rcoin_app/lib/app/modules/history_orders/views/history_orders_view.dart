import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/merchant/views/merchant_view.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/app/widgets/order_sides_tab.dart';
import 'package:otc_app/app/widgets/trade_orders_tab.dart';
import 'package:otc_app/models/trade_detail.dart';

import '../controllers/all_order_controller.dart';
import '../controllers/canceled_order_controller.dart';
import '../controllers/complete_order_controller.dart';
import '../controllers/ongoing_order_controller.dart';
import '../controllers/history_orders_controller.dart';

class HistoryOrdersView extends GetView<HistoryOrdersController> {
  const HistoryOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context, '订单管理'.tr),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16.w, top: 8.w),
            child: OrderSidesTab(
              onTap: (int index) {
                AppService.bus.fire(TradeSideEvent(index == 0 ? 1 : 2));
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16.w, top: 15.w),
            child: TradeOrdersTab(
                labelPadding: EdgeInsets.only(right: 15.w),
                controller: controller.tabController),
          ),
          10.w.vb,
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: [
              buildAllList(Get.find<AllOrderController>(
                tag: 'history',
              )),
              buildAllList(Get.find<OngoingOrderController>(
                tag: 'history',
              )),
              buildAllList(Get.find<CompleteOrderController>(
                tag: 'history',
              )),
              buildAllList(Get.find<CanceledOrderController>(
                tag: 'history',
              )),
            ],
          ))
        ],
      ),
    );
  }

  buildAllList(PagingMixin<TradeDetail> c) {
    return SpeedyPagedList<TradeDetail>.separator(
      controller: c,
      padding: const EdgeInsets.symmetric(horizontal: 20).w,
      refreshOnStart: true,
      locatorMode: true,
      emptyWidget: const EmptyList(),
      itemBuilder: (context, index, item) {
        return OrderItem(data: item);
      },
      separatorBuilder: (context, index) => 16.w.vb,
    );
  }

  PreferredSize _headerView(BuildContext context, String title) {
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
                child: Icon(Icons.arrow_back_ios,
                    size: 16, color: Config.kTheme!.text1),
              ),
            ),
            Text(
              title,
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
            )
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Divider(),
    );
  }
}
