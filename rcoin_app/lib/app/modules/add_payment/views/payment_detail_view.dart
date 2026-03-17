import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/payment_method/controllers/payment_method_controller.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/add_payment_controller.dart';

class PaymentIDetailView extends GetView<AddPaymentController> {
  const PaymentIDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        resizeToAvoidBottomInset: false,
        appBar: _headerView(context, "账户信息".tr),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: GetBuilder<AddPaymentController>(
                id: controller.paymentTypeSelectRefreshId,
                builder: (v) {
                  return _bodyView(context);
                }),
          ),
        ));
  }

  Map<String, dynamic> get pts => {
        "5": Assets.orderPpment1,
        "6": Assets.orderPpment2,
        "7": Assets.orderPpment3,
        "8": Assets.orderPpment4,
        "9": Assets.orderPpment5,
        "10": Assets.orderPpment6,
        // 默认
        "1": Assets.orderPpment1,
        "2": Assets.orderPpment1,
        "3": Assets.orderPpment1,
        "4": Assets.orderPpment1
      };

  Widget _qrcodeView(BuildContext context, Payment? payment) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
      width: Get.width - 32,
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1, borderRadius: BorderRadius.circular(8)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _qrselectItem(context, payment),
            SizedBox(height: 16.w),
            Text('收款二维码'.tr,
                style: TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2)),
          ]),
    );
  }

  Widget _qrselectItem(BuildContext context, Payment? payment) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.w),
      child: SizedBox(
        width: 140.w,
        height: 140.w,
        child: _qrImageView(payment),
      ),
    );
  }

  Widget _qrImageView(Payment? payment) {
    return Stack(
      children: [
        Positioned.fill(
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
        )
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
        margin: const EdgeInsets.only(top: 10),
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
        width: Get.width - 32,
        decoration: BoxDecoration(
            color: Config.kTheme!.bg1, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info'.tr,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Config.kTheme!.text1,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('支付状态'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff9b9b9b),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  height: 40,
                  // width: Get.width - 160,
                  child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                          activeColor: Config.kTheme!.bgMain,
                          focusColor: Colors.white10,
                          thumbColor: Config.kTheme!.bgw,
                          trackColor: Config.kTheme!.text2.withOpacity(0.3),
                          value: controller.enable.value,
                          onChanged: (v) {
                            // 编辑
                            controller.enable.value = !controller.enable.value;
                            controller.updatePaymentTypeSelectRefresh();
                            controller.updateData();
                          })),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('账户类型'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff9b9b9b),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  height: 20,
                  // width: Get.width - 160,
                  child: CustomImage(
                    pts["${controller.paymentType.value}"],
                    fit: BoxFit.contain,
                    color: Config.kTheme!.text2,
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  child: Text('账户名'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff9b9b9b),
                      )),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  height: 40,
                  width: Get.width - 170,
                  child: Text(
                    controller.payment != null
                        ? controller.payment!.name ?? ""
                        : "",
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(color: Config.kTheme!.text1, fontSize: 14.sp),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  child: Text('账户号'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff9b9b9b),
                      )),
                ),
                const Spacer(),
                SizedBox(
                  // margin:const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  // width: Get.width - 177,
                  child: Text(
                    controller.payment != null
                        ? controller.payment!.account ?? ""
                        : "",
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(color: Config.kTheme!.text1, fontSize: 14.sp),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget _bodyView(BuildContext context) {
    Payment? payment = Get.arguments['payment'];
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        _qrcodeView(context, payment),
        _paymentTypeSelectView(context),
        SizedBox(
          height: 2.w,
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
                    '请认真核对收款信息，并确保不要泄露，若因账户信息泄露导致交易异常，平台概不负责。'.tr,
                    style: TextStyle(color: Config.kTheme!.text2),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  delete() async {
    final res = await NetRepository.client.deletePayment(controller.payment!);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    Get.find<PaymentMethodController>().onRefresh();
    Get.back();
    Toast.showSuccess("success");
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
            GestureDetector(
              onTap: () {
                delete();
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.delete_outline,
                  size: 24,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
