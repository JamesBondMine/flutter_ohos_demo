import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/advertise/controllers/advertise_buy_controller.dart';
import 'package:otc_app/app/modules/advertise/controllers/advertise_sell_controller.dart';
import 'package:otc_app/app/modules/advertise/views/advertise_view.dart';
import '../controllers/post_order_controller.dart';

class PostOrderSuccess extends GetView<PostOrderController> {
  const PostOrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [_sellerView()],
        ),
      )),
    );
  }

  Widget _sellerView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          CustomImage(Assets.loginRegisterPinSuccess),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 10.w, right: 10),
                  child: Text(
                    '发布成功'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
            ],
          ),
          SizedBox(
            // color: Colors.red,
            width: Get.width - 100,
            height: 60,
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: '已成功发布一个购买单可点击'.tr,
                  style: TextStyle(
                    color: Config.kTheme!.text2,
                    fontSize: 14.sp,
                  )),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AdvertiseBuyController.to.refreshAction();
                      AdvertiseSellController.to.refreshAction();
                      Get.off(const AdvertiseView());
                    },
                  text: '我的挂单'.tr,
                  style: TextStyle(
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  )),
              TextSpan(
                  text: '查询'.tr,
                  style: TextStyle(
                    color: Config.kTheme!.text2,
                    fontSize: 14.sp,
                  ))
            ])),
          ),
        ]));
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
              '发布'.tr,
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
            )
          ],
        ),
      ),
    );
  }
}
