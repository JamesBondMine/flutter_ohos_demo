import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';

import '../controllers/acceptance_order_controller.dart';

class AcceptanceOrderView extends GetView<AcceptanceOrderController> {
  const AcceptanceOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xffF4F4F4),
      appBar: const AAppBar(
        title: '',
        shadow: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 16.w, top: 7.w, right: 17.w, bottom: 5.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '进行中'.tr,
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.text1,
                              ),
                            ),
                            SizedBox(height: 10.w),
                            DefaultTextStyle(
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: context.appColors.text1),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('预计将在 '),
                                  Text(
                                    '2:00',
                                    style: TextStyle(
                                      color: context.appColors.primary,
                                    ),
                                  ),
                                  Text(' 内打款'),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            CupertinoActivityIndicator(
                              color: context.appColors.primary,
                              radius: 32.w,
                            ),
                            Text(
                              '2:00',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.text1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '出售',
                              style: style_12_33.copyWith(
                                  color: Color(0xffe35561)),
                            ),
                            Text(
                              'USDT',
                              style: style_12_33,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('总价'.tr, style: style_12_99),
                            Text(
                              '₹5,000.00',
                              style: style_12_33.copyWith(
                                  fontSize: 17.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 19.w),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('单价', style: style_12_99),
                        //     Text('¥7.12', style: style_12_66_b),
                        //   ],
                        // ),
                        SizedBox(height: 16.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('数量', style: style_12_99),
                            Text('174.52USDT', style: style_12_66_b),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          unselectedWidgetColor:
                              context.appColors.textPlaceholder,
                          colorScheme: ColorScheme.light(
                            primary: context.appColors.textPlaceholder,
                          ), //
                        ),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          title: Text('支付方式', style: style_12_33_b),
                          children: [
                            Row(
                              children: [
                                Text('境内银行转账', style: style_12_33),
                              ],
                            ),
                            SizedBox(height: 10.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('姓名', style: style_12_99),
                                Text('神奇的东方树叶', style: style_10_33),
                              ],
                            ),
                            SizedBox(height: 16.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bank name', style: style_12_99),
                                Text('中国信托请加line要账户，请详谈交易条款',
                                    style: style_10_33),
                              ],
                            ),
                            SizedBox(height: 16.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bank name', style: style_12_99),
                                Text('中国信托请加line要账户，请详谈交易条款',
                                    style: style_10_33),
                              ],
                            ),
                            SizedBox(height: 11.w),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              '请根据上方的收款信息，确认收款后放行！',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff48484A),
              ),
            ),
            SizedBox(height: 20.w),
            AppButton(
              width: 315.w,
              height: 38.w,
              onPressed: () {},
              title: '确认放行',
              titleStyle: TextStyle(
                color: context.appColors.text1,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
