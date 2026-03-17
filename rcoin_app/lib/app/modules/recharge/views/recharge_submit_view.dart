import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:otc_app/common/widgets/count_down.dart';
import 'package:otc_app/models/chain_type.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/recharge_controller.dart';

class RechargeSubmitView extends GetView<RechargeController> {
  const RechargeSubmitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: controller.obx(
        (state) => ListView(
          controller: controller.scrollController,
          children: [
            _sellerView(),
            _codeView(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.w.vb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                          width: Get.width / 2 - 29,
                          height: 52.w,
                          title: '保存'.tr,
                          radius: 8,
                          backgroundColor: Colors.transparent,
                          borderSide: BorderSide(
                              color: Config.kTheme!.text1.withOpacity(0.5),
                              width: 0.8),
                          // titleStyle: TextStyle(
                          //   color: Config.kTheme!.text2,
                          //   fontSize: 14.sp,
                          // ),
                          onPressed: () async {
                            await saveImage2Gallery(_boundaryKey);
                            Toast.showSuccess('保存成功'.tr);
                          }),
                      16.w.hb,
                      AppButton(
                        width: Get.width / 2 - 29,
                        height: 52.w,
                        title: '分享'.tr,
                        radius: 8,
                        // titleStyle: TextStyle(
                        //   color: Config.kTheme!.text1,
                        //   fontSize: 14.sp,
                        // ),
                        // backgroundColor: Config.kTheme!.bgbtn,
                        onPressed: () async {
                          // Get.dialog(const ShareAppDialog());
                          final imageData = await captureImage(_boundaryKey);
                          final file = await saveImage(imageData);
                          Share.shareXFiles([
                            XFile(file.path),
                          ]);
                        },
                      ),
                    ],
                  ),
                  16.w.vb,
                ],
              ),
            )
          ],
        ),
        onLoading: SpinKitFadingCircle(
          size: 25,
          color: Theme.of(context).dividerColor,
        ),
        onError: (String? error) => Center(
          child: Text('${'加载地址失败'.tr}:$error'),
        ),
      ),
    );
  }

  Widget _sellerView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
        padding: EdgeInsets.only(top: 20.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "${'充值金额'.tr}（${Config.coinName}）",
              style: TextStyle(
                color: Config.kTheme!.text1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          9.w.vb,
          Text(
            controller.editingController.text,
            style: TextStyle(
              color: Config.kTheme!.text1,
              fontSize: 36.sp,
            ),
          ),
          Container(
            width: Get.width - 52,
            height: 0.5,
            margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
            color: Config.kTheme!.text2.withOpacity(0.5),
          ),
          8.w.vb,
          Padding(
            padding: EdgeInsets.only(bottom: 10.w, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '您的购买地址'.tr,
                    style:
                        TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                  ),
                ),
                SizedBox(
                  width: Get.width - 195,
                  height: 60,
                  child: Text(
                    '${controller.currentAddress?.address}',
                    maxLines: 2,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Config.kTheme!.text1,
                    ),
                  ),
                ),
                CopyBtn(
                    text: "${controller.currentAddress?.address}", size: 12.w),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20.w, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '剩余时间 '.tr,
                    style:
                        TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                  ),
                  const Spacer(),
                  Container(
                    // width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffBE8F4F)),
                    child: CountDown(
                      seconds: controller.countDown,
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      changed: (value) {
                        if (value == 0) {
                          Toast.showInfo("订单已取消".tr);
                          Get.back();
                        }
                      },
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 0.w, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '需支付金额（USDT）'.tr,
                    style:
                        TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                  ),
                ),
                SizedBox(
                  width: Get.width - 195,
                  height: 60,
                  child: Text(
                    '${controller.realNum.value}',
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Config.kTheme!.text1,
                    ),
                  ),
                ),
                CopyBtn(text: "${controller.realNum.value}", size: 12.w),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.w, right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text:
                        "${'支付金额必须输入'.tr}${'${controller.realNum.value}'}，${'否则订单支付无效'.tr}，${'若资金未到账，请'.tr}"
                            .tr,
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                  ),
                  WidgetSpan(
                      child: GestureDetector(
                    onTap: () {
                      ChatService.to.goChatWithService();
                    },
                    child: Text(
                      "联系客服".tr,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Config.kTheme!.text2,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
                ])),
              ))
        ]));
  }

  Widget _codeView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
        padding: EdgeInsets.only(top: 20.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("区块链浏览器".tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Config.kTheme!.text1,
                  )),
              12.w.vb,
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      '${controller.currentAddress?.serviceUrl}${controller.currentAddress?.address}'));
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  margin: EdgeInsets.only(right: 10.w, bottom: 30.w),
                  decoration: BoxDecoration(
                    color: Config.kTheme!.text2.withOpacity(0.08),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    '${controller.currentAddress?.serviceUrl}${controller.currentAddress?.address}',
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff6d6d6d)),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => RepaintBoundary(
                    key: _boundaryKey,
                    child: Container(
                        width: 140.w,
                        height: 140.w,
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              // borderRadius:
                              //     BorderRadius.all(Radius.circular(12)),
                            ),
                            child: QrImageView(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              // padding: const EdgeInsets.all(25),
                              embeddedImage: const AssetImage(Assets.iconIcon),
                              eyeStyle: const QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: Colors.white,
                              ),
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: Colors.white,
                              ),
                              data: '${controller.currentAddress?.address}',
                            ))),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              '二维码'.tr,
              style: TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
            ),
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
              '充值'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.RECHARGE_LOGS);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 14.w),
                  width: 48.w,
                  height: 48.w,
                  alignment: Alignment.center,
                  child: Text(
                    "详情".tr,
                    style: TextStyle(color: Config.kTheme!.text1),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

final GlobalKey _boundaryKey = GlobalKey();

class _InputAndQrview extends GetView<RechargeController> {
  const _InputAndQrview({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${'充值金额'.tr}（${Config.coinName}）",
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xff333333),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          9.w.vb,
          Text(
            controller.editingController.text,
            style: TextStyle(
              color: const Color(0xffC478FF),
              fontSize: 36.sp,
            ),
          ),
          8.w.vb,
        ],
      ),
    );
  }
}

class Chains extends GetView<RechargeController> {
  const Chains({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => ChainOption(
            title: 'TRC20',
            logo: Assets.rechargeTrc,
            selected: controller.chainType.value == ChainType.trc20,
            onTap: () {
              controller.chainType.value = ChainType.trc20;
            })),
        21.w.hb,
        Obx(() => ChainOption(
            title: 'ERC20',
            logo: Assets.rechargeErc,
            selected: controller.chainType.value == ChainType.erc20,
            onTap: () {
              controller.chainType.value = ChainType.erc20;
            })),
      ],
    );
  }
}

class ChainOption extends StatelessWidget {
  const ChainOption(
      {super.key,
      required this.title,
      required this.logo,
      required this.selected,
      required this.onTap});

  final String title;
  final String logo;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 32.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4).r,
                color: const Color(0xff48484a),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(
                    logo,
                    width: 18.w,
                  ),
                  3.w.hb,
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomImage(
                Assets.rechargeIntersect,
                width: 27.w,
              ),
            )
          ],
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 32.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: Colors.white,
          border: Border.all(color: const Color(0xffE7E7E7), width: 1.w),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              logo,
              width: 18.w,
            ),
            3.w.hb,
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xffAEAEAE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
