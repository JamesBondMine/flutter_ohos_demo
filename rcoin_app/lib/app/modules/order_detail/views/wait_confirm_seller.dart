import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';

import '../../../../common/widgets/image_view.dart';
import '../../../widgets/copy_btn.dart';
import '../../../widgets/fill_remain_widget.dart';
import '../controllers/order_detail_controller.dart';
import 'order_detail_view.dart';

//等待卖家确认付款， 卖家页面
class WaitConfirmSeller extends GetView<OrderDetailController> {
  const WaitConfirmSeller({super.key, required this.state});

  final TradeDetail state;

  @override
  Widget build(BuildContext context) {
    PaymentType paymentType = state.ctcTradePay!.payType;
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: FillRemainWidget(
        topChildren: [
          Padding(
            padding: const EdgeInsets.all(12.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buyerView(),
                _sellerView(),
                SizedBox(height: 10.w),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.w, vertical: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '付款凭证'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Config.kTheme!.text1,
                        ),
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
                                        imageProvider:
                                            NetworkImage(state.imgList[index]),
                                        tag: 'appealImage_$index'),
                                    transition: Transition.zoom,
                                  );
                                },
                                child: Hero(
                                  tag: 'appealImage_$index',
                                  child: CustomImage(
                                    state.imgList[index],
                                    width: 80.w,
                                    height: 80.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  '温馨提示'.tr,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Config.kTheme!.text1),
                ),
                10.w.vb,
                Text(
                  '如若未收到款或收款金额与交易金额不符，请在倒计时结束前点击未收到款！'.tr,
                  style:
                      TextStyle(fontSize: 12.sp, color: Config.kTheme!.text2),
                )
              ],
            ),
          )
        ],
        bottomChild: Column(
          children: [
            20.w.vb,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    width: 147.w,
                    height: 52.w,
                    radius: 8,
                    title: '未收到款'.tr,
                    titleStyle: TextStyle(
                        color: Config.kTheme!.text2,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                    backgroundColor: context.appColors.primary.withOpacity(0),
                    borderSide:
                        BorderSide(color: Config.kTheme!.text2, width: 0.8),
                    onPressed: () {
                      Get.toNamed(Routes.APPEAL, arguments: {
                        'id': state.id,
                      });
                    },
                  ),
                  AppButton(
                    width: 160.w,
                    height: 52.w,
                    radius: 8,
                    backgroundColor: Config.kTheme!.bgbtn,
                    title: '确认收款'.tr,
                    titleStyle: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                    onPressed: () {
                      controller.confirmReceipt();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sellerHeader() {
    return Container(
      width: Get.width - 32,
      height: 56.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Color(0xff131313),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          gradient: LinearGradient(
              colors: [Color(0xffAF9165), Color.fromARGB(255, 188, 161, 121)])),
      child: Row(
        children: [
          CustomImage(Assets.ptSelect),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              '登录下方收款账号确认收款到账'.tr,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
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
        margin: EdgeInsets.only(top: 10.w),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          _sellerHeader(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '${'卖家'.tr}',
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
                  '收款人头像'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Avatar(
                  width: 20.w,
                  imagePath: state.seller!.headerImg!,
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
                  '收款人昵称'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.ctcTradePay!.name}',
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

  Widget _buyerHeader() {
    return Container(
      width: Get.width - 32,
      height: 78.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
      decoration: const BoxDecoration(
          color: Color(0xff131313),
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
                '请确认已收到款'.tr,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff45280F),
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 26,
                    margin: EdgeInsets.only(top: 5),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(13),
                    //     color: Color(0xffBE8F4F)),
                    child: Text(
                      '07:01 ${'将确认收款'.tr}',
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff45280F)),
                    ),
                  ),
                ],
              )
            ],
          )),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 105,
                child: const CustomImage(Assets.orderCoin),
              ))
        ],
      ),
    );
  }

  Widget _buyerView() {
    return Container(
      width: Get.width - 32,
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buyerHeader(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '${'卖出'.tr}',
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
                          color: Config.kTheme!.text1),
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
        ],
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
