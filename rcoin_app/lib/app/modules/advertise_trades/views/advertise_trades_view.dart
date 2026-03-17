import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/views/order_detail_view.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:otc_app/services/user.dart';

import '../controllers/advertise_trades_controller.dart';

class AdvertiseTradesView extends GetView<AdvertiseTradesController> {
  const AdvertiseTradesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: SpeedyPagedList<TradeDetail>.separator(
        padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 10.w),
        controller: controller,
        refreshOnStart: true,
        locatorMode: true,
        emptyWidget: const EmptyList(),
        itemBuilder: (context, index, item) {
          return OrderItem(detail: item);
        },
        separatorBuilder: (context, index) => 16.w.vb,
      ),
    );
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
              '交易记录'.tr,
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

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.detail});

  final TradeDetail detail;

  @override
  Widget build(BuildContext context) {
    final int buyerUid =
        (detail.type! == 1) ? detail.userId! : detail.orderUserId!;
    final bool isBuyer = UserService.to.user.value.id == buyerUid;

    Color color;
    Text text;
    if (detail.state == 3) {
      color = context.appColors.primary;
      text = Text(
        '已完成'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Config.kTheme!.text2,
        ),
      );
    } else if (detail.state == 4) {
      color = const Color(0xffdedede);
      text = Text('已取消'.tr,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Config.kTheme!.text2,
          ));
    } else {
      color = context.appColors.primary;
      text = Text(
        "待付款".tr,
        style: TextStyle(
          fontSize: 14.sp,
          color: Config.kTheme!.bgbtn,
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
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12.w),
        ),
        padding:
            EdgeInsets.only(left: 8.w, right: 10.w, top: 10.w, bottom: 10.w),
        child: DefaultTextStyle(
            style: TextStyle(fontSize: 14.sp, color: context.appColors.text4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  margin: EdgeInsets.only(right: 10.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.fromBorderSide(BorderSide(
                          color: Config.kTheme!.text2.withOpacity(0.5),
                          width: 0.8))),
                  child: Text(
                    "₹",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Config.kTheme!.text1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'数量'.tr}: ${detail.number} RSO",
                      style: TextStyle(
                          color: Config.kTheme!.text1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      "${'总金额'.tr}: ₹${detail.amount}",
                      style: TextStyle(
                          color: Config.kTheme!.text2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.w),
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: CustomImage(
                        pts["${detail.payMethod}"],
                        height: 20.w,
                        color: Config.kTheme!.text2,
                      ),
                    ),
                    SizedBox(height: 9.w),
                  ],
                )),
                SizedBox(
                  width: 80.w,
                  // height: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDateTime(detail.CreatedAt ?? ''),
                        style: TextStyle(
                            color: Config.kTheme!.text2, fontSize: 12.sp),
                      ),
                      SizedBox(height: 20.w),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        // width: 106.w,
                        height: 35.w,
                        alignment: Alignment.center,
                        decoration: detail.state == 4 || detail.state == 3
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(6.w),
                                border: Border.all(
                                    color: Config.kTheme!.text2, width: 0.8))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(6.w),
                                color: color),
                        child: text,
                      )
                    ],
                  ),
                )
              ],
            )),
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
      padding: EdgeInsets.only(top: 6.w, right: 14.w),
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
