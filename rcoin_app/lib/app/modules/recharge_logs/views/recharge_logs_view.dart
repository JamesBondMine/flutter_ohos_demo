import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/views/order_detail_view.dart';
import 'package:otc_app/app/modules/recharge_logs/views/recharge_log_menu.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/extensions/intl.dart';
import 'package:otc_app/common/refresh/state.dart';
import 'package:otc_app/network/response/recharge_res_detail.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/recharge_logs_controller.dart';

class RechargeLogsView extends GetView<RechargeLogsController> {
  const RechargeLogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Column(
        children: [
          15.w.vb,
          RechargeLogMenu(
            click: (index) {
              // -1 1 3 2
              final indexStateMap = {0: -1, 1: 1, 2: 3, 3: 2};
              controller.switchStateQuery(indexStateMap[index]!);
            },
          ),
          Expanded(
              child: Container(
            // color: const Color(0xffFAFAFA),
            padding: const EdgeInsets.only(left: 16, right: 16).w,
            child: Column(
              children: [
                16.w.vb,
                Expanded(
                    child: SpeedyPagedList<RechargeResDetail>.separator(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index,
                      RechargeResDetail item) {
                    return _Item(detail: item);
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 10.w,
                    color: Config.kTheme!.bgMain,
                  ),
                  emptyWidget: const EmptyList(
                    title: '',
                  ),
                )),
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
                child: Icon(Icons.arrow_back_ios,
                    size: 16, color: Config.kTheme!.text1),
              ),
            ),
            Text(
              '充值明细'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              child: CustomImage(
                Assets.newimagesCommentService,
                color: Config.kTheme!.text1,
                onTap: () {
                  ChatService.to.goChatWithService();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.detail});

  final RechargeResDetail detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.RECHARGE_DETAIL, arguments: detail);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 11, bottom: 14).w,
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(detail.stateDesc(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: detail.getColor(),
                    )),
                detail.state == 3
                    ? Container()
                    : Text("+${detail.receivedAmount} ${Config.coinName}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Config.kTheme!.text1,
                        )),
              ],
            ),
            5.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDateTime(detail.createdAt!),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xff6d6d6d),
                      // fontWeight: FontWeight.bold,
                    )),
                Text("${'支付'.tr} ${'+'}${detail.money}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xff6d6d6d),
                    )),
              ],
            ),
            5.w.vb,
          ],
        ),
      ),
    );
  }
}
