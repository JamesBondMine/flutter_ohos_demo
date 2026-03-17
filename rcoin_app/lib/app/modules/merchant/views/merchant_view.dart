import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/all_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/canceled_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/complete_order_controller.dart';
import 'package:otc_app/app/modules/merchant/controllers/ongoing_order_controller.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/app/widgets/trade_orders_tab.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/services/user.dart';

import '../controllers/merchant_controller.dart';

class MerchantView extends GetView<MerchantController> {
  const MerchantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        shadow: true,
        isRootNavigator: true,
        titleWidget: Text(
          '商户',
          style: TextStyle(
            color: const Color(0xff3C4E52),
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.w),
            const _Card(),
            SizedBox(height: 14.w),
            // const _Buttons(),
            // SizedBox(height: 14.w),
            Container(
              padding: EdgeInsets.only(left: 10.w),
              alignment: Alignment.centerLeft,
              child: TradeOrdersTab(controller: controller.tabController),
            ),
            const _Divider(),
            Expanded(
                child: Container(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  buildAllList(Get.find<AllOrderController>()),
                  buildAllList(Get.find<OngoingOrderController>()),
                  buildAllList(Get.find<CompleteOrderController>()),
                  buildAllList(Get.find<CanceledOrderController>()),
                ],
              ),
            ))
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
        return OrderItem(data: item);
      },
      separatorBuilder: (context, index) => const Divider(),
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
        if (detail.id != event.tradeId) {
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
        '已完成'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Config.kTheme!.text1,
        ),
      );
    } else if (detail.state == 4 || detail.state == 5) {
      color = const Color(0xffdedede);
      text = Text('已取消'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Config.kTheme!.text1,
          ));
    } else {
      color = const Color(0xff48484a);
      text = Text(
        detail.stateDesc,
        style: TextStyle(
          fontSize: 14.sp,
          color: Config.kTheme!.text1,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    if (detail.appealState == 1) {
      color = const Color(0xffF75D71);
      text = Text(
        "申诉中".tr,
        style: TextStyle(
          fontSize: 14.sp,
          color: Config.kTheme!.text1,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    //我是买方还是卖方
    final int buyerUid =
        (detail.type! == 1) ? detail.userId! : detail.orderUserId!;
    bool isBuyer = UserService.to.user.value.id == buyerUid;
    isBuyer = detail.type == 2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.ORDER_DETAIL, arguments: {
          'id': detail.id,
        });
      },
      child: Container(
        width: Get.width - 32,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: Config.kTheme!.bg1,
        ),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 14.sp, color: context.appColors.text4),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'RSO ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Config.kTheme!.text1,
                    ),
                  ),
                  CustomImage(
                    isBuyer ? Assets.homeBuy : Assets.homeSell,
                    width: 20.w,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    alignment: Alignment.center,
                    child: text,
                  )
                ],
              ),
              SizedBox(height: 7.w),
              _Line(title: '数量'.tr, content: '${detail.number}'),
              _Line(title: '总金额'.tr, content: '₹${detail.amount}'),
              _paymentCell('支付方式'.tr, detail),
              _Line(title: '订单号'.tr, content: detail.orderSn ?? ''),
              _Line(
                  title: '创建时间'.tr,
                  content: formatDateTime(detail.CreatedAt ?? '')),
              SizedBox(height: 9.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentCell(String title, TradeDetail detail) {
    return Container(
      padding: EdgeInsets.only(top: 12.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
          ),
          CustomImage(
            "${pts["${detail.payMethod}"]}",
            color: Config.kTheme!.text2,
          ),
        ],
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

class _Line extends StatelessWidget {
  const _Line({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.w, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
          ),
          Text(
            content,
            style: TextStyle(
              color: Config.kTheme!.text1,
            ),
          ),
        ],
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
      child: const Divider(),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 161.w,
            height: 32.w,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.POST_BUY_ORDER);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff48484a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
              child: Text("买币".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primary,
                  )),
            ),
          ),
          SizedBox(
            width: 161.w,
            height: 32.w,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.POST_SELL_ORDER);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff48484a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
              child: Text("卖币".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primary,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends GetView<MerchantController> {
  const _Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: context.appColors.primary, fontSize: 12.sp),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 17.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          color: const Color(0xff48484a),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '我的余额'.tr,
                      style: TextStyle(fontSize: 14.w),
                    ),
                    SizedBox(width: 4.w),
                    Obx(() => GestureDetector(
                          onTap: () {
                            controller.showAssets.toggle();
                          },
                          child: Icon(
                            controller.showAssets.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: context.appColors.primary,
                            size: 15.w,
                          ),
                        ))
                  ],
                ),
                Icon(
                  Icons.info_outline,
                  color: context.appColors.primary,
                  size: 15.w,
                ),
              ],
            ),
            SizedBox(height: 6.w),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text:
                          '${controller.showAssets.value ? (ApplicationController.to.assets.value?.money ?? '0') : '----'}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: 2.w)),
                    TextSpan(
                      text: Config.coinName,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    )
                  ])),
                  Text(
                    '${controller.showAssets.value ? (ApplicationController.to.assets.value?.yesterdayEarnings ?? '0') : '--'} 昨日收益',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 6.w),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '≈${controller.showAssets.value ? (ApplicationController.to.assets.value!.money! * AppService.to.rPrice).toPrecision(2) ?? '0' : '----'}USDT'),
                    Text(
                        '${controller.showAssets.value ? ApplicationController.to.assets.value?.todayEarnings ?? '0' : '--'} 今日收益'),
                  ],
                )),
            SizedBox(height: 8.w),
          ],
        ),
      ),
    );
  }
}
