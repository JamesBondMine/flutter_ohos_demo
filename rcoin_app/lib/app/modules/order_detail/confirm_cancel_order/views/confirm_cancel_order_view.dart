import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/controllers/order_detail_controller.dart';
import 'package:otc_app/app/widgets/button.dart';

import '../controllers/confirm_cancel_order_controller.dart';

class ConfirmCancelOrderView extends GetView<ConfirmCancelOrderController> {
  const ConfirmCancelOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: Color(0xff131313),
                  borderRadius: BorderRadius.circular(8.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12.w,
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Config.kTheme!.text2,
                        size: 18.w,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '温馨提示'.tr,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '1.如果您已经付款给卖家，请勿取消订单'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff9b9b9b),
                              ),
                            ),
                            Text(
                              '2.如因系统超时订单取消，买家将被记责（完成率受影响）。'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff9b9b9b),
                              ),
                            ),
                            Text(
                              '3.如果卖家在15分钟内没有回复聊天，则买家无责，您的成单率将不受影响，一天内只能3次无责取消。'
                                  .tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff9b9b9b),
                              ),
                            ),
                            Text(
                              '4.一天内您最多只能3次有责取消，否则，您的账户将被暂停，并且不能再同一天内再下订单。'.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff9b9b9b),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            72.w.vb,
            AppButton(
              width: 315.w,
              height: 52.w,
              radius: 8,
              onPressed: () {
                Get.find<OrderDetailController>().cancelOrder();
              },
              title: '确认取消'.tr,
            )
          ],
        ),
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Text(
              '取消订单'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: const Color(0xffffffff),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 14.w), width: 48.w, height: 48.w)
          ],
        ),
      ),
    );
  }
}
