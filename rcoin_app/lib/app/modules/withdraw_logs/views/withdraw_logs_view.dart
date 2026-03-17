import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/network/response/withdraw_log.dart';

import '../controllers/withdraw_logs_controller.dart';

class WithdrawLogsView extends GetView<WithdrawLogsController> {
  const WithdrawLogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AAppBar(
        title: '提现明细'.tr,
        shadow: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 7, right: 9).w,
        child: SpeedyPagedList<WithdrawLog>.separator(
          controller: controller,
          itemBuilder: (BuildContext context, int index,
              WithdrawLog item) {
            return _Item(detail: item);
          },
          separatorBuilder: (context, index) => Container(
            height: 1.w,
            color: context.appColors.divider2,
          ),
          emptyWidget: const EmptyList(
            title: '',
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.detail});

  final WithdrawLog detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
       // Get.toNamed(Routes.RECHARGE_DETAIL, arguments: detail);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${Config.coinName} ${'提现'.tr}",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                Text("-${detail.number}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.red,
                    )),
              ],
            ),
            5.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDateTime(detail.createdAt!),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.text4,
                    )),
                Text("USDT +${detail.amount}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.text4,
                    )),
              ],
            ),
            5.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('地址'.tr, style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text4,
                )),
                15.w.hb,
                Expanded(
                    child:Align(
                        alignment: Alignment.centerRight,
                        child: Text('${detail.account}', style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.text4,
                        ))
                    )),
              ],
            ),
            5.w.vb,

            Text("${'状态'.tr}：${detail.stateDesc()}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text4,
                )),
          ],
        ),
      ),
    );
  }
}
