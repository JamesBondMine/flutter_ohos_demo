import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/extensions/intl.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/share_page_controller.dart';

final GlobalKey _boundaryKey = GlobalKey();

class SharePageView extends GetView<SharePageController> {
  const SharePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primary,
      appBar: AAppBar(
        title: '分享有礼'.tr,
        backgroundColor: Colors.transparent,
        backIconColor: Colors.white,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: _boundaryKey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16).r,
                  child: SizedBox(
                    width: 300.w,
                    height: 533.w,
                    child: Stack(
                      children: [
                        CustomImage(
                          Assets.imagesShareApp,
                          width: 323.w,
                          height: 573.w,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 76.w,
                          child: Container(
                            alignment: Alignment.center,
                            child: controller.obx((state) => QrImageView(
                              size: 155.w,
                              padding: const EdgeInsets.all(5),
                              data:
                              '${state?.shareUrl}=${UserService.to.user.value.inviteCode}',
                              backgroundColor: Colors.white,
                            )),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 320.w,
                          child: Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 170.w,
                              child: controller.obx((state) => Text(
                                '${state?.rewardSetting}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFFD9B23F),
                                  fontSize: 16,
                                ),
                              )),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 443.w,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomImage(
                                    Assets.imagesLogo,
                                    width: 50.w,
                                  ),
                                ),
                                Text(
                                  Config.appName,
                                  style: TextStyle(
                                    color: context.appColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              25.w.vb,
              controller.obx(
                    (state) => Column(
                  children: [
                    Text(
                      'shareTip1'.trans({
                        'limit': state?.limit?.rtz,
                        'coinName': Config.coinName,
                      }),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'shareTip2'.trans({
                        'reward':state?.reward?.rtz,
                        'coinName': Config.coinName,
                      }),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              29.w.vb,
              GestureDetector(
                onTap: () {
                  saveImage2Gallery(_boundaryKey).then((value) {
                    Toast.showSuccess('保存成功'.tr);
                  });
                },
                child: Container(
                  width: 315.w,
                  height: 42.w,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: StadiumBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '保存图片'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
