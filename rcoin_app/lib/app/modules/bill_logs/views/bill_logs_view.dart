import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/main.dart';
import 'package:otc_app/network/response/coin_bills_fon.dart';

import '../../../widgets/empty_list.dart';
import '../controllers/bill_logs_controller.dart';

class BillLogsView extends GetView<BillLogsController> {
  BillLogsView({super.key});

  final LayerLink layerLink = LayerLink();
  bool show = false;

  void _toggleOverlay(BuildContext context) {
    if (!show) {
      _showOverlay(context);
    } else {
      _hideOverlay();
    }
  }

  void _showOverlay(BuildContext context) {
    overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(overlayEntry!);
    show = true;
  }

  void _hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context, '账单记录'.tr),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            _filterHeaderView(context),
            15.w.vb,
            Expanded(
                child: SpeedyPagedList<CoinBillsFon>.separator(
              controller: controller,
              refreshOnStart: true,
              locatorMode: true,
              emptyWidget: EmptyList(
                title: '记录为空'.tr,
              ),
              itemBuilder: (context, index, item) {
                return _Item(detail: item);
              },
              separatorBuilder: (context, index) => 16.w.vb,
            ))
          ],
        ),
      ),
    );
  }

  Widget _filterHeaderView(BuildContext context) {
    return Container(
      width: Get.width,
      height: 44.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _toggleOverlay(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "Bill all ",
                    style:
                        TextStyle(fontSize: 13.sp, color: Config.kTheme!.text2),
                  ),
                  Icon(Icons.arrow_drop_down, color: Config.kTheme!.text2)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                initialDateRange: controller.picked.value,
                helpText: "请选择日期区间".tr,
                cancelText: "取消".tr,
                confirmText: "确定".tr,
                saveText: "完成".tr,
                builder: (context, child) {
                  return Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: context.appColors.primary,
                            ),
                      ),
                      child: child!);
                },
              );

              controller.picked.value = picked;
              controller.onRefresh();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Obx(() => Text(
                        controller.picked.value == null
                            ? '选择时间'.tr
                            : controller.picked.value!.start
                                    .format(format: 'yyyy-MM-dd') +
                                ' - ' +
                                controller.picked.value!.end
                                    .format(format: 'yyyy-MM-dd'),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Config.kTheme!.text2,
                        ),
                      )),
                  Icon(Icons.arrow_drop_down, color: Config.kTheme!.text2)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (BuildContext context) => UnconstrainedBox(
          alignment: Alignment.topCenter,
          child: Material(
            // color: Colors.red,
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 48),
              width: Get.width - 32,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _hideOverlay();
                    },
                    child: Container(
                      width: Get.width - 32,
                      height: 55,
                      // color: Colors.green,
                      child: const SizedBox(
                        height: 55,
                        width: 130,
                        child: Text(" "),
                      ),
                    ),
                  ),
                  Container(
                    width: 353.w,

                    // margin: EdgeInsets.symmetric(vertical: 4.w),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
                            .r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Config.kTheme!.bgMain,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 12,
                            spreadRadius: 1,
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                          ),
                        ]),
                    child: SizedBox(
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.w,
                        children: controller.billTypes
                            .map((e) => BigTagBtn(
                                  highlight: e.id == controller.billType.value,
                                  title: e.name!,
                                  onTap: () {
                                    controller.billType.value = e.id!;
                                    controller.onRefresh();
                                    _hideOverlay();
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

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
            Container(
              margin: EdgeInsets.only(left: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BigTagBtn extends StatelessWidget {
  const BigTagBtn(
      {super.key,
      required this.highlight,
      required this.title,
      required this.onTap});

  final bool highlight;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 99.w,
        height: 40.w,
        // padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: highlight ? Config.kTheme!.bg3 : Config.kTheme!.bg1,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: highlight ? Config.kTheme!.text1 : Config.kTheme!.text1,
            fontWeight: highlight ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class TagBtn extends StatelessWidget {
  const TagBtn(
      {super.key,
      required this.highlight,
      required this.title,
      required this.onTap});

  final bool highlight;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: highlight ? context.appColors.primary : Color(0xffF7F7F7),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: highlight ? Colors.white : context.appColors.text1,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.detail});

  final CoinBillsFon detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: Config.kTheme!.bg1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${detail.name}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Config.kTheme!.text1,
                ),
              ),
              Text(
                '${detail.money! > 0 ? '+' : ''}${detail.money?.rtz}',
                style: TextStyle(
                  fontSize: 18.sp,
                  color:
                      detail.money! > 0 ? Color(0xffE73463) : Color(0xff2ABF5B),
                ),
              ),
            ],
          ),
          10.w.vb,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateTime(detail.CreatedAt!),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff9b9b9b),
                  ),
                ),
                Text(
                  '${"余额".tr} ${detail.balance?.rtz}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff9b9b9b),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
