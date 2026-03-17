import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/app.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.textField,
    this.topPadding,
  });

  final String title;
  final TextField textField;
  final double? topPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: topPadding ?? 16.w,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: context.appColors.text1,
          ),
        ),
        5.w.vb,
        textField,
      ],
    );
  }
}

class SelectItem {
  final String title;
  final String icon;
  final String activeIcon;

  SelectItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

class Select extends StatefulWidget {
  const Select(
      {super.key,
      required this.items,
      required this.onTap,
      this.currentIndex = 0});

  final List<SelectItem> items;
  final int currentIndex;

  final Function(int index) onTap;

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  bool usePhone = true;
  late int activeIndex;

  @override
  void initState() {
    activeIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];

      if (i == activeIndex) {
        children.add(Expanded(
          flex: 1,
          child: Container(
            height: 32.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              color: context.appColors.primary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(item.activeIcon),
                SizedBox(width: 6.w),
                Text(item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ));
      } else {
        children.add(Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              activeIndex = i;
              widget.onTap(i);
              setState(() {});
            },
            child: Container(
              height: 32.w,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(item.icon),
                  SizedBox(width: 6.w),
                  Text(item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff666666),
                      ))
                ],
              ),
            ),
          ),
        ));
      }
    }

    return Container(
      width: 162.w,
      height: 32.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: context.appColors.primary,
            width: 1.w,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
