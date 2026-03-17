import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/widgets/circle_leading.dart';

import '../controllers/language_switch_controller.dart';

class LanguageSwitchView extends GetView<LanguageSwitchController> {
  const LanguageSwitchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var locale in locales) {
      children.add(_Row(
          locale: locale.$1,
          title: locale.$2,
          checked: Get.locale?.languageCode == locale.$1.languageCode &&
              Get.locale?.countryCode == locale.$1.countryCode,
          onTap: () {
            AppService.to.setLocale(locale.$1);
          }));
      children.add(14.w.vb);
    }
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        appBar: _headerView(context),
        body: Column(
          children: [_card(children)],
        ));
  }

  Widget _card(List<Widget> childrren) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      child: Column(children: childrren),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios,
                    size: 16, color: Config.kTheme!.text1),
              ),
            ),
            Text(
              '语言'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    super.key,
    required this.locale,
    required this.title,
    required this.onTap,
    this.checked = false,
  });

  final Locale locale;
  final String title;
  final VoidCallback onTap;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            height: 36.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              // color: const Color(0xfff4f4f4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Config.kTheme!.text1,
                    // fontWeight: checked ? FontWeight.bold : null,
                  ),
                ),
                Container(
                  child: checked
                      ? const CustomImage(
                          Assets.ptSelect,
                        )
                      : null,
                ),
              ],
            )));
  }
}
