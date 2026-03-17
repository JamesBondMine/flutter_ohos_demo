import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/views/payment_info.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';

import 'order_detail_view.dart';

class OrderCanceled extends StatelessWidget {
  const OrderCanceled({super.key, required this.state});

  final TradeDetail state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      // appBar: const AAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
              child: SingleChildScrollView(
            child: Column(
              children: [
                _cancelUser(),
                SizedBox(height: 10.w),
                _cancelSaller(),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _cancelSaller() {
    String payTypePath =
        pts["${state.ctcTradePay!.payType.value}"] ?? Assets.orderPpment1;
    return Container(
        padding:
            EdgeInsets.only(bottom: 15.w, left: 15.w, right: 15.w, top: 20.2),
        width: Get.width - 32,
        decoration: BoxDecoration(
            color: Config.kTheme!.bg1,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (state.type == 1 ? '卖家' : '买家').tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Config.kTheme!.text1,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '支付方式'.tr,
                    style:
                        TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                  ),
                  CustomImage(
                    payTypePath,
                    height: 20.w,
                    color: Config.kTheme!.text2,
                  ),
                ],
              ),
            ),
            PaymentInfo(payment: state.ctcTradePay!)
          ],
        ));
  }

  Map<String, dynamic> get pts => {
        "5": Assets.orderPpment1,
        "6": Assets.orderPpment2,
        "7": Assets.orderPpment3,
        "8": Assets.orderPpment4,
        "9": Assets.orderPpment5,
        "10": Assets.orderPpment6,
        // 默认
        "1": Assets.orderPpment1,
        "2": Assets.orderPpment1,
        "3": Assets.orderPpment1,
        "4": Assets.orderPpment1
      };

  Widget _cancelUser() {
    return Container(
      padding: EdgeInsets.only(bottom: 15.w),
      width: Get.width - 32,
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          _cancleHeader(),
          SizedBox(height: 20.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.sp,
                color: Config.kTheme!.text1,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (state.type == 1 ? '购买' : '卖出').tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                  20.w.vb,
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '订单号'.tr,
                          style: TextStyle(
                              fontSize: 14.sp, color: Config.kTheme!.text2),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${state.orderSn}',
                              style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                  ),
                            ),
                            CopyBtn(text: state.orderSn!, size: 10.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '金额'.tr,
                          style: TextStyle(
                              fontSize: 14.sp, color: Config.kTheme!.text2),
                        ),
                        Text(
                          '${state.number}₹',
                          style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '总金额'.tr,
                          style: TextStyle(
                              fontSize: 14.sp, color: Config.kTheme!.text2),
                        ),
                        Text(
                          '${state.ctcTradePay!.payType == PaymentType.usdt ? state.usdtAmount : state.amount}',
                          style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '备注码'.tr,
                          style: TextStyle(
                              fontSize: 14.sp, color: Config.kTheme!.text2),
                        ),
                        Text(
                          '${(state.remarkCode)}',
                          style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cancleHeader() {
    return Container(
      width: Get.width - 32,
      height: 58.w,
      // margin: EdgeInsets.only(left: 16.w),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Color(0xff3C3832),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 226, 205, 178),
            Color(0xffD1B593),
          ])),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 19.sp,
          fontWeight: FontWeight.bold,
          color: Config.kTheme!.text2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '订单已取消'.tr,
              style: TextStyle(color: Config.kTheme!.bgw),
            ),
            Text('₹${state.amount}',
                style: TextStyle(color: Config.kTheme!.bgw)),
          ],
        ),
      ),
    );
  }
}

class CancelAndAppeal extends StatelessWidget {
  const CancelAndAppeal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, -4),
          blurRadius: 12,
          color: Colors.black.withOpacity(0.05),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 156.w,
            height: 38.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  )),
              onPressed: () {},
              child: Text(
                '取消订单'.tr,
                style: style33.copyWith(
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            height: 38.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  )),
              onPressed: () {},
              child: Text(
                '申诉'.tr,
                style: style33.copyWith(
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemindOrder extends StatelessWidget {
  const RemindOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17.w),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 80.w,
        height: 30.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
          ),
          onPressed: () {},
          child: Text(
            '催单'.tr,
            style: style00Bold.copyWith(
              fontSize: 17.sp,
            ),
          ),
        ),
      ),
    );
  }
}
