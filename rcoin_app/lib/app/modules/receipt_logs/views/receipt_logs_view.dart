import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/trans_fon.dart';

import '../controllers/receipt_logs_controller.dart';

class ReceiptLogsView extends GetView<ReceiptLogsController> {
  const ReceiptLogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: '收款记录',
        shadow: true,
      ),
      body: SpeedyPagedList<TransFon>.separator(
        controller: controller,
        refreshOnStart: true,
        locatorMode: true,
        emptyWidget: const CustomImage(Assets.imagesEmptyTransfer),
        itemBuilder: (context, index, item) {
          return ReceiptItem(detail: item);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({super.key, required this.detail});

  final TransFon detail;

  @override
  Widget build(BuildContext context) {
    var s66 = TextStyle(color: context.appColors.text4);
    var sGreen = const TextStyle(color: Color(0xff09C3AF));
    var sYellow = TextStyle(color: context.appColors.primary, fontSize: 17.sp);
    var s00 = const TextStyle(color: Colors.black);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.w),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 14.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('收款', style: sGreen),
                Text(formatDateTime(detail.CreatedAt!), style: s66),
              ],
            ),
            10.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('数量', style: s66),
                Text('${detail.amount?.rtz}₹', style: s00),
              ],
            ),
            9.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('手续费', style: s66),
                Text('${detail.fee?.rtz}₹', style: s00),
              ],
            ),
            3.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('转账地址', style: s66),
                10.w.hb,
                Expanded(child: SelectableText('${detail.address}', style: sYellow)),
              ],
            ),
            6.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('收款地址', style: s66),
                10.w.hb,
                Expanded(child: SelectableText('${detail.receiveAddress}', style: sYellow)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
