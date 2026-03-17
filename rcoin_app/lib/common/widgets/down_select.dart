import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/app.dart';

class DownSelect extends StatelessWidget {
  const DownSelect({
    super.key,
    required this.title,
    this.selected = false,
    this.open = false,
  });

  final String title;
  final bool selected;
  final bool open;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.w,
            color:
                selected ? context.appColors.primary : const Color(0xff666666),
          ),
        ),
        Icon(
          open ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
          color: selected ? context.appColors.primary : const Color(0xff666666),
          size: 20,
        )
      ],
    );
  }
}
