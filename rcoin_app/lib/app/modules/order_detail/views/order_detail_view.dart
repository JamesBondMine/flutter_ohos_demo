import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/appeal/views/appeal_view.dart';
import 'package:otc_app/app/modules/order_detail/views/complete_view.dart';
import 'package:otc_app/app/modules/order_detail/views/order_canceled.dart';
import 'package:otc_app/app/modules/order_detail/views/wait_confirm_seller.dart';
import 'package:otc_app/app/modules/order_detail/views/wait_order_buyer.dart';
import 'package:otc_app/app/modules/order_detail/views/wait_pay_buyer.dart';
import 'package:otc_app/app/modules/order_detail/views/wait_pay_seller.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/order_detail_controller.dart';
import 'wait_confirm_buyer.dart';
import 'wait_order_seller.dart';
import 'appeal_order_view.dart';

final TextStyle style33 =
    TextStyle(fontSize: 14.sp, color: const Color(0xff333333));

final TextStyle style66 =
    TextStyle(fontSize: 14.sp, color: const Color(0xff666666));

final TextStyle style99 =
    TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2);

final TextStyle style00Bold = TextStyle(
  fontSize: 14.sp,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        appBar: _headerView(context),
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Config.kTheme!.bgMain,
          child: controller.obx((state) {
            if (state?.appealState == 1) {
              return AppealOrderView(detail: state!);
            }
            //我是买方还是卖方
            final int buyerUid =
                (state!.type! == 1) ? state.userId! : state.orderUserId!;
            final bool isBuyer = UserService.to.user.value.id == buyerUid;

            //发广告单方需要确认
            if (state.state == 0) {
              if (state.orderUserId == UserService.to.user.value.id) {
                return WaitOrderSeller(state: state);
              } else {
                return WaitOrderBuyer(state: state);
              }
            }
            return switch ((isBuyer, state.state!)) {
              (true, 1) => WaitPayBuyer(state: state), //待付款
              (false, 1) => WaitPaySeller(state: state), //待付款

              (true, 2) => WaitConfirmBuyer(state: state), //已付款/待确认
              (false, 2) => WaitConfirmSeller(state: state), //已付款/待确认

              (true, 3) => CompleteTipView(state: state), //完成
              (false, 3) => CompleteTipView(state: state), //完成

              (true, 4) => OrderCanceled(state: state), //取消
              (false, 4) => OrderCanceled(state: state), //取消
              (_, 5) => OrderCanceled(state: state), //取消

              _ => Container(),
            };

            // return CompleteView(state: state);
          },
              onError: (String? errorMsg) => Scaffold(
                    appBar: _headerView(context),
                    body: Center(child: Text('$errorMsg')),
                  )),
        ));
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: controller.obx((state) {
          final int buyerUid =
              (state!.type! == 1) ? state.userId! : state.orderUserId!;
          final bool isBuyer = UserService.to.user.value.id == buyerUid;
          if (state.appealState == 1) {
            controller.orderTitle = "申诉中".tr;
          } else {
            switch (state.state) {
              case 1:
                controller.orderTitle = isBuyer ? "购买" : "卖出";
                break;
              case 2:
                controller.orderTitle = isBuyer ? "购买" : "";
                break;
              case 3:
                controller.canHelp = false;
                controller.orderTitle = "";
                break;
              case 4:
                controller.canHelp = true;
                controller.orderTitle = isBuyer ? "购买" : "";
                break;
              case 5:
                controller.canHelp = true;
                controller.orderTitle = isBuyer ? "购买" : "";
                break;
              default:
                controller.orderTitle = "";
            }
          }

          controller.updateOrderTitleRefresh();

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8.w),
                  width: 48.w,
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
                controller.orderTitle.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.text1,
                ),
              ),
              !controller.canHelp
                  ? Container(
                      margin: EdgeInsets.only(right: 14.w),
                      width: 48.w,
                      height: 48.w,
                    )
                  : Container(
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
          );
        }),
      ),
    );
  }
}

class CancelOrderBtn extends GetView<OrderDetailController> {
  const CancelOrderBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.toNamed(Routes.CONFIRM_CANCEL_ORDER, arguments: {
            'id': controller.id,
          });
          // Get.find<OrderDetailController>().cancelOrder();
        },
        child: Text("取消订单".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.appColors.textPlaceholder,
            )));
  }
}

class GoChatBtn extends GetView<OrderDetailController> {
  const GoChatBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatBtn(
      tradeDetail: controller.state,
    );
  }
}

class AppealOrderBtn extends GetView<OrderDetailController> {
  const AppealOrderBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.toNamed(Routes.APPEAL, arguments: {
            'id': controller.id,
          });
        },
        child: Text("申诉".tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.appColors.textPlaceholder,
            )));
  }
}
