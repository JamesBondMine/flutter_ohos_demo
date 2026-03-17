import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/auth/pages/auth_IDcard_page.dart';
import 'package:otc_app/app/widgets/button.dart';

class AuthResultPage extends StatefulWidget {
  AuthResultPage({Key? key, required this.success}) : super(key: key);

  bool success = false;
  @override
  State<StatefulWidget> createState() {
    return AuthResultPageState();
  }
}

class AuthResultPageState extends State<AuthResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerView(context),
      backgroundColor: Config.kTheme!.bgMain,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: Get.width - 32,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff131313)),
            child: _childrenView(context),
          )
        ],
      ),
    );
  }

  Widget _footerView(BuildContext context) {
    return Container(
      child: AppButton(
        width: Get.width - 40.w,
        height: 52.w,
        title: widget.success ? "确认".tr : '下一步'.tr,
        titleStyle: TextStyle(color: Color(0xff5d4c30)),
        backgroundColor: const Color(0xfff4e0bd),
        onPressed: () {
          if (widget.success) {
            Get.back();
            return;
          }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AuthIDCardPage()));
        },
        radius: 8.w,
      ),
    );
  }

  Widget _childrenView(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 20, bottom: 20.w),
          alignment: Alignment.center,
          child: CustomImage(
            widget.success ? Assets.loginRegisterPinSuccess : Assets.authFail,
            width: 120.w,
            height: 120.w,
          ),
        ),
        Text(widget.success ? '审核通过'.tr : '审核失败'.tr,
            style: TextStyle(
              fontSize: 18.sp,
              color: Color(0xffffffff),
            )),
        SizedBox(
          height: 10.w,
        ),
        Text(widget.success ? '实名认证通过开通交易权限'.tr : '请核查身份信息是否有误并重新提交'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: Color(0xff9b9d9c),
            )),
        SizedBox(
          height: 50.w,
        ),
        _footerView(context),
        SizedBox(
          height: 20.w,
        ),
      ],
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Text(
              'authentication'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Color(0xffffffff),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 14.w), width: 48.w, height: 48.w)
          ],
        ),
      ),
    );
  }
}
