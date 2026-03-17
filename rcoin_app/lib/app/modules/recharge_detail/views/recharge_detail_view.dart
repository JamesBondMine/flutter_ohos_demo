import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/network/response/recharge_res_detail.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/recharge_detail_controller.dart';

class RechargeDetailView extends GetView<RechargeDetailController> {
  const RechargeDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RechargeResDetail detail = Get.arguments;

    if (detail.state != 3) {
      return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        appBar: _headerView(context),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 14.w, top: 16.w, right: 20.w),
              padding: EdgeInsets.only(left: 12.w, top: 12.w, right: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(20).r),
                color: Config.kTheme!.bg1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      CustomImage(
                        detail.state == 1
                            ? Assets.otherClock
                            : Assets.rechargeRechargeStateSuc,
                        width: 50.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.state == 1 ? '进行中'.tr : '已完成'.tr,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              detail.state == 1
                                  ? '${'您正在充值'.tr} ${detail.receivedAmount}${Config.coinName}'
                                  : '${'您已经成功充值'.tr} ${detail.receivedAmount}${Config.coinName}',
                              style: TextStyle(color: Color(0xff9b9b9b)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.w),
                  const _Divider(),
                  _Item(
                      title: '订单号'.tr,
                      subTitle: '${detail.orderSn}',
                      ispost: true),
                  _Item(
                      title: '充值时间'.tr,
                      subTitle: formatDateTime(detail.createdAt!),
                      ispost: false),
                  _Item(
                      title: '充币公链协议'.tr,
                      subTitle: '${detail.protocol}',
                      ispost: false),
                  _Item(
                      title: '实际支付'.tr,
                      subTitle: '${detail.money}',
                      ispost: false),
                  _Item(
                      title: '交易HASH'.tr,
                      subTitle: '${detail.hash}',
                      ispost: false),
                  16.w.vb,
                ],
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 14.w, top: 16.w, right: 20.w),
            padding: EdgeInsets.only(left: 12.w, top: 12.w, right: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(20).r),
              color: Config.kTheme!.bg1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      '充值失败'.tr,
                      style: TextStyle(
                          color: const Color(0xffFF1010),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 12.w),
                const _Divider(),
                _Item(
                    title: '订单号'.tr,
                    subTitle: '${detail.orderSn}',
                    ispost: true),
                _Item(
                    title: '充值时间'.tr,
                    subTitle: formatDateTime(detail.createdAt!),
                    ispost: false),
                _Item(
                    title: '充币公链协议'.tr,
                    subTitle: '${detail.protocol}',
                    ispost: false),
                _Item(
                    title: '实际支付'.tr,
                    subTitle: '${detail.money}',
                    ispost: false),
                _Item(
                    title: '交易HASH'.tr,
                    subTitle: '${detail.hash}',
                    ispost: false),
              ],
            ),
          )
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
              '充值详情'.tr,
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

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.w,
      color: Config.kTheme!.text1.withOpacity(0.5),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
      {required this.title, required this.subTitle, required this.ispost});

  final String title;
  final String subTitle;
  final bool ispost;
  @override
  Widget build(BuildContext context) {
    if (ispost) {
      return SizedBox(
        height: 34.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff7E7E7E),
              ),
            ),
            Row(
              children: [
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Config.kTheme!.text1,
                  ),
                ),
                CopyBtn(text: subTitle, size: 25.w)
              ],
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 34.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xff7E7E7E),
            ),
          ),
          Text(
            subTitle,
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
