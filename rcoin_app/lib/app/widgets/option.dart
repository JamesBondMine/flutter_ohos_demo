import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/app.dart';

class Option<T> extends StatelessWidget {
  const Option({
    super.key,
    required this.value,
    this.title,
    this.selected = false,
    this.padding,
    this.style,
    required this.onTap,
  });

  final T value;
  final String? title;
  final bool selected;
  final Function(T value) onTap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(value);
      },
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
        decoration: BoxDecoration(
          color: selected ? context.appColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(4).r,
        ),
        child: Text(
          removeTrailingZeros(title ?? value.toString()),
          style: style ??
              TextStyle(
                fontSize: 14.sp,
                color: selected ? Colors.white : Colors.black,
              ),
        ),
      ),
    );
  }
}
