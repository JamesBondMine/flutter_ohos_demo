import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';
import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context, '收款账户'.tr),
      body: SafeArea(
        child: GetBuilder<PaymentMethodController>(
            id: controller.paymentDataListRefreshId,
            builder: (v) {
              return _bodyView();
            }),
      ),
    );
  }

  Future<List<Payment>> _paymentAccountEvent() async {
    List<Payment> dl = await controller.requestPaymentData(1);
    return dl;
  }

  List<PaymentType> get payments => [
        PaymentType.upi,
        PaymentType.paytm,
        PaymentType.gpay,
        PaymentType.phonepe,
        PaymentType.amazonPay,
        PaymentType.digitalRupees,
      ];
  Map<String, PaymentType> get paymentMaps => {
        "5": PaymentType.upi,
        "6": PaymentType.paytm,
        "7": PaymentType.gpay,
        "8": PaymentType.phonepe,
        "9": PaymentType.amazonPay,
        "10": PaymentType.digitalRupees
      };
  Widget _bodyView() {
    return FutureBuilder(
        future: _paymentAccountEvent(),
        builder: (c, AsyncSnapshot<List<Payment>> s) {
          if (s.hasData && s.data != null) {
            List<Payment> datalist = s.data!;
            return ListView.builder(
                itemCount: datalist.length + 1,
                itemBuilder: ((context, index) {
                  if (index == datalist.length) {
                    return GestureDetector(
                      onTap: () async {
                        await Get.toNamed(Routes.ADD_PAYMENT, arguments: {
                          'type': payments.first,
                        });
                        controller.updatePaymentDataListRefresh();
                      },
                      child: _addView(),
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      Payment payment = datalist[index];
                      int valueIndex = payment.payMethod ?? 5;
                      PaymentType? paymentType = paymentMaps["$valueIndex"];
                      await Get.toNamed(Routes.PAYMENT_INFO, arguments: {
                        'type': paymentType,
                        'payment': datalist[index],
                      });
                      controller.updatePaymentDataListRefresh();
                    },
                    child: _cellView(datalist[index]),
                  );
                }));
          }
          return Container();
        });
  }

  Map<String, dynamic> get pts => {
        "5": Assets.orderPpmentTxt1,
        "6": Assets.orderPpmentTxt2,
        "7": Assets.orderPpmentTxt3,
        "8": Assets.orderPpmentTxt4,
        "9": Assets.orderPpmentTxt5,
        "10": Assets.orderPpmentTxt6,
        // 默认
        "1": Assets.orderPpmentTxt1,
        "2": Assets.orderPpmentTxt1,
        "3": Assets.orderPpmentTxt1,
        "4": Assets.orderPpmentTxt1
      };

  Widget _cellView(Payment payment) {
    return Container(
      width: Get.width - 32,
      margin: EdgeInsets.only(top: 5.w, left: 16, right: 16),
      height: 106.w,
      child: Stack(
        children: [
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              width: Get.width - 32,
              margin: EdgeInsets.only(top: 2.w),
              height: 96.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12..w),
                  gradient: LinearGradient(colors: [
                    Config.kTheme!.bgw,
                    Config.kTheme!.bgCard.withOpacity(0.7)
                  ])),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                    margin: EdgeInsets.only(left: 16.w, right: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                            color: Config.kTheme!.text2.withOpacity(0.5),
                            width: 0.7)),
                    child: CustomImage(
                      pts["${payment.payMethod}"],
                      // width: 40.w,
                      height: 20.w,
                      fit: BoxFit.contain,
                      color: payment.enable == 1
                          ? Config.kTheme!.text2
                          : Config.kTheme!.text2.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        payment.name ?? "",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: payment.enable == 1
                                ? Config.kTheme!.text1
                                : Config.kTheme!.text2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(payment.account ?? "",
                          style: TextStyle(
                              fontSize: 12.sp, color: Config.kTheme!.text2))
                    ],
                  )
                ],
              ),
            ),
          )),
          payment.enable == 1
              ? Container()
              : Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        color: Color(0xff90B7BF)),
                    child: Text(
                      "支付已关闭".tr,
                      style:
                          TextStyle(fontSize: 11.sp, color: Config.kTheme!.bgw),
                    ),
                  ))
        ],
      ),
    );
  }

  Widget _addView() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 16, right: 16),
      width: Get.width - 32,
      height: 96.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: Config.kTheme!.text2.withOpacity(0.5),
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside),
          borderRadius: BorderRadius.circular(8..w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Config.kTheme!.text2,
            size: 30.w,
          ),
          5.w.vb,
          Text(
            "add account",
            style: TextStyle(
                color: Config.kTheme!.text2,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          )
        ],
      ),
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

