import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/trade/controllers/trade_controller.dart';

class FilterBar extends GetView<TradeController> {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Option(
            title: '金额'.tr,
            checkedIndex: 0,
          ),
          14.w.hb,
          _Option(
            title: '交易下限'.tr,
            checkedIndex: 1,
          ),
          14.w.hb,
          _Option(
            title: '交易上限'.tr,
            checkedIndex: 2,
          ),
          14.w.hb,
          // _Option(
          //   title: 'price'.tr,
          //   checkedIndex: 2,
          // ),
          // 14.w.hb,
          _Option(
            title: '支付方式'.tr,
            checkedIndex: 3,
          ),
        ],
      ),
    );
  }
}

class _Option extends GetView<TradeController> {
  const _Option({super.key, required this.title, required this.checkedIndex});

  final String title;
  final int checkedIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (controller.filterIndex.value == null ||
                controller.filterIndex.value != checkedIndex) {
              controller.filterIndex.value = checkedIndex;
            } else {
              controller.filterIndex.value = null;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: checkedIndex == controller.filterIndex.value
                      ? Config.kTheme!.text2
                      : Config.kTheme!.text2,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Config.kTheme!.text2,
              )
            ],
          ),
        ));
  }
}
