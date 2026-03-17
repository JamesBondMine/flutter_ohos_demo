// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:otc_app/app.dart';
// import 'package:otc_app/app/widgets/button.dart';
// import 'package:otc_app/common/extensions/intl.dart';
// import 'package:otc_app/common/widgets/app_bar_back_button.dart';
// import 'package:otc_app/models/payment.dart';
// import 'package:otc_app/models/payment_type.dart';
// import 'package:otc_app/models/trade_detail.dart';
// import 'package:simple_animations/simple_animations.dart';
//
// class CompleteTipView extends StatelessWidget {
//   const CompleteTipView({super.key, required this.state, required this.onTap});
//
//   final TradeDetail state;
//   final Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final int buyerUid =
//         (state.type! == 1) ? state.userId! : state.orderUserId!;
//     final bool isBuyer = UserService.to.user.value.id == buyerUid;
//     final tween1 = MovieTween()
//       ..tween('scale', Tween(begin: 0.0, end: 1.2),
//               duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
//           .thenTween('scale', Tween(begin: 1.2, end: 1),
//               duration: const Duration(milliseconds: 120),
//               curve: Curves.easeOut);
//
//     return Scaffold(
//       appBar: const AAppBar(
//         shadow: true,
//       ),
//       body: Container(
//         width: double.maxFinite,
//         child: Column(
//           children: [
//             50.w.vb,
//             Container(
//               height: 110.w,
//               alignment: Alignment.center,
//               child: PlayAnimationBuilder<Movie>(
//                 tween: tween1, // 100.0 to 200.0
//                 duration: tween1.duration, // for 1 second
//                 builder: (context, value, _) {
//                   return CustomImage(
//                     Assets.tradeSuccess,
//                     width: 118.w * value.get('scale'),
//                     height: 95.w * value.get('scale'),
//                   );
//                 },
//                 onCompleted: () {},
//               ),
//             ),
//             40.w.vb,
//             Text(
//               '${state.number}',
//               style: TextStyle(
//                 fontSize: 29.sp,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               Config.coinName,
//               style: TextStyle(
//                 fontSize: 17.sp,
//                 color: context.appColors.text1,
//               ),
//             ),
//             7.w.vb,
//             Text(
//               isBuyer ? '充值至您的账户'.tr : '已经成功出售'.tr,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: context.appColors.text1,
//               ),
//             ),
//             110.w.vb,
//             AppButton(
//                 width: 120.w,
//                 height: 38.w,
//                 backgroundColor: const Color(0xff09c3af),
//                 radius: 4.w,
//                 onPressed: onTap,
//                 title: '完成'.tr),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CompleteView extends StatefulWidget {
//   const CompleteView(
//       {super.key, required this.detail, this.showCompleteTip = false});
//
//   final TradeDetail detail;
//   final bool showCompleteTip;
//
//   @override
//   State<CompleteView> createState() => _CompleteViewState();
// }
//
// class _CompleteViewState extends State<CompleteView> {
//   late bool showCompleteTip;
//
//   @override
//   void initState() {
//     showCompleteTip = widget.showCompleteTip;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (showCompleteTip) {
//       return CompleteTipView(
//         state: widget.detail,
//         onTap: () {
//           if (mounted) {
//             setState(() {
//               showCompleteTip = false;
//             });
//           }
//         },
//       );
//     }
//     final style_12_99 =
//         TextStyle(fontSize: 14.sp, color: context.appColors.textPlaceholder);
//     final style_12_33 =
//         TextStyle(fontSize: 14.sp, color: context.appColors.text1);
//     final style_12_33_b = TextStyle(
//         fontSize: 14.sp,
//         color: context.appColors.text1,
//         fontWeight: FontWeight.w500);
//     final style_12_66_b = TextStyle(
//         fontSize: 14.sp,
//         color: context.appColors.text4,
//         fontWeight: FontWeight.w500);
//     final style_10_33 =
//         TextStyle(fontSize: 14.sp, color: context.appColors.text1);
//
//     return Scaffold(
//       appBar: const AAppBar(
//         backgroundColor: Color(0xff1ba27a),
//         leading: AppBarBackButton(
//           color: Colors.white,
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xff1ba27a),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 17.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '已完成'.tr,
//                         style: TextStyle(
//                           fontSize: 19.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10.w),
//                       Text(
//                         (widget.detail.isBuyer ? '您已成功购买 num coinName': '您已成功出售 num coinName').trans({
//                           'num': widget.detail.number,
//                           'coinName': Config.coinName
//                         }),
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                     padding: EdgeInsets.only(right: 7.w),
//                     child: CustomImage(Assets.tradeComplete, width: 98.w))
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               children: [
//                 SizedBox(height: 10.w),
//                 Row(
//                   children: [
//                     // CustomImage(
//                     //   Assets.imagesUsdt,
//                     //   width: 22.w,
//                     // ),
//                     // SizedBox(width: 8.w),
//                     Text(
//                       '${widget.detail.isBuyer ? '购买'.tr : '出售'.tr} ${Config.coinName}',
//                       style: style_12_33,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8.w),
//                 // _Row(title: '单价', content: '${widget.detail.price}'.rtz),
//                 _Row(title: '数量'.tr, content: '${widget.detail.number}'.rtz),
//                 _Row(title: '总金额'.tr, content: '${widget.detail.ctcTradePay!.payType == PaymentType.usdt ? widget.detail.usdtAmount: widget.detail.amount}'.rtz),
//                 _Row(title: '备注码'.tr, content: '${widget.detail.remarkCode}'),
//                 SizedBox(height: 8.w),
//               ],
//             ),
//           ),
//           Container(
//             height: 1.w,
//             color: context.appColors.divider1,
//           ),
//           Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   dividerColor: Colors.transparent,
//                   unselectedWidgetColor: context.appColors.textPlaceholder,
//                   colorScheme: ColorScheme.light(
//                     primary: context.appColors.textPlaceholder,
//                   ), //
//                 ),
//                 child: ExpansionTile(
//                   initiallyExpanded: true,
//                   tilePadding: EdgeInsets.zero,
//                   childrenPadding: EdgeInsets.zero,
//                   title: Text('订单信息'.tr, style: style_12_33_b),
//                   children: [
//                     _Row(title: '订单号'.tr, content: '${widget.detail.orderSn}'),
//                     _Row(
//                         title: '创建时间'.tr,
//                         content: formatDateTime(widget.detail.CreatedAt!)),
//                     Visibility(
//                         visible: widget.detail.isBuyer,
//                         child: _Row(
//                             title: '卖家昵称'.tr,
//                             content: '${widget.detail.sellerNickName}')),
//                     Visibility(
//                         visible: !widget.detail.isBuyer,
//                         child: _Row(
//                             title: '买家昵称'.tr,
//                             content: '${widget.detail.buyerNickName}')),
//                     SizedBox(height: 11.w),
//                   ],
//                 ),
//               )),
//           Container(
//             height: 1.w,
//             color: context.appColors.divider1,
//           ),
//           SizedBox(height: 8.w),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('支付方式'.tr,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: const Color(0xff666666),
//                     )),
//                 Row(
//                   children: [
//                     Container(
//                         width: 2,
//                         height: 12,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.w),
//                           color: widget.detail.ctcTradePay!.payType.color,
//                         )),
//                     6.w.hb,
//                     Text(
//                       widget.detail.ctcTradePay!.payType.text,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _Row extends StatelessWidget {
//   const _Row({super.key, required this.title, required this.content});
//
//   final String title;
//   final String content;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: const Color(0xff666666),
//               )),
//           Text(
//             content,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
