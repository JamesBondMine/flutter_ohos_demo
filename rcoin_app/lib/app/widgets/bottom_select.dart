import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class BottomSelect<T> extends StatefulWidget {
  const BottomSelect({
    super.key,
    required this.title,
    required this.options,
    this.selectOptions = const [],
    this.isMulti = false,
    this.onSelect,
  });

  final String title;
  final List<(String, T)> options;
  final List<T> selectOptions;
  final bool isMulti;
  final void Function(List<T>)? onSelect;

  @override
  State<BottomSelect> createState() => _BottomSelectState<T>();
}

class _BottomSelectState<T> extends State<BottomSelect> {
  List<T> selectOptions = [];

  @override
  void initState() {
    super.initState();
    selectOptions = widget.selectOptions as List<T>;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];
    for (var option in widget.options) {
      options.add(GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget.isMulti) {
            var selected = selectOptions.contains(option.$2);
            if (selected) {
              selectOptions.remove(option.$2);
            } else {
              selectOptions.add(option.$2);
            }
          } else {
            selectOptions = [option.$2];
          }

          setState(() {});
          widget.onSelect?.call(selectOptions);
          if (!widget.isMulti) {
            Get.back(result: option.$2);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: context.appColors.primary.withOpacity(.1),
          ),
          margin: EdgeInsets.only(bottom: 12).w,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  6.w.hb,
                  Text(
                    option.$1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.text1,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.isMulti && selectOptions.contains(option.$2),
                child: CustomImage(
                  Assets.tradeChecked,
                  width: 20.w,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)).r,
        ),
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 42.w,
                height: 6.w,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xffEDEDED),
                ),
              ),
            ),
            20.w.vb,
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff333333),
              ),
            ),
            20.w.vb,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: options,
            )
          ],
        ),
      ),
    );
  }
}

bottomSelect<T>({
  required String title,
  required List<(String, T)> options,
  List<T> selectOptions = const [],
  bool isMulti = false,
  void Function(List<T>)? onSelect,
}) async {
  return await Get.bottomSheet(
    BottomSelect(
        title: title,
        options: options,
        selectOptions: selectOptions,
        isMulti: isMulti,
        onSelect: onSelect),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
    isScrollControlled: true,
  );
}
