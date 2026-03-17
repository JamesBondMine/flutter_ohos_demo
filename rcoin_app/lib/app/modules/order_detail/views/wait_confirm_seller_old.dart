// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:otc_app/app.dart';
// import 'package:otc_app/app/modules/order_detail/views/payment_info.dart';
// import 'package:otc_app/common/widgets/count_down.dart';
// import 'package:otc_app/models/payment_type.dart';
// import 'package:otc_app/models/trade_detail.dart';
//
// import '../controllers/order_detail_controller.dart';
// import 'order_detail_view.dart';
//
// class WaitConfirmSeller extends StatelessWidget {
//   const WaitConfirmSeller({super.key, required this.state});
//
//   final TradeDetail state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AAppBar(
//         leading: CircleLeading(),
//         actions: [
//           GoChatBtn(),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10.w),
//             Container(
//               margin: EdgeInsets.only(left: 17.w, right: 18.w),
//               child: DefaultTextStyle(
//                 style: TextStyle(
//                   fontSize: 19.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('请确认已收到付款'.tr),
//                     6.w.vb,
//                     Text('¥${state.amount}'),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.w),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CountDown(
//                   seconds: state.countDown!,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: context.appColors.primary,
//                   ),
//                 ),
//                 Text('后将自动确认收款'.tr,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black,
//                     )),
//               ],
//             ),
//             SizedBox(height: 10.w),
//             const Divider(),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 17.w),
//               child: DefaultTextStyle(
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: const Color(0xff666666),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         // SvgPicture.asset(
//                         //   Assets.imagesUsdt,
//                         //   width: 22.w,
//                         // ),
//                         // 8.w.hb,
//                         Text(
//                           '${'出售'.tr} ${Config.coinName}',
//                           style: TextStyle(
//                             color: context.appColors.text1,
//                           ),
//                         )
//                       ],
//                     ),
//                     16.w.vb,
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 10.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('订单号'.tr),
//                           SelectableText(
//                             '${(state.orderSn)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Padding(
//                     //   padding: EdgeInsets.only(bottom: 16.w),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       const Text('单价'),
//                     //       Text(
//                     //         '${state.price!.rtz}',
//                     //         style: const TextStyle(
//                     //           fontWeight: FontWeight.bold,
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 16.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('数量'.tr),
//                           Text(
//                             '${state.number}${Config.coinName}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 16.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('总金额'.tr),
//                           Text(
//                             '${state.ctcTradePay!.payType == PaymentType.usdt ? state.usdtAmount : state.amount}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 10.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('备注码'.tr),
//                           Text(
//                             '${(state.remarkCode)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Divider(),
//             24.w.vb,
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 9.w),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 16.w,
//                     height: 16.w,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: context.appColors.primary,
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       '1',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: const Color(0xff48484A),
//                       ),
//                     ),
//                   ),
//                   3.w.hb,
//                   Text(
//                     '登录您下方的收款账户，确认买家的付款已到账。'.tr,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: context.appColors.text1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             16.w.vb,
//             Container(
//               margin: EdgeInsets.only(left: 27.w, right: 16.w),
//               padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 16.w),
//               // height: 160.w,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 12.w,
//                     )
//                   ]),
//               child: Column(
//                 children: [
//                   PaymentInfo(payment: state.ctcTradePay!),
//                   9.w.vb,
//                   Container(
//                     margin: EdgeInsets.only(left: 12.w, right: 9.w),
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4.w),
//                       color: const Color(0xfff6f6f6),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '买家实名'.tr,
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: context.appColors.textPlaceholder),
//                         ),
//                         Text(
//                           state.buyerNickName!,
//                           style: TextStyle(
//                               fontSize: 14.sp, color: context.appColors.text1),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             16.w.vb,
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 '重要提示：如果未收到款或者收到款项与交易金额不符，请在倒计时结束前点击“未收到款”！'.tr,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: context.appColors.text1,
//                 ),
//               ),
//             ),
//             // Expanded(child: SizedBox()),
//             20.w.vb,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: 140.w,
//                   height: 38.w,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xff1c1c1c),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.w),
//                         )),
//                     onPressed: () {
//                       // Get.find<OrderDetailController>().postAppeal();
//                       Get.toNamed(Routes.APPEAL, arguments: {
//                         'id': state.id,
//                       });
//                     },
//                     child: Text(
//                       '未收到款'.tr,
//                       style: style00Bold.copyWith(
//                         fontSize: 17.sp,
//                         color: context.appColors.primary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 140.w,
//                   height: 38.w,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: context.appColors.primary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4.w),
//                         )),
//                     onPressed: () {
//                       Get.find<OrderDetailController>().confirmReceipt();
//                     },
//                     child: Text(
//                       '我已确认收款'.tr,
//                       style: style00Bold.copyWith(
//                         fontSize: 17.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             20.w.vb,
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CancelAndAppeal extends StatelessWidget {
//   const CancelAndAppeal({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.w,
//       decoration: BoxDecoration(color: Colors.white, boxShadow: [
//         BoxShadow(
//           offset: const Offset(0, -4),
//           blurRadius: 12,
//           color: Colors.black.withOpacity(0.05),
//         )
//       ]),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             width: 156.w,
//             height: 38.w,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffF7F7F7),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.w),
//                   )),
//               onPressed: () {},
//               child: Text(
//                 '取消订单'.tr,
//                 style: style33.copyWith(
//                   fontSize: 17.sp,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 156.w,
//             height: 38.w,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffF7F7F7),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.w),
//                   )),
//               onPressed: () {},
//               child: Text(
//                 '申诉'.tr,
//                 style: style33.copyWith(
//                   fontSize: 17.sp,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class RemindOrder extends StatelessWidget {
//   const RemindOrder({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 17.w),
//       alignment: Alignment.centerLeft,
//       child: SizedBox(
//         width: 80.w,
//         height: 30.w,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: context.appColors.primary,
//           ),
//           onPressed: () {},
//           child: Text(
//             '催单'.tr,
//             style: style00Bold.copyWith(
//               fontSize: 17.sp,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
