import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/controllers/order_detail_controller.dart';
import 'package:otc_app/app/modules/order_detail/views/payment_info.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/common/widgets/count_down.dart';
import 'package:otc_app/models.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/service.dart';

import 'order_detail_view.dart';

class WaitPaySeller extends StatelessWidget {
  const WaitPaySeller({super.key, required this.state});

  final TradeDetail state;

  @override
  Widget build(BuildContext context) {
    PaymentType paymentType = state.ctcTradePay!.payType;
    return Scaffold(
      appBar: const AAppBar(
        actions: [
          GoChatBtn(),
        ],
      ),
      body: SafeArea(
        child: FillRemainWidget(
          topChildren: [
            SizedBox(height: 10.w),
            Container(
              margin: EdgeInsets.only(left: 17.w, right: 18.w),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('等待买家付款'.tr),
                    Text('${Config.coinName}${state.amount}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.w),
            Container(
              margin: EdgeInsets.only(left: 14.w),
              child: Row(
                children: [
                  Text("付款剩余时间：".tr,
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff999999))),
                  SizedBox(width: 10.w),
                  CountDown(
                      seconds: state.countDown!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.primary,
                      )),
                ],
              ),
            ),
            SizedBox(height: 10.w),
            const Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xff666666),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // SvgPicture.asset(
                        //   Assets.imagesUsdt,
                        //   width: 22.w,
                        // ),
                        // 8.w.hb,
                        Text(
                          '${'出售'.tr} ${Config.coinName}',
                          style: TextStyle(
                            color: context.appColors.text1,
                          ),
                        )
                      ],
                    ),
                    16.w.vb,
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('订单号'.tr),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${state.orderSn}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              CopyBtn(text: state.orderSn!, size: 12.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 16.w),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text('单价'),
                    //       Text(
                    //         '${state.price!.rtz}',
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('数量'.tr),
                          Text(
                            '${state.number}${Config.coinName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('总金额'.tr),
                          Text(
                            '${state.ctcTradePay!.payType == PaymentType.usdt ? state.usdtAmount : state.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                          Text('备注码'.tr),
                          Text(
                            '${(state.remarkCode)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
              padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '买家支付方式'.tr,
                    style: style66,
                  ),
                  Row(
                    children: [
                      Container(
                          width: 2,
                          height: 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              color: state.ctcTradePay!.payType.color)),
                      6.w.hb,
                      Text(
                        state.ctcTradePay!.payType.text,
                        style: style00Bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '卖家收款方式'.tr,
                    style: style66,
                  ),
                  Row(
                    children: [
                      Container(
                          width: 2,
                          height: 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              color: state.ctcTradePay!.payType.color)),
                      6.w.hb,
                      Text(
                        state.ctcTradePay!.payType.text,
                        style: style00Bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            12.w.vb,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12.w,
                    )
                  ]),
              child: PaymentInfo(payment: state.ctcTradePay!),
            ),
            const Divider(),
            Visibility(
              visible: state.paymentState == 1,
              child: Container(
                padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '异常原因'.tr,
                      style: style66,
                    ),
                    Text(
                      '无法付款'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 5.w),
              child: Text(
                '温馨提示：如收到款项与交易金额一致，请立即点击“我已确认收款”！切勿相信短信到账通知，请以官方app或网银实时到账为准！'
                    .tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text1,
                ),
              ),
            ),
            20.w.vb,
          ],
          bottomChild: Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: UserService.to.user.value.accountType ==
                      UserType.acceptance &&
                  state.sourceType == 1,
              child: SizedBox(
                width: 315.w,
                height: 38.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w),
                      )),
                  onPressed: () {
                    Get.find<OrderDetailController>().confirmReceipt();
                  },
                  child: Text(
                    '我已确认收款'.tr,
                    style: style00Bold.copyWith(
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
