// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:get/get.dart';
// import 'package:otc_app/app.dart';
// import 'package:otc_app/app/widgets/button.dart';
// import 'package:otc_app/app/widgets/input_decoration.dart';
// import 'package:otc_app/common/tools/text_input_formatter.dart';
// import 'package:otc_app/models/pay_side.dart';
// import 'package:otc_app/models/payment_type.dart';
// import 'package:otc_app/models/publish_order.dart';
//
// import '../../../widgets/option.dart';
// import '../controllers/confirm_order_controller.dart';
//
// class ConfirmOrderView extends GetView<ConfirmOrderController> {
//   const ConfirmOrderView({Key? key}) : super(key: key);
//
//   PublishOrder get order => controller.order;
//
//   @override
//   Widget build(BuildContext context) {
//     var s_12_99 =
//         TextStyle(fontSize: 14.sp, color: context.appColors.textPlaceholder);
//     var s_12_33 = TextStyle(fontSize: 14.sp, color: context.appColors.text1);
//     var s_12_00_bold = TextStyle(
//         fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.bold);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AAppBar(
//         title: '确认订单'.tr,
//         shadow: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(12.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '单价'.tr,
//                     style: TextStyle(
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   12.w.vb,
//                   Text.rich(
//                     TextSpan(children: [
//                       TextSpan(
//                           text: '¥ ',
//                           style: TextStyle(
//                             color: context.appColors.textPlaceholder,
//                             fontSize: 12.sp,
//                           )),
//                       TextSpan(
//                           text:
//                               removeTrailingZeros(order.price.toString()),
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17.sp,
//                           )),
//                     ]),
//                   ),
//                   12.w.vb,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             children: [
//                               Text("付款时限".tr, style: s_12_99),
//                               12.w.hb,
//                               CustomImage(Assets.imagesTime, width: 11.w),
//                               2.w.hb,
//                               Text('${order.transactionDuration}分钟',
//                                   style: s_12_00_bold),
//                             ],
//                           ),
//                           12.w.vb,
//                           Row(
//                             children: [
//                               Text("限制额度".tr, style: s_12_99),
//                               12.w.hb,
//                               Text(
//                                   '¥${removeTrailingZeros(order.minMoney.toString())} - ¥${removeTrailingZeros(order.maxMoney.toString())}',
//                                   style: s_12_00_bold),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('交易方式'.tr,
//                               style: s_12_99.copyWith(
//                                 fontSize: 12.sp,
//                               )),
//                           6.w.hb,
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Visibility(
//                                     visible: order.isBank,
//                                     child: Container(
//                                       padding: EdgeInsets.only(bottom: 2.w),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             "银行借记卡".tr,
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(width: 4.w),
//                                           Container(
//                                             width: 1.w,
//                                             height: 10.w,
//                                             color: const Color(0xffF5A623),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: order.isAlipay,
//                                     child: Container(
//                                       padding: EdgeInsets.only(bottom: 2.w),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             "支付宝".tr,
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(width: 4.w),
//                                           Container(
//                                             width: 1.w,
//                                             height: 10.w,
//                                             color: const Color(0xff4791FF),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: order.isWechat,
//                                     child: Container(
//                                       padding: EdgeInsets.only(bottom: 2.w),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             "微信".tr,
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(width: 4.w),
//                                           Container(
//                                             width: 1.w,
//                                             height: 10.w,
//                                             color: const Color(0xff04C2AD),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: order.isUsdt,
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(vertical: 2.w),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             "USDT",
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           SizedBox(width: 4.w),
//                                           Container(
//                                             width: 1.w,
//                                             height: 10.w,
//                                             color: PaymentType.usdt.color,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(),
//             _Tab(
//               onTap: (int index) {
//                 controller.tradeType.value = index;
//               },
//               tabs: order.type == PaySide.buy.value
//                   ? ['按金额卖出'.tr, '按数量卖出'.tr]
//                   : ['按金额购买'.tr, '按数量购买'.tr],
//             ),
//             11.w.vb,
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 30.w),
//               child: TextField(
//                 controller: controller.inputController,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   positiveNumberFormatter,
//                 ],
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                 ),
//                 decoration: outlineInputDecoration.copyWith(
//                   hintText: '例如 100'.tr,
//                   suffixIcon: Container(
//                     padding: EdgeInsets.only(right: 11.w),
//                     child: GestureDetector(
//                       onTap: () {
//                         controller.inputMax();
//                       },
//                       child: Text(
//                         '全部'.tr,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w600,
//                           color: context.appColors.primary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             14.w.vb,
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 18.w),
//               alignment: Alignment.centerLeft,
//               child: Obx(() {
//                 var options = controller.options.toList();
//                 return Wrap(
//                   spacing: 10.w,
//                   runSpacing: 10.w,
//                   children: List.generate(
//                     options.length,
//                     (index) => Option<int>(
//                       value: options[index],
//                       selected: controller.optionIndex.value == index,
//                       onTap: (num value) {
//                         controller.optionIndex.value = index;
//                         controller.inputController.text = options[index].toString();
//                       },
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 30.w),
//               child: Column(
//                 children: [
//                   14.w.vb,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('数量'.tr, style: s_12_99),
//                       Obx(() => Text(
//                           '${order.type == PaySide.sell.value ? '+' : '-'} ${removeTrailingZeros(controller.equivalentQuantity.value.toString())}R',
//                           style: s_12_33)),
//                     ],
//                   ),
//                   10.w.vb,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('总额'.tr, style: s_12_99),
//                       Obx(() => Text(
//                           '${order.type == PaySide.sell.value ? '-' : '+'} ${controller.equivalentAmount.value.rtz}CNY',
//                           style: s_12_33)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             24.w.vb,
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('交易条款'.tr, style: s_12_99),
//                   10.w.vb,
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 2.w),
//                         child: Icon(
//                           Icons.info_outline,
//                           color: context.appColors.primary,
//                           size: 10.sp,
//                         ),
//                       ),
//                       5.w.hb,
//                       Expanded(
//                           child: Text(
//                         'tradeTerms'.tr,
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: context.appColors.primary,
//                         ),
//                       ))
//                     ],
//                   ),
//                   12.w.vb,
//                   Text('${order.type == PaySide.buy.value ? '买' : '卖'}家留言'.tr,
//                       style: s_12_99),
//                   8.w.vb,
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: const Color(0xfff6f6f6),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           '${order.remark}',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: const Color(0xff999999),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Expanded(child: SizedBox()),
//             Text(
//               '温馨提示'.tr,
//               style: TextStyle(fontSize: 12.sp),
//             ),
//             Text(
//               '为保证资金安全，我们将随机小数点后两位，请按照具体金额进行支付'.tr,
//               style: TextStyle(fontSize: 10.sp),
//             ),
//             10.w.vb,
//             AppButton(
//               width: 315.w,
//               height: 38.w,
//               title: order.type == PaySide.sell.value ? '买入'.tr : '卖出'.tr,
//               backgroundColor: order.type == PaySide.sell.value
//                   ? const Color(0xff04c2ad)
//                   : const Color(0xfff6465d),
//               onPressed: () {
//                 controller.send();
//               },
//             ),
//             20.w.vb,
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class _Tab extends StatefulWidget {
//   const _Tab({super.key, required this.onTap, required this.tabs});
//
//   final Function(int index) onTap;
//   final List<String> tabs;
//
//   @override
//   State<_Tab> createState() => _TabState();
// }
//
// class _TabState extends State<_Tab> {
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> children = [];
//     for (int i = 0; i < widget.tabs.length; i++) {
//       var title = widget.tabs[i];
//       children.add(GestureDetector(
//         onTap: () {
//           if (index != i) {
//             setState(() {
//               index = i;
//             });
//             widget.onTap(i);
//           }
//         },
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: index == i ? FontWeight.bold : FontWeight.w400,
//               ),
//             ),
//             if (index == i)
//               Container(
//                 width: 30.w,
//                 height: 2.w,
//                 color: context.appColors.primary,
//               )
//           ],
//         ),
//       ));
//     }
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: children,
//     );
//   }
// }
