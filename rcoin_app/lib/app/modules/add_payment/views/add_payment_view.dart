import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/wechat_picker.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/add_payment_controller.dart';

class AddPaymentView extends GetView<AddPaymentController> {
  const AddPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      resizeToAvoidBottomInset: false,
      appBar: _headerView(context, "添加支付账号".tr),
      body: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
        child: GetBuilder<AddPaymentController>(
            id: controller.paymentTypeSelectRefreshId,
            builder: (v) {
              return _bodyView(context);
            }),
      ),
    );
  }

  List<String> get pts => [
        Assets.orderPpmentTxt1,
        Assets.orderPpmentTxt2,
        Assets.orderPpmentTxt3,
        Assets.orderPpmentTxt4,
        Assets.orderPpmentTxt51,
        Assets.orderPpmentTxt6
      ];
  List<String> get ptsel => [
        Assets.orderPpmentSel1,
        Assets.orderPpmentSel2,
        Assets.orderPpmentSel3,
        Assets.orderPpmentSel4,
        Assets.orderPpmentSel5,
        Assets.orderPpmentSel6
      ];

  Widget _qrcodeView(BuildContext context, Payment? payment) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
      width: Get.width - 32,
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1, borderRadius: BorderRadius.circular(8)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('上传二维码'.tr,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Config.kTheme!.text1,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 16.w),
            Row(
              children: [
                _qrselectItem(context, payment),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('上传支付二维码'.tr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Config.kTheme!.text2,
                            fontWeight: FontWeight.w500)),
                    5.w.vb,
                    SizedBox(
                      width: Get.width / 2 - 30,
                      child: Text('点击这里上传支付二维码你可以用这个二维码出售或者购买RSO'.tr,
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Config.kTheme!.text2,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                )
              ],
            )
          ]),
    );
  }

  Widget _qrselectItem(BuildContext context, Payment? payment) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          final res =
              await pickAssetEntity(context: context, maxAssetsCount: 1);
          if (res != null && res.isNotEmpty) {
            final entity = res.first;
            final file = await entity.file;
            final qr = await detectQrcode(file!);
            if (qr == null) {
              Toast.showError('请选择包含二维码图片'.tr);
              return;
            }
            controller.qrcodeImg.value = res.first;
          }
        },
        child: Obx(
          () => controller.qrcodeImg.value == null &&
                  controller.payment?.img == null
              ? Container(
                  width: 102.w,
                  height: 102.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      // color: const Color(0xfff6f6f6),
                      border:
                          Border.all(color: Config.kTheme!.text2, width: 0.8)),
                  child: Icon(
                    Icons.add,
                    color: Config.kTheme!.text2,
                    size: 30.w,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(4.w),
                  child: SizedBox(
                    width: 112.w,
                    height: 112.w,
                    child: _qrImageView(payment),
                  ),
                ),
        ));
  }

  Widget _qrImageView(Payment? payment) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: payment?.img == null
                  ? AssetEntityImage(
                      controller.qrcodeImg.value!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(payment!.img!),
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                controller.qrcodeImg.value = null;
                controller.payment?.img = null;
              },
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: const Text(
                  "一",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ))
      ],
    );
  }

  Map<String, PaymentType> get paymentMaps => {
        "5": PaymentType.upi,
        "6": PaymentType.paytm,
        "7": PaymentType.gpay,
        "8": PaymentType.phonepe,
        "9": PaymentType.amazonPay,
        "10": PaymentType.digitalRupees
      };

  Widget _paymentTypeSelectView(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
        width: Get.width - 32,
        decoration: BoxDecoration(
            color: Config.kTheme!.bg1, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account info'.tr,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Config.kTheme!.text1,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.w),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.w,
              children: List.generate(
                pts.length,
                (index) => GestureDetector(
                  onTap: () {
                    controller.paymentType =
                        paymentMaps["${index + 5}"] ?? PaymentType.upi;
                    controller.updatePaymentTypeSelectRefresh();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.paymentType.value == (index + 5)
                            ? Config.kTheme!.bgdark
                            : Config.kTheme!.bgdark.withOpacity(0.5)),
                    height: 44.w,
                    width: (Get.width - 80) / 3,
                    child: CustomImage(
                      controller.paymentType.value == (index + 5)
                          ? "${ptsel[index]}"
                          : "${pts[index]}",
                      color: controller.paymentType.value == (index + 5)
                          ? Config.kTheme!.text1
                          : Config.kTheme!.text2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text('账户名'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Config.kTheme!.text2,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  height: 40,
                  width: Get.width - 160,
                  child: TextField(
                    controller: controller.nameCtrl,
                    // enabled: canEdit,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white),
                    decoration: outlineInputDecoration.copyWith(
                        hintText: '请输入账户名'.tr,
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xff6d6d6d)),
                        focusColor: Colors.white,
                        fillColor: Colors.black.withOpacity(0)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text('账户号'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Config.kTheme!.text2,
                      )),
                ),
                SizedBox(
                  // margin:const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  width: Get.width - 160,
                  child: TextField(
                    controller: controller.accountCtrl,
                    // enabled: canEdit,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white),
                    decoration: outlineInputDecoration.copyWith(
                        hintText:
                            '${'请输入'.tr} ${controller.paymentType.name} ${'账号'.tr}',
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xff6d6d6d)),
                        focusColor: Colors.white,
                        fillColor: Colors.black.withOpacity(0)),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget _bodyView(BuildContext context) {
    // final TextStyle inputStyle =
    //     TextStyle(fontSize: 14.sp, color: context.appColors.text1);
    // PaymentType paymentType = Get.arguments['type'];
    Payment? payment = Get.arguments['payment'];
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.all(0),
      children: [
        _paymentTypeSelectView(context),
        _qrcodeView(context, payment),
        SizedBox(
          height: 12.w,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              //C478FF
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                // color: Color.fromRGBO(196, 120, 255, 0.15),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '温馨提醒:'.tr,
                      style: TextStyle(
                          color: Config.kTheme!.text1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${'点击此处上传您的'.tr} ${controller.paymentType.text} ${'收付款二维码，您可以使用此二维码进行买卖'.tr}',
                    style: TextStyle(
                      color: Config.kTheme!.text2,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        AppButton(
          width: 343.w,
          height: 48.w,
          radius: 8,
          // titleStyle: TextStyle(color: Config.kTheme!.text1),
          backgroundColor: Config.kTheme!.bgbtn,
          onPressed: payment == null
              ? throttle(controller.createData, 2000)
              : throttle(controller.updateData, 2000),
          title: '保存'.tr,
        )
      ],
    );
  }

  PreferredSize _headerView(BuildContext context, String title) {
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
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
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

class _ChannelInterval extends StatelessWidget {
  const _ChannelInterval({super.key, required this.channel});

  final TradePaymentChannel channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 22,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE5E5E5)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        channel.name ?? '',
        style: TextStyle(
          color: const Color(0xFF999999),
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
