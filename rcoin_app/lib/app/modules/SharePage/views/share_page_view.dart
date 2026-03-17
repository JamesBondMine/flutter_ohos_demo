import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/share_page_controller.dart';

final GlobalKey _boundaryKey = GlobalKey();

class SharePageView extends GetView<SharePageController> {
  const SharePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        body: Stack(
          // clipBehavior: Clip.none,
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  width: Get.width,
                  height: 300 + MediaQuery.of(context).padding.top,
                  // height: 300,
                  child: const CustomImage(
                    Assets.giftHeader,
                  ),
                )),
            Positioned.fill(child: _cardView(context))
          ],
        ));
  }

  Widget _bodybgView() {
    return Positioned(
        top: 120.w,
        left: 16,
        right: 16,
        child: Container(
          width: Get.width - 32,
          height: 470.w,
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          decoration: BoxDecoration(
            color: Config.kTheme!.bgw,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ));
  }

  Widget _userHeadView() {
    return Container(
      width: 80.w,
      height: 80.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.w),
          border: Border.all(color: Config.kTheme!.text2, width: 2.w),
          color: Colors.white),
      child: UserService.to.user.value.headerImg != null
          ? ClipOval(
              child: Image.network(
                UserService.to.user.value.headerImg ?? "",
                fit: BoxFit.fill,
              ),
            )
          : CustomImage(
              Assets.userIcon7,
              width: 80.w,
              height: 80.w,
            ),
    );
  }

  Widget _cardView(BuildContext context) {
    return Column(
      children: [
        _headerView(context),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              height: 480,
              child: _contentWidget(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    child: Text(
                      '- ${'奖励说明'.tr} -',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Config.kTheme!.text1,
                      ),
                    ),
                  ),
                  Container(
                    // width: 80.w,
                    // height: 28.w,
                    margin: EdgeInsets.only(top: 10.w, bottom: 30.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    child: Text(
                      '邀请用户注册并进行首次充值当首次充值金额满一定的rso时邀请人可额外获得rso的奖励'.tr,
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Config.kTheme!.text2,
                      ),
                    ),
                  ),
                  30.w.vb,
                ],
              ),
            )
            // _bodybgView(),
          ],
        )),
        const SizedBox(
          height: 10,
        ),
        AppButton(
          width: Get.width - 32,
          height: 52.w,
          backgroundColor: Config.kTheme!.text2.withOpacity(0),
          onPressed: () {
            saveImage2Gallery(_boundaryKey).then((value) {
              Toast.showSuccess('保存成功'.tr);
            });
          },
          borderSide: BorderSide(
              color: Config.kTheme!.text2.withOpacity(
                0.5,
              ),
              width: 0.5),
          radius: 8.w,
          title: '保存图片'.tr,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _contentWidget() {
    return Stack(
      children: [
        _bodybgView(),
        Positioned(
            top: 120.w,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
              child: Container(
                width: Get.width - 32,
                padding: const EdgeInsets.only(left: 17, right: 17, top: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xffC9FBD1),
                        Config.kTheme!.bgw,
                        Config.kTheme!.bgw,
                        Config.kTheme!.bgw
                      ]),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                      child: Text(
                        (UserService.to.user.value.email?.isNotEmpty ?? false)
                            ? UserService.to.user.value.email!
                            : UserService.to.user.value.phone ?? '',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Config.kTheme!.text1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140.w,
                      height: 140.w,
                      child: _qrcodeView(),
                    ),
                    Container(
                      // width: 80.w,
                      height: 28.w,
                      margin: EdgeInsets.only(top: 16.w, bottom: 10.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.w),
                          border:
                              Border.all(color: Color(0xff00C5A1), width: 1.w)),
                      child: Text(
                        '${'邀请码'.tr}: ${UserService.to.user.value.inviteCode ?? ''}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff00C5A1),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: 0.8.w,
                      color: Config.kTheme!.text2.withOpacity(0.6),
                      margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
                    ),
                  ],
                ),
              ),
            )),
        Positioned(
            top: 80.w,
            left: 16,
            right: 16,
            child: Container(
                width: Get.width - 32,
                // height: 450.w,
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(children: [
                  _userHeadView(),
                ]))),
      ],
    );
  }

  Widget _qrcodeView() {
    return RepaintBoundary(
      key: _boundaryKey,
      child: Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Color(0xff00C5A1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
              spreadRadius: 10.0,
              offset: Offset(0, 30),
            ),
          ],
        ),
        child: controller.obx((state) => QrImageView(
              padding: const EdgeInsets.all(10),
              embeddedImage: const AssetImage(Assets.iconIcon),
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.white,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.white,
              ),
              data:
                  '${state?.shareUrl}=${UserService.to.user.value.inviteCode}',
            )),
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
              '分享有礼'.tr,
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
