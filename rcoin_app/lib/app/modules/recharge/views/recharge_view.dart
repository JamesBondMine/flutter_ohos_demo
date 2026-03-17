import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/extensions/intl.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/chain_type.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/recharge_controller.dart';

class RechargeView extends GetView<RechargeController> {
  const RechargeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        appBar: _headerView(context),
        body: ListView(
          controller: controller.scrollController,
          children: [
            _sellerView(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.w.vb,
                  Text("温馨提示".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Config.kTheme!.text1,
                      )),
                  10.w.vb,
                  Container(
                    width: 341.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4).r,
                    ),
                    child: Obx(() => Text.rich(TextSpan(
                          children: [
                            TextSpan(
                                text: 'chargeTip'.trans({
                                  'chainType': controller.chainType.toString(),
                                }),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Config.kTheme!.text2))
                          ],
                        ))),
                  ),
                  25.w.vb,
                  Center(
                    child: AppButton(
                      width: Get.width - 32,
                      height: 52.w,
                      radius: 8,
                      onPressed: controller.recharge,
                      title: '提交'.tr,
                      titleStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Config.kTheme!.text1,
                      ),
                    ),
                  ),
                  16.w.vb,
                ],
              ),
            )
          ],
        ));
  }

  Widget _sellerView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
        padding: EdgeInsets.only(top: 16.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 10.w, right: 10),
                  child: Text(
                    '选择公链协议'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      // fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          const Chains(),
          controller.obx(
              (state) => Container(
                    padding: EdgeInsets.only(top: 20.w),
                    margin: EdgeInsets.only(right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(bottom: 0.w, right: 10),
                                child: Text(
                                  "${'金额'.tr}(RSO)",
                                  style: TextStyle(
                                    color: Config.kTheme!.text1,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                        const _InputAndQrview(),
                        Container(
                          width: Get.width - 52,
                          height: 0.8,
                          margin: const EdgeInsets.only(
                              right: 10, top: 1, bottom: 1),
                          color: const Color(0xff6d6d6d),
                        ),
                        16.w.vb,
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
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  color: Config.kTheme!.text2.withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Text(
                                  '${controller.currentAddress?.serviceUrl ?? ""}${controller.currentAddress?.address ?? ""}',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff6d6d6d)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              onLoading: SpinKitFadingCircle(
                size: 25,
                color: Config.kTheme!.text2,
              ),
              onError: (String? error) => Center(
                    child: Text('${'加载地址失败'.tr}:$error'),
                  )),
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
    return Row(
      children: [
        Expanded(
            child: TextField(
          textAlign: TextAlign.left,
          controller: controller.editingController,
          style: TextStyle(fontSize: 24.sp, color: Config.kTheme!.text2),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputFormatters: [
            positiveNumberFormatter,
          ],
          decoration: outlineInputDecoration.copyWith(
            fillColor: Colors.transparent,
            hintText: '请输入金额'.tr.trans({'coin': Config.coinName}),
            hintStyle:
                TextStyle(fontSize: 20.sp, color: const Color(0xff6d6d6d)),
          ),
        )),
        Container(
          height: 23.w,
          width: 160.w,
          alignment: Alignment.center,
          child: Obx(() => Visibility(
                visible: controller.equalNum.value != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${'预估'.tr}USDT：${controller.equalNum.value}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFf9b9b9b),
                      ),
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 7, right: 9).w,
      height: 1.w,
      color: context.appColors.divider2,
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
        10.w.hb,
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
              width: Get.width / 2 - 40,
              height: 44.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  // color: const Color(0xff48484a),
                  border: Border.all(color: Color(0xff28A1FF), width: 1)),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImage(
                    logo,
                    width: 18.w,
                  ),
                  10.w.hb,
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Config.kTheme!.text1,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 28,
                height: 16,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Color(0xff28A1FF),
                ),
                child: CustomImage(
                  Assets.rechageR,
                  width: 27.w,
                  color: Config.kTheme!.bg1,
                ),
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
        width: Get.width / 2 - 40,
        height: 44.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8).r,
            // color: const Color(0xff48484a),
            border: Border.all(
                color: Config.kTheme!.text2.withOpacity(0.5), width: 0.7)),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImage(
              logo,
              width: 18.w,
            ),
            10.w.hb,
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xffAEAEAE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
