import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
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

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (BuildContext context) => UnconstrainedBox(
          child: CompositedTransformFollower(
            link: layerLink,
            followerAnchor: Alignment.topCenter,
            targetAnchor: Alignment.bottomCenter,
            child: Material(
              child: Container(
                width: 343.w,
                margin: EdgeInsets.symmetric(vertical: 10.w),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12).r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        spreadRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                      ),
                    ]),
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
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: '账单中心'.tr,
        shadow: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            10.w.vb,
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
                          fontSize: 17.sp,
                          color: context.appColors.text1,
                        ),
                      )),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xff999999),
                  ),
                  // const Expanded(child: SizedBox()),
                  // Text(
                  //   '支出 ¥2242.19',
                  //   style: TextStyle(
                  //     fontSize: 14.sp,
                  //     color: context.appColors.textPlaceholder,
                  //   ),
                  // ),
                  // 20.w.hb,
                  // Text(
                  //   '收入 ¥2131.64',
                  //   style: TextStyle(
                  //     fontSize: 14.sp,
                  //     color: context.appColors.textPlaceholder,
                  //   ),
                  // ),
                ],
              ),
            ),
            10.w.vb,
            CompositedTransformTarget(
              link: layerLink,
              child: Obx(() => controller.billTypes.isEmpty
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 17.w,
                          runSpacing: 17.w,
                          children: [
                            Obx(() => TagBtn(
                                highlight: true,
                                title: controller
                                    .billTypes[controller.billType.value].name!,
                                onTap: () {})),
                          ],
                        ),
                        CustomImage(
                          Assets.imagesFilter,
                          width: 22.w,
                          onTap: () {
                            _toggleOverlay(context);
                          },
                        )
                      ],
                    )),
            ),
            Expanded(
                child: SpeedyPagedList<CoinBillsFon>.separator(
              controller: controller,
              refreshOnStart: true,
              locatorMode: true,
              emptyWidget: EmptyList(title: '记录为空'.tr,),
              itemBuilder: (context, index, item) {
                return _Item(detail: item);
              },
              separatorBuilder: (context, index) => Container(
                height: 1.w,
                color: context.appColors.divider1,
              ),
            ))
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
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: highlight ? context.appColors.primary : Colors.white,
          border: Border.all(
            color:
                highlight ? context.appColors.primary : const Color(0xffF7F7F7),
            width: 1.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: context.appColors.text1,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w400,
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
            color: context.appColors.text1,
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
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${detail.name}',
            style: TextStyle(
              fontSize: 17.sp,
              color: context.appColors.text1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${detail.money! > 0 ? '+' : ''}${detail.money?.rtz}',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.text1,
                ),
              ),
              4.w.vb,
              Text(
                '${detail.balance?.rtz}',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.text1,
                ),
              ),
              4.w.vb,
              Text(
                formatDateTime(detail.CreatedAt!),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text4,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