class CircleHoleShapeBorder extends ShapeBorder {
  final double radius;
  final double holeRadius;

  const CircleHoleShapeBorder({this.radius = 0, this.holeRadius = 0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(radius);

  @override
  ShapeBorder scale(double t) {
    return CircleHoleShapeBorder(
      radius: radius * t,
      holeRadius: holeRadius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final holeCenterLeft = Offset(rect.left, rect.center.dy);
    final holeCenterRight = Offset(rect.right, rect.center.dy);
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    path.addArc(
        Rect.fromCenter(
            center: holeCenterLeft, width: holeRadius, height: holeRadius),
        -pi / 2,
        pi);
    path.addArc(
        Rect.fromCenter(
            center: holeCenterRight, width: holeRadius, height: holeRadius),
        pi / 2,
        pi);

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}

class PaymentItem extends StatelessWidget {
  PaymentItem({super.key, required this.payment})
      : enable = RxInt(payment.enable!);

  final Payment payment;
  RxInt enable;

  @override
  Widget build(BuildContext context) {
    var paymentType = payment.payType;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await Get.toNamed(Routes.ADD_PAYMENT, arguments: {
          'type': paymentType,
          'payment': payment,
        });
      },
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: CircleHoleShapeBorder(
              radius: 8.w,
              holeRadius: 20.w,
            )),
        padding: EdgeInsets.all(12.w),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 14.sp,
            color: context.appColors.text1,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        paymentType.text,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: payment.state == 1,
                        child: Container(
                          width: 34.w,
                          height: 20.w,
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(
                              side: BorderSide(
                                  width: 1.w, color: context.appColors.red),
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          child: Text(
                            '异常'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.appColors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Row(
                        children: [
                          Text(enable.value == 1 ? "开启".tr : '关闭'.tr,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(enable.value == 1
                                    ? 0xff04C2AD
                                    : 0xffF6465D),
                              )),
                          SizedBox(width: 6.w),
                          FlutterSwitch(
                            width: 39.w,
                            height: 20.w,
                            padding: 1,
                            toggleSize: 20.w,
                            activeColor: const Color(0xffdadada),
                            inactiveColor: const Color(0xffdadada),
                            activeToggleColor: const Color(0xff04c2ad),
                            value: enable.value == 1,
                            onToggle: (val) async {
                              enable.value = val ? 1 : 2;
                              int prevValue = payment.enable!;
                              payment.enable = val ? 1 : 2;

                              final res = await NetRepository.client
                                  .updatePayment(payment);
                              if (res.code != 0) {
                                Toast.showError(res.msg);
                                enable.value = prevValue;
                                payment.enable = prevValue;
                                return;
                              }
                            },
                          ),
                        ],
                      )),
                ],
              ),
              Visibility(
                visible: paymentType == PaymentType.wechat,
                child:
                    _Row(title: '账号'.tr, content: payment.wechatAccount ?? ''),
              ),
              Visibility(
                visible: paymentType == PaymentType.alipay,
                child: _Row(title: '账号'.tr, content: payment.zfbAccount ?? ''),
              ),
              Visibility(
                  visible: paymentType != PaymentType.usdt,
                  child: _Row(title: '姓名'.tr, content: payment.name ?? '')),
              Visibility(
                  visible: paymentType == PaymentType.bank,
                  child:
                      _Row(title: '开户行'.tr, content: payment.bankName ?? '')),
              Visibility(
                  visible: paymentType == PaymentType.bank,
                  child: _Row(
                      title: '银行卡号'.tr, content: payment.bankAccount ?? '')),
              Visibility(
                  visible: paymentType == PaymentType.usdt,
                  child: _Row(
                      title: '收款地址类型'.tr,
                      content: payment.addressProtocol ?? '')),
              Visibility(
                  visible: paymentType == PaymentType.usdt,
                  child:
                      _Row(title: '收款地址'.tr, content: payment.address ?? '')),
              Visibility(
                visible: paymentType != PaymentType.bank &&
                    paymentType != PaymentType.usdt,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('收款码'.tr),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            QrcodeDialog(qrcodePath: payment.img ?? ""),
                          );
                        },
                        child: Hero(
                            tag: 'qrcode_${payment.id}',
                            child: const Icon(Icons.qr_code)),
                      ),
                    ],
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

class _Row extends StatelessWidget {
  const _Row({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(content),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          SizedBox(height: 20.w),
          CustomImage(
            Assets.otherEmptyList,
            width: 200.w,
            height: 200.w,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "您暂时无法接受订单，请先添加一个收款方式".tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
