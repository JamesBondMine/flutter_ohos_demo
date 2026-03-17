import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/app.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.child,
    this.showNotification = false,
  });

  final Widget child;
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 2,
          top: 2,
          child: Visibility(
            visible: showNotification,
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appColors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}
