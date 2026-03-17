import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/config.dart';
import 'package:otc_app/support_files/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.width,
    required this.height,
    this.radius,
    this.borderSide = BorderSide.none,
    this.onPressed,
    this.title,
    this.backgroundColor,
    this.titleStyle,
    this.elevation,
    this.padding,
    this.child,
  });

  final double width;
  final double height;
  final double? radius;
  final BorderSide borderSide;
  final Function()? onPressed;
  final String? title;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final double? elevation;
  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // return CupertinoButton(
    //     minSize: null,
    //     padding:
    //         padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
    //     color: backgroundColor ?? context.appColors.primary,
    //     borderRadius: BorderRadius.circular(radius ?? 4.w),
    //     onPressed: onPressed,
    //     child: Text(
    //       title,
    //       style: titleStyle ??
    //           TextStyle(
    //             fontSize: 17.sp,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.white,
    //           ),
    //     ));
    return SizedBox(
      // width: width,
      // height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Config.kTheme!.bgbtn,

            disabledBackgroundColor: context.appColors.primary.withOpacity(.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 40),
              side: borderSide,
            ),
            elevation: elevation,
            fixedSize: Size(width, height),
            minimumSize: Size.zero,
            // Set this
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: child ??
              Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: backgroundColor != null
                        ? null
                        : const LinearGradient(colors: [
                            Color.fromARGB(255, 215, 244, 250),
                            Color(0xffB7F1Fc),
                            Color(0xffB7F1Fc)
                          ])),
                child: Text(
                  title ?? '',
                  style: titleStyle ??
                      TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Config.kTheme!.text1,
                      ),
                ),
              )),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    this.radius,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.titleStyle,
    this.elevation,
    this.padding,
  });

  final double? radius;
  final Function() onPressed;
  final String title;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final double? elevation;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        minSize: null,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
        color: backgroundColor ?? context.appColors.primary,
        borderRadius: BorderRadius.circular(radius ?? 4.w),
        onPressed: onPressed,
        child: Text(
          title,
          style: titleStyle ??
              TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ));
  }
}
