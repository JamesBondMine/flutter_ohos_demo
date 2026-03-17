import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class TradeOrdersTab extends StatefulWidget {
  TradeOrdersTab({
    super.key,
    this.labelPadding,
    required this.controller,
  });

  final EdgeInsetsGeometry? labelPadding;

  final TabController controller;
  final Color selectColor = Config.kTheme!.text1;
  final Color unSelectColor = Config.kTheme!.text2;

  @override
  State<StatefulWidget> createState() {
    return TradeOrdersTabState();
  }
}

class TradeOrdersTabState extends State<TradeOrdersTab> {
  int selecctIndex = 0;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: widget.labelPadding,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Config.kTheme!.text1,
      unselectedLabelColor: Config.kTheme!.text2,
      labelStyle: TextStyle(fontSize: 13.sp, color: widget.selectColor),
      indicatorColor: Colors.transparent,
      onTap: (value) {
        setState(() {
          selecctIndex = value;
        });
      },
      // indicator: BoxDecoration(
      //   borderRadius: BorderRadius.circular(2.w),
      //   color: Color(0xff48484a),
      // ),
      tabs: [
        Container(
          height: 26,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  color: selecctIndex == 0
                      ? Config.kTheme!.text1
                      : Config.kTheme!.text2,
                  width: 0.8)),
          child: Text(
            '全部'.tr,
            style: TextStyle(
                color: selecctIndex == 0
                    ? widget.selectColor
                    : widget.unSelectColor,
                fontSize: 13.sp),
          ),
        ),
        Container(
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  color: selecctIndex == 1
                      ? Config.kTheme!.text1
                      : Config.kTheme!.text2,
                  width: 0.8)),
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          child: Text(
            '进行中'.tr,
            style: TextStyle(
                color: selecctIndex == 1
                    ? widget.selectColor
                    : widget.unSelectColor,
                fontSize: 13.sp),
          ),
        ),
        Container(
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  color: selecctIndex == 2
                      ? Config.kTheme!.text1
                      : Config.kTheme!.text2,
                  width: 0.8)),
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          child: Text(
            '已完成'.tr,
            style: TextStyle(
                color: selecctIndex == 2
                    ? Config.kTheme!.text1
                    : Config.kTheme!.text2,
                fontSize: 13.sp),
          ),
        ),
        Container(
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  color: selecctIndex == 3
                      ? Config.kTheme!.text1
                      : Config.kTheme!.text2,
                  width: 0.8)),
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 1.w),
          child: Text(
            '已取消'.tr,
            style: TextStyle(
                color: selecctIndex == 3
                    ? Config.kTheme!.text1
                    : Config.kTheme!.text2,
                fontSize: 13.sp),
          ),
        ),
      ],
      controller: widget.controller,
    );
  }
}
