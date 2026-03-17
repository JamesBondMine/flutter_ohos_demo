import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/views/payment_info.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/common/extensions/intl.dart';
import 'package:otc_app/common/widgets/app_bar_back_button.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:simple_animations/simple_animations.dart';

class CompleteTipView extends StatelessWidget {
  const CompleteTipView({super.key, required this.state, this.onTap});

  final TradeDetail state;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final int buyerUid =
        (state.type! == 1) ? state.userId! : state.orderUserId!;
    final bool isBuyer = UserService.to.user.value.id == buyerUid;
    final tween1 = MovieTween()
      ..tween('scale', Tween(begin: 0.0, end: 1.2),
              duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
          .thenTween('scale', Tween(begin: 1.2, end: 1),
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut);

    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              15.w.vb,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Get.width - 20,
                    // height: 470.w,
                    decoration: ShapeDecoration(
                        color: Config.kTheme!.bg1,
                        shape:
                            _CircleHoleShapeBorder(radius: 12, holeRadius: 0)),
                    child: Column(
                      children: [
                        120.w.vb,
                        Text(
                          isBuyer ? '买入成功'.tr : '卖出成功'.tr,
                          style: TextStyle(
                              fontSize: 16.sp, color: Config.kTheme!.text1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ',
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: Config.kTheme!.text1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${state.amount}'.rtz,
                              style: TextStyle(
                                fontSize: 32.sp,
                                color: Config.kTheme!.text1,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 0.5,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 16, top: 16),
                          width: Get.width - 32,
                          color: Config.kTheme!.text2.withOpacity(0.5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Avatar(
                              width: 40.w,
                              imagePath: state.seller!.headerImg!,
                              // color: Colors.grey,
                            ),
                            12.w.hb,
                            Text(
                              '${state.ctcTradePay!.name ?? ''} [${"seller".tr}]',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Config.kTheme!.text1),
                            ),
                          ],
                        ),
                        // Divider(),
                        _Row(title: '订单号'.tr, content: state.orderSn!),
                        _Row(
                            title: '数量'.tr,
                            content: state.amount!.toString().rtz),
                        _Row(title: '备注码'.tr, content: state.remarkCode!),
                        _Row(
                            title: '支付方式'.tr,
                            content: state.ctcTradePay?.payType.text ?? ''),
                        _Row(
                            title: '创建时间'.tr,
                            content: formatDateTime(state.CreatedAt!)),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 12.w,
                    child: Center(
                      child: PlayAnimationBuilder<Movie>(
                        tween: tween1, // 100.0 to 200.0
                        duration: tween1.duration, // for 1 second
                        builder: (context, value, _) {
                          return Transform.scale(
                            scale: (value.get('scale') as num).toDouble(),
                            child: const CustomImage(
                              Assets.otherReceipt,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              45.w.vb,
              AppButton(
                width: 334.w,
                height: 41.w,
                radius: 8,
                // backgroundColor: Color(0xffF4E0BD),
                onPressed: () {
                  Get.back();
                },
                title: '完成'.tr,
                // titleStyle: TextStyle(
                //   color: Color(0xff5D4C30),
                //   fontSize: 14.sp,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleHoleShapeBorder extends ShapeBorder {
  final double radius;
  final double holeRadius;

  const _CircleHoleShapeBorder({this.radius = 0, this.holeRadius = 0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(radius);

  @override
  ShapeBorder scale(double t) {
    return _CircleHoleShapeBorder(
      radius: radius * t,
      holeRadius: holeRadius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final holeCenterLeft = Offset(rect.left, rect.top + 174.w);
    final holeCenterRight = Offset(rect.right, rect.top + 174.w);
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    path.addArc(
        Rect.fromCenter(
            center: holeCenterLeft, width: holeRadius, height: holeRadius),
        -pi / 2,
        pi);
    path.addArc(
        Rect.fromCenter(
            center: holeCenterRight, width: holeRadius, height: holeRadius),
        pi / 2,
        pi);

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}

class CompleteView extends StatefulWidget {
  const CompleteView(
      {super.key, required this.detail, this.showCompleteTip = false});

  final TradeDetail detail;
  final bool showCompleteTip;

  @override
  State<CompleteView> createState() => _CompleteViewState();
}

class _CompleteViewState extends State<CompleteView> {
  late bool showCompleteTip;

  @override
  void initState() {
    showCompleteTip = widget.showCompleteTip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showCompleteTip) {
      return CompleteTipView(
        state: widget.detail,
        onTap: () {
          if (mounted) {
            setState(() {
              showCompleteTip = false;
            });
          }
        },
      );
    }
    final style_12_99 =
        TextStyle(fontSize: 14.sp, color: context.appColors.textPlaceholder);
    final style_12_33 =
        TextStyle(fontSize: 14.sp, color: context.appColors.text1);
    final style_12_33_b = TextStyle(
        fontSize: 14.sp,
        color: context.appColors.text1,
        fontWeight: FontWeight.w500);
    final style_12_66_b = TextStyle(
        fontSize: 14.sp,
        color: context.appColors.text4,
        fontWeight: FontWeight.w500);
    final style_10_33 =
        TextStyle(fontSize: 14.sp, color: context.appColors.text1);

    return Scaffold(
      appBar: const AAppBar(
        // backgroundColor: Color(0xff1ba27a),
        leading: AppBarBackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xff1ba27a),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '已完成'.tr,
                        style: TextStyle(
                          fontSize: 19.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.w),
                      Text(
                        (widget.detail.isBuyer
                                ? '您已成功购买 num coinName'.tr
                                : '您已成功出售 num coinName'.tr)
                            .trans(
                                {'num': widget.detail.number, 'coinName': '₹'}),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(right: 7.w),
                    child: CustomImage(Assets.tradeComplete, width: 98.w))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 10.w),
                Row(
                  children: [
                    // CustomImage(
                    //   Assets.imagesUsdt,
                    //   width: 22.w,
                    // ),
                    // SizedBox(width: 8.w),
                    Text(
                      '${widget.detail.isBuyer ? '购买'.tr : '出售'.tr} ₹',
                      style: style_12_33,
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                // _Row(title: '单价', content: '${widget.detail.price}'.rtz),
                _Row(title: '数量'.tr, content: '${widget.detail.number}'.rtz),
                _Row(
                    title: '总金额'.tr,
                    content:
                        '${widget.detail.ctcTradePay!.payType == PaymentType.usdt ? widget.detail.usdtAmount : widget.detail.amount}'
                            .rtz),
                _Row(title: '备注码'.tr, content: '${widget.detail.remarkCode}'),
                SizedBox(height: 8.w),
              ],
            ),
          ),
          Container(
            height: 1.w,
            color: context.appColors.divider1,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  unselectedWidgetColor: context.appColors.textPlaceholder,
                  colorScheme: ColorScheme.light(
                    primary: context.appColors.textPlaceholder,
                  ), //
                ),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  title: Text('订单信息'.tr, style: style_12_33_b),
                  children: [
                    _Row(title: '订单号'.tr, content: '${widget.detail.orderSn}'),
                    _Row(
                        title: '创建时间'.tr,
                        content: formatDateTime(widget.detail.CreatedAt!)),
                    Visibility(
                        visible: widget.detail.isBuyer,
                        child: _Row(
                            title: '卖家昵称'.tr,
                            content: '${widget.detail.seller?.nickName}')),
                    Visibility(
                        visible: !widget.detail.isBuyer,
                        child: _Row(
                            title: '买家昵称'.tr,
                            content: '${widget.detail.buyer?.nickName}')),
                    SizedBox(height: 11.w),
                  ],
                ),
              )),
          Container(
            height: 1.w,
            color: context.appColors.divider1,
          ),
          SizedBox(height: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('支付方式'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff666666),
                    )),
                Row(
                  children: [
                    Container(
                        width: 2,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                          color: widget.detail.ctcTradePay!.payType.color,
                        )),
                    6.w.hb,
                    // Text(
                    //   widget.detail.ctcTradePay!.payType.text,
                    //   style: TextStyle(
                    //     fontSize: 14.sp,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: CustomImage(
                        pts["${widget.detail.payMethod}"],
                        height: 20.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
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

class _Row extends StatelessWidget {
  const _Row({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Config.kTheme!.text2,
              )),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Config.kTheme!.text1,
            ),
          ),
        ],
      ),
    );
  }
}
