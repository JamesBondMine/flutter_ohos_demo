import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/advertise/controllers/advertise_buy_controller.dart';
import 'package:otc_app/app/modules/advertise/views/advertise_time_select_view.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/network/request/id_request.dart';

import '../controllers/advertise_controller.dart';
import '../controllers/advertise_sell_controller.dart';

class AdvertiseView extends GetView<AdvertiseController> {
  const AdvertiseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context, '挂单记录'.tr),
      body: Column(
        children: [
          SizedBox(
            // color: Colors.red,
            width: Get.width,
            height: 52,
            child: AdvertiseTimeSelectView(
              timeIndex: (index) {
                if (index == 4) {
                  // 弹出时间选择picker
                  _paymentSelectEvent();
                  return;
                }
                // 选择了前三个时间区间
                switch (controller.tabController.index) {
                  case 0:
                    controller.fetchData(0);
                    break;
                  case 1:
                    Get.find<AdvertiseBuyController>().fetchData(0);
                    break;
                  case 2:
                    Get.find<AdvertiseSellController>().fetchData(0);
                    break;
                  default:
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TradeOrdersTab(
                labelPadding: EdgeInsets.only(right: 5.w, left: 10.w),
                controller: AdvertiseController.to.tabController),
          ),
          10.w.vb,
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: [
              buildAllList(controller),
              buildAllList(Get.find<AdvertiseBuyController>()),
              buildAllList(Get.find<AdvertiseSellController>()),
            ],
          ))
        ],
      ),
    );
  }

  _paymentSelectEvent() async {
    Get.bottomSheet(TimePickerSelectView(
      select: (Map<String, DateTime> value) {
        // 开始要取凌晨  结束要取第二天的凌晨
        DateTime start = value["start"] ?? DateTime.now();
        DateTime end = value["end"] ?? DateTime.now();

        start = DateTime(
          start.year, // 年份
          start.month, // 月份
          start.day, // 日期
          0, // 小时
          0, // 分钟
          0, // 秒
          0, // 毫秒
        );
        end = DateTime(
          end.year, // 年份
          end.month, // 月份
          end.day, // 日期
          0, // 小时
          0, // 分钟
          0, // 秒
          0, // 毫秒
        );
        end = DateTime.fromMillisecondsSinceEpoch(
            end.millisecondsSinceEpoch + (3600000 * 24));
        controller.dateMap = {"start": start, "end": end};
        controller.timeSelectIndex = 4;
        controller.updateAdverTimeSelectRefresh();

        // 刷新数据
        switch (controller.tabController.index) {
          case 0:
            controller.fetchData(0);
            break;
          case 1:
            Get.find<AdvertiseBuyController>().fetchData(0);
            break;
          case 2:
            Get.find<AdvertiseSellController>().fetchData(0);
            break;
          default:
        }
      },
    ));
  }

  buildAllList(PagingMixin<PublishOrder> c) {
    return SpeedyPagedList<PublishOrder>.separator(
      controller: c,
      refreshOnStart: true,
      locatorMode: true,
      emptyWidget: const EmptyList(),
      itemBuilder: (context, index, item) {
        return OrderItem(detail: item);
      },
      separatorBuilder: (context, index) => 16.w.vb,
    );
  }

  PreferredSize _headerView(BuildContext context, String title) {
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
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.POST_ORDER_PAGE);
              },
              child: Container(
                margin: EdgeInsets.only(right: 14.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Text(
                  "发布".tr,
                  style: TextStyle(color: Config.kTheme!.text1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TradeOrdersTab extends StatelessWidget {
  const TradeOrdersTab({
    super.key,
    this.labelPadding,
    required this.controller,
  });

  final EdgeInsetsGeometry? labelPadding;

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: labelPadding,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Config.kTheme!.text1,
      unselectedLabelColor: Config.kTheme!.text2,
      labelStyle: TextStyle(
          fontSize: 14.sp,
          color: Config.kTheme!.text1,
          fontWeight: FontWeight.w500),
      // indicator: BoxDecoration(
      //   borderRadius: BorderRadius.circular(2.w),
      //   color: const Color(0xff48484a),
      // ),
      indicatorColor: Colors.transparent,
      tabs: [
        Container(
          alignment: Alignment.center,
          height: 26.w,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.w),
              border: Border.all(color: Config.kTheme!.text2, width: 0.8)),
          child: Text('全部'.tr),
        ),
        Container(
          alignment: Alignment.center,
          height: 26.w,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.w),
              border: Border.all(color: Config.kTheme!.text2, width: 0.8)),
          child: Text('买入'.tr),
        ),
        Container(
          alignment: Alignment.center,
          height: 26.w,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.w),
              border: Border.all(color: Config.kTheme!.text2, width: 0.8)),
          child: Text('卖出'.tr),
        ),
      ],
      controller: controller,
    );
  }
}

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.detail});

  final PublishOrder detail;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late PublishOrder _detail;

  @override
  void initState() {
    _detail = widget.detail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.ADVERTISE_TRADES, arguments: {
          'id': widget.detail.id,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: Config.kTheme!.bg1,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: 16.w),
        child: DefaultTextStyle(
            style: TextStyle(fontSize: 14.sp, color: context.appColors.text4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  margin: EdgeInsets.only(right: 10.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.fromBorderSide(BorderSide(
                          color: Config.kTheme!.text2.withOpacity(0.5),
                          width: 0.8))),
                  child: Text(
                    "₹",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Config.kTheme!.text1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Text(
                        "${'剩余数量'.tr} ${widget.detail.surplusNumber} RSO",
                        style: TextStyle(
                            color: Config.kTheme!.text1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 7.w),
                    Text(
                      'limit ₹${widget.detail.surplusNumber} - ₹${widget.detail.maxMoney}',
                      style: TextStyle(
                        color: Config.kTheme!.text2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.w),
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                        child: Avatar(
                          width: 12.w,
                          color: Color(0xff9b9b9b),
                          imagePath: widget.detail.headerImg,
                        ),
                      ),
                      TextSpan(
                          text:
                              " ${"成单量".tr} ${widget.detail.transactionCount} |\n${"成单率".tr} ${widget.detail.closeRate}%",
                          style: TextStyle(
                            height: 2,
                            fontSize: 11.sp,
                            color: Config.kTheme!.text2,
                          ))
                    ])),
                    SizedBox(height: 5.w),
                    _payment(widget.detail),
                  ],
                ),
                Spacer(),
                Container(
                  // padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            CustomImage(
                              Assets.ordertime1,
                              color: Config.kTheme!.text2,
                            ),
                            3.w.hb,
                            Text(
                              '${widget.detail.transactionDuration}',
                              style: TextStyle(
                                  color: Config.kTheme!.text2, fontSize: 13),
                            ),
                            Text(
                              '分钟'.tr,
                              style: TextStyle(
                                  color: Config.kTheme!.text2, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      _detail.state == 3 ||
                              _detail.state == 2 ||
                              _detail.state == 4
                          ? _btnCompleteView()
                          : _btnView()
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _btnCompleteView() {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.ADVERTISE_TRADES, arguments: {
          'id': widget.detail.id,
        });
      },
      child: Container(
        width: 80.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: Config.kTheme!.bgbtn,
            border: Border.all(
                color: _detail.state == 3 ? Config.kTheme!.text2 : Colors.red,
                width: 0.8),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          _detail.state == 4
              ? '已取消'.tr
              : _detail.state == 3
                  ? '已完成'.tr
                  : '已终止'.tr,
          style: TextStyle(
              fontSize: 13.sp,
              color: _detail.state == 3 ? Config.kTheme!.text2 : Colors.red),
        ),
      ),
    );
  }

  Widget _btnView() {
    return GestureDetector(
      onTap: () async {
        final confirm =
            await confirmBottomSheet(title: '确认终止挂单吗?'.tr, subTitle: '');
        if (confirm == null || !confirm) {
          return;
        }
        final res = await NetRepository.client
            .terminationOrder(IdRequest(id: _detail.id));
        if (res.code != 0) {
          Toast.showError(res.msg);
          return;
        }
        // Toast.showSuccess(res.msg);
        setState(() {
          _detail = _detail.copyWith(
            state: 2,
          );
        });
      },
      child: Container(
        width: 80.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Config.kTheme!.bgbtn,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          '终止挂单'.tr,
          style: TextStyle(fontSize: 13.sp, color: Config.kTheme!.text1),
        ),
      ),
    );
  }

  Widget _payment(PublishOrder order) {
    List<Widget> children = [];
    List<String> methods = order.payMethod.split(",");
    for (var i = 0; i < methods.length; i++) {
      children.add(Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: CustomImage(
          pts["${methods[i]}"],
          height: 20.w,
          color: Config.kTheme!.text2,
        ),
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: children,
      ),
    );
  }

  Map<String, dynamic> get pts => {
        "5": Assets.orderPpment1,
        "6": Assets.orderPpment3,
        "7": Assets.orderPpment2,
        "8": Assets.orderPpment4,
        "9": Assets.orderPpment5,
        "10": Assets.orderPpment6,
        // 默认
        "1": Assets.orderPpment1,
        "2": Assets.orderPpment1,
        "3": Assets.orderPpment1,
        "4": Assets.orderPpment1
      };
}
