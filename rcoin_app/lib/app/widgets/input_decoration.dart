import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var inputDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xff999999)),
  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xffEFEFEF), // 自定义焦点时的边框颜色
      width: 1.w, // 自定义焦点时的边框宽度
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: const Color(0xff999999), // 自定义焦点时的边框颜色
      width: 1.w, // 自定义焦点时的边框宽度
    ),
  ),
);

final outlineInputDecoration = InputDecoration(
  isDense: true,
  isCollapsed: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.w),
  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  hintStyle: TextStyle(
    fontSize: 16.sp,
    color: const Color(0xff999999),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.w),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.w),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.w),
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: Color(0xfff6f6f6),
);
