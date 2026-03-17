import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/views/payment_info.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/common/widgets/count_down.dart';
import 'package:otc_app/common/widgets/image_view.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';

import '../controllers/order_detail_controller.dart';
import 'order_detail_view.dart';

class WaitConfirmBuyer extends StatelessWidget {
  const WaitConfirmBuyer({super.key, required this.state});

  final TradeDetail state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.w),
                  _buyerView(),
                  _sellerView(),
                  _payTipsView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 付款凭证
  Widget _payTipsView() {
    return Container(
        width: Get.width - 32,
        padding: EdgeInsets.only(top: 16.w, left: 15, bottom: 35),
        margin: EdgeInsets.only(top: 10.w),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 0, right: 10),
                  child: Text(
                    '付款凭证'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          10.w.vb,
          Wrap(
            spacing: 5.w,
            runSpacing: 5.w,
            children: [
              ...List.generate(
                state.imgList.length,
                (index) => ClipRRect(
                  borderRadius: BorderRadius.circular(4).r,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => HeroPhotoViewRouteWrapper(
                            imageProvider: NetworkImage(state.imgList[index]),
                            tag: 'appealImage_$index'),
                        transition: Transition.zoom,
                      );
                    },
                    child: Hero(
                      tag: 'appealImage_$index',
                      child: CustomImage(
                        state.imgList[index],
                        width: 102.w,
                        height: 102.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
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

  Widget _sellerView() {
    String payTypePath =
        pts["${state.ctcTradePay!.payType.value}"] ?? Assets.orderPpment1;
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20.w),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '卖家'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '收款类型'.tr,
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
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              children: [
                Text(
                  '收款账户'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Spacer(),
                Text(
                  '${state.ctcTradePay!.name}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1),
                ),
                CopyBtn(text: state.orderSn!, size: 12.w),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '收款账号'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.ctcTradePay!.account}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26, bottom: 10),
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: CachedNetworkImage(imageUrl: state.ctcTradePay!.img!),
          ),
          Text(
            '收款二维码'.tr,
            style: style99,
          ),
        ]));
  }

  Widget _buyerView() {
    return Container(
        width: Get.width - 32,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          _buyerHeader(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '${'购买'.tr}',
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '订单号'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.orderSn}',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Config.kTheme!.text1,
                      ),
                    ),
                    CopyBtn(text: state.orderSn!, size: 12.w),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '金额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.amount}₹',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '总金额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.ctcTradePay!.payType == PaymentType.usdt ? state.usdtAmount : state.amount}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '备注码'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${(state.remarkCode)}',
                  style: TextStyle(color: Config.kTheme!.text1),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '备注'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                SizedBox(
                  width: Get.width - 160,
                  child: Text(
                    '${(state.remark)}',
                    maxLines: 5,
                    style: TextStyle(color: Config.kTheme!.text1),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget _buyerHeader() {
    return Container(
      width: Get.width - 32,
      height: 132.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
      decoration: const BoxDecoration(
          color: Color(0xff45280F),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          gradient: LinearGradient(colors: [
            Color(0xffF8F2EC),
            Color(0xffAC885B),
            Color(0xffAF9165)
          ])),
      child: Stack(
        children: [
          Positioned.fill(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '等待卖家确认收款'.tr,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff45280F),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '剩余时间 '.tr,
                    style:
                        TextStyle(fontSize: 12.sp, color: Config.kTheme!.text1),
                  ),
                  Container(
                    // width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffBE8F4F)),
                    child: CountDown(
                      seconds: state.countDown!,
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(
                width: Get.width - 130,
                child: Text(
                  "此卖家95%的订单将会在7分钟内完成".tr,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12.sp, color: Color(0xff45280F)),
                ),
              )
            ],
          )),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 105,
                child: const CustomImage(Assets.orderClockSmall),
              ))
        ],
      ),
    );
  }
}

class CancelAndAppeal extends GetView<OrderDetailController> {
  const CancelAndAppeal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.w,
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
              onPressed: () {
                Get.toNamed(Routes.CONFIRM_CANCEL_ORDER, arguments: {
                  'id': controller.id,
                });
              },
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
