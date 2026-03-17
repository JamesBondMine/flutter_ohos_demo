import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/mine/controllers/mine_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/account_detail_controller.dart';

class AccountNickView extends StatefulWidget {
  const AccountNickView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AccountNickViewState();
  }
}

class AccountNickViewState extends State<AccountNickView> {
  TextEditingController _nickController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nickController.text = UserService.to.user.value.nickName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _card([
                _cell(() {}, "登录账号".tr,
                    des: '${UserService.to.user.value.nickName}' ?? '',
                    showArrow: false),
              ]),
            ],
          ),
        ),
      ),
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
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Text(
              '修改昵称'.tr,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.text1),
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

  Widget _card(List<Widget> childrren) {
    return Container(
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      child: Column(children: childrren),
    );
  }

  Widget _cell(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Config.kTheme!.text1,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 44,
            child: TextField(
              controller: _nickController,
              enabled: true,
              textAlign: TextAlign.end,
              style: TextStyle(color: Config.kTheme!.text1),
              onChanged: (value) {
                // 更新昵称
                //
              },
              onSubmitted: (value) {
                AccountDetailController.to.saveNickname(value);
              },
              decoration: outlineInputDecoration.copyWith(
                  hintText: '请输入'.tr,
                  hintStyle:
                      TextStyle(fontSize: 13, color: Config.kTheme!.text2),
                  focusColor: Config.kTheme!.text2,
                  fillColor: Colors.black.withOpacity(0)),
            ),
          )),
          GestureDetector(
            onTap: () {
              _nickController.text = "";
            },
            child: Container(
              width: 20,
              height: 56,
              margin: EdgeInsets.only(right: 13.w),
              alignment: Alignment.center,
              child: const Icon(
                Icons.close_rounded,
                size: 20,
                color: Color(0xff6d6d6d),
              ),
            ),
          )
        ],
      ),
    );
  }
}
