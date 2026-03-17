import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_buy_view.dart';
import 'package:otc_app/app/modules/post_order/views/post_order_sell_view.dart';
import 'package:otc_app/app/widgets/button.dart';
import '../controllers/post_order_controller.dart';

class PostOrderPage extends GetView<PostOrderController> {
  const PostOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sellerView(context),
            Padding(
                padding: EdgeInsets.only(bottom: 10.w, top: 20),
                child: Text(
                  'explain'.tr,
                  style: TextStyle(
                    color: Config.kTheme!.text1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: Text(
                  '1. After selecting the type of pending order, please enter the buying and selling amount according to the requirements, with the lowest highest buying value per order. 2. You can choose to terminate the pending order midway, and the remaining unsold amount will be returned to your account When posting a sell order, please pay attention to whether the wallet balance is sufficient to support the amount of the pending order If the transaction is not completed, the amount of the sell order will be returned to the remaining quantity of the current pending order. If the sell order is successfully published, the amount sold will be temporarily frozen, and terminating the pending order can unfreeze it After successful publication, please pay attention to the system message and take timely action. If the timeout occurs, the order will be automatically cancelled During the transaction process, please check the fund collection status of the receiving account to prevent scammers'
                      .tr,
                  style: TextStyle(
                    color: Config.kTheme!.text2,
                    fontSize: 13.sp,
                  ),
                )),
          ],
        )),
      )),
    );
  }

  Widget _sellerView(BuildContext context) {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20, left: 10),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10.w, right: 10),
              child: Text(
                'Please choose'.tr,
                style: TextStyle(
                  color: Config.kTheme!.text1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                bottom: 30.w,
              ),
              child: Text(
                'Types of pending orders to be published'.tr,
                style: TextStyle(
                  color: Config.kTheme!.text2,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
          AppButton(
            width: Get.width - 52,
            height: 52.w,
            radius: 8.w,
            onPressed: () async {
              Get.off(const PostOrderSellView());
            },
            title: 'Sell order'.tr,
          ),
          16.w.vb,
          AppButton(
            width: Get.width - 52,
            height: 52.w,
            radius: 8.w,
            backgroundColor: Colors.transparent,
            // titleStyle: TextStyle(
            //     color: Config.kTheme!.text2,
            //     fontWeight: FontWeight.w500,
            //     fontSize: 16.sp),
            borderSide: BorderSide(
                color: Config.kTheme!.text2.withOpacity(0.5), width: 0.7),
            onPressed: () async {
              Get.off(const PostOrderBuyView());
            },
            title: 'Buy order'.tr,
          ),
        ]));
  }

  _success(BuildContext context) {}

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
              'release'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
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
