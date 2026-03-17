// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:get/get.dart';
// import 'package:otc_app/app.dart';
// import 'package:otc_app/app/modules/trade/controllers/buy_orders_controller.dart';
// import 'package:otc_app/app/modules/trade/controllers/order_filter_controller.dart';
// import 'package:otc_app/app/modules/trade/controllers/sale_orders_controller.dart';
// import 'package:otc_app/app/modules/trade/views/order_filter.dart';
// import 'package:otc_app/app/widgets/button.dart';
// import 'package:otc_app/app/widgets/dialog.dart';
// import 'package:otc_app/app/widgets/empty_list.dart';
// import 'package:otc_app/app/widgets/input_decoration.dart';
// import 'package:otc_app/app/widgets/select_bottom_sheet.dart';
// import 'package:otc_app/common/tools/text_input_formatter.dart';
// import 'package:otc_app/common/widgets/avatar.dart';
// import 'package:otc_app/common/widgets/down_select.dart';
// import 'package:otc_app/models/pay_side.dart';
// import 'package:otc_app/models/payment_type.dart';
// import 'package:otc_app/models/publish_order.dart';
// import 'package:otc_app/service.dart';
//
// import '../controllers/trade_controller.dart';
//
// class TradeView extends GetView<TradeController> {
//   const TradeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.appColors.primary,
//       appBar: AAppBar(
//         backgroundColor: context.appColors.primary,
//         titleWidget: Text(
//           '交易'.tr,
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               if (!UserService.to.isLogin) {
//                 UserService.to.logout();
//                 return;
//               }
//               if (UserService.to.user.value.userType == 0) {
//                 Get.dialog(const AuthRoleDialog(), barrierDismissible: false);
//                 return;
//               }
//               // PaySide? paySide = await Get.bottomSheet(
//               //     const SelectBottomSheet<PaySide>(options: [
//               //   ('发布买入', PaySide.buy),
//               //   ('发布卖出', PaySide.sell),
//               // ], title: '交易方向'));
//               PaySide paySide = controller.tabController.index == 0
//                   ? PaySide.sell
//                   : PaySide.buy;
//               Get.toNamed(Routes.POST_ORDER, arguments: {
//                 'type': paySide,
//               });
//             },
//             child: Text(
//               '发布',
//               style: TextStyle(
//                 fontSize: 17.sp,
//                 fontWeight: FontWeight.w600,
//                 color: context.appColors.text1,
//               ),
//             ),
//           ),
//         ],
//         isRootNavigator: true,
//       ),
//       body: Container(
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
//           color: Colors.white,
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 2.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _Tab(controller: controller),
//                   Container(
//                     margin: EdgeInsets.only(top: 16.w),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CustomImage(
//                           Assets.imagesFilter,
//                           width: 22.w,
//                           onTap: () {
//                             Get.bottomSheet(
//                               OrderFilter(
//                                 controller: Get.find<OrderFilterController>(),
//                               ),
//                               ignoreSafeArea: false,
//                               isScrollControlled: true,
//                             );
//                           },
//                         ),
//                         11.w.hb,
//                         CustomImage(
//                           Assets.imagesOrders,
//                           width: 22.w,
//                           onTap: () {
//                             Get.toNamed(Routes.HISTORY_ORDERS);
//                           },
//                         ),
//                         18.w.hb,
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             // SizedBox(height: 16.w),
//             Divider(),
//             // const _Select(),
//             Expanded(
//               child: Stack(
//                 children: [
//                   Container(
//                     child: TabBarView(
//                       controller: controller.tabController,
//                       children: [
//                         SpeedyPagedList<PublishOrder>.separator(
//                           controller: Get.find<BuyOrdersController>(),
//                           refreshOnStart: true,
//                           locatorMode: true,
//                           emptyWidget: const EmptyList(),
//                           itemBuilder: (context, index, item) {
//                             return _PublishOrder(order: item);
//                           },
//                           separatorBuilder: (context, index) => const Divider(),
//                         ),
//                         SpeedyPagedList<PublishOrder>.separator(
//                           controller: Get.find<SaleOrdersController>(),
//                           refreshOnStart: true,
//                           emptyWidget: const EmptyList(),
//                           itemBuilder: (context, index, item) {
//                             return _PublishOrder(order: item);
//                           },
//                           separatorBuilder: (context, index) => const Divider(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Obx(() => Visibility(
//                         visible: controller.filterIndex.value != null,
//                         child: Column(
//                           children: [
//                             buildNumberFilterOption(),
//                             Expanded(
//                               child: Container(
//                                 color: const Color(0x66000000),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildNumberFilterOption() {
//     if (controller.filterIndex.value == 0) {
//       return NumberFilterOption(
//         currentValue: controller.filterMoney.value,
//         options: const [
//           ('100', 100),
//           ('1000', 1000),
//           ('5000', 5000),
//           ('1万', 10000),
//           ('10万', 100000),
//           ('20万', 200000),
//         ],
//         onConfirm: (double? value) {
//           controller.filterMoney.value = value;
//           controller.filterIndex.value = null;
//         },
//       );
//     }
//     if (controller.filterIndex.value == 1) {
//       return NumberFilterOption(
//         currentValue: controller.filterMin.value,
//         options: const [
//           ('100', 100),
//           ('1000', 1000),
//           ('5000', 5000),
//           ('1万', 10000),
//           ('10万', 100000),
//           ('20万', 200000),
//         ],
//         onConfirm: (double? value) {
//           controller.filterMin.value = value;
//           controller.filterIndex.value = null;
//         },
//       );
//     }
//     if (controller.filterIndex.value == 2) {
//       return NumberFilterOption(
//         currentValue: controller.filterMax.value,
//         options: const [
//           ('100', 100),
//           ('1000', 1000),
//           ('5000', 5000),
//           ('1万', 10000),
//           ('10万', 100000),
//           ('20万', 200000),
//         ],
//         onConfirm: (double? value) {
//           controller.filterMax.value = value;
//           controller.filterIndex.value = null;
//         },
//       );
//     }
//     // if (controller.filterIndex.value == 3) {
//     //   return NumberFilterOption(
//     //     options: [
//     //       ('100', 100),
//     //       ('1000', 1000),
//     //       ('5000', 5000),
//     //       ('1万', 10000),
//     //       ('10万', 100000),
//     //       ('20万', 200000),
//     //     ],
//     //     onConfirm: (double? value) {
//     //       controller.filterMoney.value = value;
//     //       controller.filterIndex.value = null;
//     //     },
//     //   );
//     //
//     // }
//     return Container();
//   }
// }
//
// class _PublishOrder extends StatelessWidget {
//   const _PublishOrder({
//     super.key,
//     required this.order,
//   });
//
//   final PublishOrder order;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 158.w,
//       // decoration: BoxDecoration(
//       //   borderRadius: BorderRadius.circular(12.w),
//       //   border: Border.fromBorderSide(
//       //     BorderSide(
//       //       width: 1,
//       //       color: context.appColors.divider2,
//       //     ),
//       //   ),
//       // ),
//       padding: EdgeInsets.only(left: 27.w, right: 27.w, top: 9.w, bottom: 7.w),
//       child: DefaultTextStyle(
//         style: TextStyle(
//           fontSize: 14.sp,
//           color: const Color(0xff999999),
//         ),
//         child: IntrinsicHeight(
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       // const CustomImage(Assets.homeUser),
//                       Avatar(width: 24.w, imagePath: order.headerImg!),
//                       SizedBox(width: 4.w),
//                       Text(
//                         "${order.nickName}",
//                         style: TextStyle(
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5.w),
//                   Row(
//                     children: [
//                       Text("成单量 ${order.transactionCount}"),
//                       SizedBox(width: 12.w),
//                       Text("成单率 ${order.closeRate}%"),
//                     ],
//                   ),
//                   SizedBox(height: 6.w),
//                   Row(
//                     children: [
//                       const CustomImage(Assets.imagesTime),
//                       Text('${order.transactionDuration}分钟'),
//                     ],
//                   ),
//                   SizedBox(height: 6.w),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       '¥ ${removeTrailingZeros(order.price.toString())}',
//                       style: TextStyle(
//                         fontSize: 17.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 6.w),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Row(
//                           //   children: [
//                           //     const Text('数量 '),
//                           //     Text(
//                           //       '${order.number} ${Config.coinName}',
//                           //       style: TextStyle(
//                           //         color: context.appColors.text1,
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(height: 6.w),
//                           Row(
//                             children: [
//                               const Text('剩余数量 '),
//                               Text(
//                                 '${order.surplusNumber} ${Config.coinName}',
//                                 style: TextStyle(
//                                   color: context.appColors.text1,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 6.w),
//                           Row(
//                             children: [
//                               const Text('限额 '),
//                               Text(
//                                 '¥${order.minMoney}-¥${order.maxMoney}',
//                                 style: TextStyle(
//                                   color: context.appColors.text1,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               const Expanded(child: SizedBox()),
//               Container(
//                 padding: EdgeInsets.only(bottom: 10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Visibility(
//                           visible: order.isBank,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 2.w),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "银行借记卡",
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Container(
//                                   width: 1.w,
//                                   height: 10.w,
//                                   color: const Color(0xffF5A623),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: order.isAlipay,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 2.w),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "支付宝",
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Container(
//                                   width: 1.w,
//                                   height: 10.w,
//                                   color: const Color(0xff4791FF),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: order.isWechat,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 2.w),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "微信",
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Container(
//                                   width: 1.w,
//                                   height: 10.w,
//                                   color: const Color(0xff04C2AD),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: order.isUsdt!,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 2.w),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "USDT",
//                                   style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Container(
//                                   width: 1.w,
//                                   height: 10.w,
//                                   color: PaymentType.usdt.color,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     AppButton(
//                       width: 63.w,
//                       height: 28.w,
//                       title: order.type == PaySide.sell.value ? '买入' : '卖出',
//                       backgroundColor: order.type == PaySide.sell.value
//                           ? const Color(0xff04c2ad)
//                           : const Color(0xfff6465d),
//                       onPressed: () {
//                         Get.toNamed(Routes.CONFIRM_ORDER, arguments: {
//                           'order': order,
//                         });
//                       },
//                       radius: 6.w,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _Select extends GetView<TradeController> {
//   const _Select({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.symmetric(horizontal: 16.w),
//       height: 30.w,
//       padding: EdgeInsets.only(left: 15.w, right: 10.w),
//       decoration: BoxDecoration(
//         // borderRadius: BorderRadius.circular(12.w),
//         border: Border(
//           top: BorderSide(
//             width: 1,
//             color: context.appColors.divider2,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Obx(
//             () => GestureDetector(
//               onTap: () {
//                 if (controller.filterIndex.value == null) {
//                   controller.filterIndex.value = 0;
//                 } else {
//                   controller.filterIndex.value = null;
//                 }
//               },
//               child: DownSelect(
//                 title: '金额',
//                 selected: controller.filterMoney.value != null,
//                 open: controller.filterIndex.value == 0,
//               ),
//             ),
//           ),
//           Obx(
//             () => GestureDetector(
//               onTap: () {
//                 if (controller.filterIndex.value == null) {
//                   controller.filterIndex.value = 1;
//                 } else {
//                   controller.filterIndex.value = null;
//                 }
//               },
//               child: DownSelect(
//                 title: '不限最低',
//                 selected: controller.filterMin.value != null,
//                 open: controller.filterIndex.value == 1,
//               ),
//             ),
//           ),
//           Obx(
//             () => GestureDetector(
//               onTap: () {
//                 if (controller.filterIndex.value == null) {
//                   controller.filterIndex.value = 2;
//                 } else {
//                   controller.filterIndex.value = null;
//                 }
//               },
//               child: DownSelect(
//                 title: '不限最高',
//                 selected: controller.filterMax.value != null,
//                 open: controller.filterIndex.value == 2,
//               ),
//             ),
//           ),
//           Obx(
//             () => GestureDetector(
//               onTap: () {
//                 if (controller.filterIndex.value == null) {
//                   controller.filterIndex.value = 3;
//                 } else {
//                   controller.filterIndex.value = null;
//                 }
//               },
//               child: DownSelect(
//                 title: '支付方式',
//                 selected: controller.filterMin.value != null,
//                 open: controller.filterIndex.value == 3,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _Tab extends StatelessWidget {
//   const _Tab({
//     super.key,
//     required this.controller,
//   });
//
//   final TradeController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 16.w),
//       alignment: Alignment.centerLeft,
//       height: 25.w,
//       child: TabBar(
//         indicator: const BoxDecoration(),
//         indicatorSize: TabBarIndicatorSize.label,
//         controller: controller.tabController,
//         isScrollable: true,
//         labelColor: const Color(0xffF5A623),
//         labelStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600),
//         unselectedLabelColor: const Color(0xff999999),
//         unselectedLabelStyle: TextStyle(fontSize: 19.sp),
//         tabs: const [
//           Text('买币'),
//           Text('卖币'),
//         ],
//       ),
//     );
//   }
// }
//
// class NumberFilterOption extends StatefulWidget {
//   const NumberFilterOption(
//       {super.key,
//       this.currentValue,
//       required this.options,
//       required this.onConfirm});
//
//   final double? currentValue;
//   final List<(String, double)> options;
//   final void Function(double? value) onConfirm;
//
//   @override
//   State<NumberFilterOption> createState() => _NumberFilterOptionState();
// }
//
// class _NumberFilterOptionState extends State<NumberFilterOption> {
//   late TextEditingController controller;
//
//   @override
//   void initState() {
//     controller =
//         TextEditingController(text: widget.currentValue?.toString() ?? '');
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//       style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
//       child: Container(
//         color: Colors.white,
//         padding:
//             EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller,
//               style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
//               inputFormatters: [
//                 positiveNumberFormatter,
//               ],
//               keyboardType: const TextInputType.numberWithOptions(
//                   signed: true, decimal: true),
//               decoration: outlineInputDecoration.copyWith(
//                 hintText: '例如 100',
//               ),
//             ),
//             7.w.vb,
//             Container(
//               alignment: Alignment.centerLeft,
//               child: Wrap(
//                 spacing: 6.w,
//                 runSpacing: 6.w,
//                 children: List.generate(
//                   widget.options.length,
//                   (index) {
//                     final option = widget.options[index];
//                     return GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onTap: () {
//                         controller.text =
//                             removeTrailingZeros(option.$2.toString());
//                       },
//                       child: Container(
//                         width: 97.w,
//                         height: 20.w,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4.w),
//                           color: const Color(0xffe8e8e8),
//                         ),
//                         child: Text(
//                           option.$1,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: context.appColors.text1,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             14.w.vb,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AppButton(
//                   width: 153.w,
//                   height: 28.w,
//                   onPressed: () {
//                     controller.clear();
//                   },
//                   backgroundColor: const Color(0xffe8e8e8),
//                   radius: 4.w,
//                   title: '重置',
//                   titleStyle: TextStyle(
//                       fontSize: 14.sp, color: context.appColors.text1),
//                 ),
//                 AppButton(
//                   width: 153.w,
//                   height: 28.w,
//                   onPressed: () {
//                     widget.onConfirm(
//                       (controller.isBlank ?? true)
//                           ? null
//                           : double.tryParse(controller.text),
//                     );
//                   },
//                   backgroundColor: context.appColors.primary,
//                   radius: 4.w,
//                   title: '确认',
//                   titleStyle: TextStyle(
//                       fontSize: 14.sp, color: context.appColors.text1),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
