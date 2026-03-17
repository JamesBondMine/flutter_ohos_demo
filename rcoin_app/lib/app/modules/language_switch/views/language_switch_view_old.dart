import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';

import '../controllers/language_switch_controller.dart';

class LanguageSwitchView extends GetView<LanguageSwitchController> {
  const LanguageSwitchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var locale in locales) {
      children.add(_Row(
          title: locale.$2,
          onTap: () {
            AppService.to.setLocale(locale.$1);
          }));
      children.add(Divider(
        height: 1.w,
      ));
    }
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return Scaffold(
        backgroundColor: const Color(0xfff4f4f4),
        appBar: AAppBar(
          title: '语言'.tr,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
  }
}

class _Row extends StatelessWidget {
  const _Row({super.key, required this.title, required this.onTap});

  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      onTap: onTap,
      dense: true,
      leading: Text(
        title,
        style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      ),
    );
  }
}
