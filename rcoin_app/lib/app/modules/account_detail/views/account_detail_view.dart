import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/account_detail/views/account_nickName_view.dart';
import 'package:otc_app/app/modules/mine/controllers/mine_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/account_detail_controller.dart';

class AccountDetailView extends GetView<AccountDetailController> {
  const AccountDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String account = "";
    if (UserService.to.user.value.phone != null &&
        UserService.to.user.value.phone!.isNotEmpty) {
      account = UserService.to.user.value.phone!;
    } else if (UserService.to.user.value.email != null &&
        UserService.to.user.value.email!.isNotEmpty) {
      account = UserService.to.user.value.email!;
    }
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
                _cell(() {}, "登录账号".tr, des: account, showArrow: false),
                Obx(() => _cell1(() {
                      UserService.to.uploadAvatar(context);
                    }, "用户头像".tr)),
                Obx(() => _cell(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountNickView()),
                      );
                    }, "用户昵称".tr,
                        des: UserService.to.user.value.nickName ?? '')),
              ]),
              8.w.vb,
              _card([
                _cell(() {
                  Get.toNamed(Routes.SET_PAY_PASSWORD, arguments: {
                    "type": 2,
                  });
                }, "登录密码".tr),
                _cell(() {
                  Get.toNamed(Routes.SET_PAY_PASSWORD, arguments: {
                    "type": 1,
                  });
                }, "交易密码".tr),
              ]),
              8.w.vb,
              Center(
                child: AppButton(
                  width: Get.width - 32,
                  height: 50.w,
                  backgroundColor: Config.kTheme!.bg1,
                  onPressed: () async {
                    bool? result = await confirmBottomSheet(
                        title: '确定退出'.tr, subTitle: '您确定要退出登录吗?'.tr);
                    if (result != null && result) {
                      UserService.to.logout();
                    }
                  },
                  title: '退出登录'.tr,
                  radius: 8.w,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xffE73463),
                  ),
                ),
              ),
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
                child: Icon(Icons.arrow_back_ios,
                    size: 16, color: Config.kTheme!.text1),
              ),
            ),
            Text(
              '账户中心'.tr,
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

  Widget _card(List<Widget> childrren) {
    return Container(
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      child: Column(children: childrren),
    );
  }

  Widget _cell1(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            const Spacer(),
            UserService.to.user.value.headerImg != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: UserService.to.user.value.headerImg ?? "",
                      width: 28.w,
                      height: 28.w,
                      // ,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) {
                        return CustomImage(
                          Assets.userIcon7,
                          width: 20.w,
                          height: 20.w,
                          color: Config.kTheme!.text1,
                        );
                      },
                    ),
                  )
                : CustomImage(
                    Assets.userIcon7,
                    width: 28.w,
                    height: 28.w,
                    color: Config.kTheme!.text1,
                  ),
            showArrow
                ? Icon(
                    Icons.keyboard_arrow_right,
                    color: Config.kTheme!.text1,
                    size: 20,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _cell(VoidCallback onTap, String title,
      {String des = "", bool showArrow = true}) {
    return Container(
      height: 56.w,
      decoration: BoxDecoration(
        color: Config.kTheme!.bg1,
        borderRadius: BorderRadius.circular(10).w,
      ),
      alignment: Alignment.center,
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            Spacer(),
            Text(
              des,
              style: TextStyle(
                fontSize: 14.sp,
                color: Config.kTheme!.text2,
              ),
            ),
            showArrow
                ? Icon(
                    Icons.keyboard_arrow_right,
                    color: Config.kTheme!.text2,
                    size: 20,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget headImageView() {
    return GetBuilder<MineController>(
        id: MineController.to.userHeadRefreshId,
        builder: (value) {
          String headImg = UserService.to.user.value.headerImg ?? "";
          if (headImg.isNotEmpty) {
            return ClipOval(
              child: CachedNetworkImage(
                width: 80.w,
                height: 80.w,
                imageUrl: headImg,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) {
                  return _defaultHead();
                },
              ),
            );
          }
          return _defaultHead();
        });
  }

  Widget _defaultHead() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
          color: const Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(40)),
    );
  }
}
