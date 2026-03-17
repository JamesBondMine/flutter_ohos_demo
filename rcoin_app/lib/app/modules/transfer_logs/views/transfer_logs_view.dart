import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/network/response/trans_fon.dart';

import '../../../widgets/empty_list.dart';
import '../controllers/transfer_logs_controller.dart';

class TransferLogsView extends GetView<TransferLogsController> {
  const TransferLogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabs: [
              Text('转账'.tr),
              Text('收款'.tr),
            ],
            onTap: (int index) {
              final indexStateMap = {0: 2, 1: 1};
              controller.switchStateQuery(indexStateMap[index]!);
            },
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            labelColor: Config.kTheme!.text1,
            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
            unselectedLabelColor: Config.kTheme!.text2,
            controller: controller.tabController,
            labelPadding: EdgeInsets.all(16.w),
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
          ),
          Expanded(
              child: Container(
            // color: const Color(0xffFAFAFA),
            padding: const EdgeInsets.only(left: 16, right: 16).w,
            child: Column(
              children: [
                Expanded(
                  child: SpeedyPagedList<TransFon>.separator(
                    controller: controller,
                    refreshOnStart: true,
                    locatorMode: true,
                    emptyWidget: const CustomImage(Assets.imagesEmptyTransfer),
                    itemBuilder: (context, index, item) {
                      return TransferItem(
                        detail: item,
                        type: controller.type,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Container(height: 10.w, color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Text(
              '记录'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 14.w),
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  const TransferItem({super.key, required this.detail, required this.type});

  final TransFon detail;
  final int type;

  @override
  Widget build(BuildContext context) {
    var s66 = TextStyle(color: Config.kTheme!.text2, fontSize: 14.sp);
    var sYellow = TextStyle(color: Config.kTheme!.text1, fontSize: 13.sp);
    var s99 = TextStyle(
        color: Color(0xffE73463), fontSize: 16.sp, fontWeight: FontWeight.w500);
    var s69 = TextStyle(
        color: Color(0xff2AC769), fontSize: 16.sp, fontWeight: FontWeight.w500);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 14.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type == 1 ? '转账'.tr : '收款'.tr,
                    style: type == 1 ? s99 : s69),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('手续费'.tr, style: s66),
                Text('${detail.fee?.rtz} ${detail.coinName}', style: sYellow),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('数量'.tr, style: s66),
                Text('${detail.amount?.rtz} ${detail.coinName}',
                    style: sYellow),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('转账地址'.tr, style: s66),
                10.w.hb,
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SelectableText('${detail.address}',
                            style: sYellow))),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('收款地址'.tr, style: s66),
                10.w.hb,
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: SelectableText('${detail.receiveAddress}',
                      style: sYellow),
                )),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('时间'.tr, style: s66),
                Text(formatDateTime(detail.CreatedAt!), style: sYellow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// body: SpeedyPagedList<TransFon>.separator(
// controller: controller,
// refreshOnStart: true,
// locatorMode: true,
// emptyWidget: const CustomImage(Assets.imagesEmptyTransfer),
// itemBuilder: (context, index, item) {
// return TransferItem(detail: item);
// },
// separatorBuilder: (context, index) => const Divider(),
//),
