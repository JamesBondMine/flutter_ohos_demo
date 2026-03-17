import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/post_order/controllers/post_order_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/api.dart';

class PaymentSelectView extends StatefulWidget {
  const PaymentSelectView(
      {super.key,
      required this.paymentTypes,
      required this.select,
      this.onlySingleSelect = true,
      required this.title});

  final Set<PaymentType> paymentTypes;
  final String title;
  final ValueChanged<List<PaymentType>> select;
  final bool onlySingleSelect;

  @override
  State<PaymentSelectView> createState() => _PaymentMethodSelectState();
}

class _PaymentMethodSelectState extends State<PaymentSelectView> {
  late final Set<PaymentType> paymentTypes;

  @override
  void initState() {
    paymentTypes = widget.paymentTypes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _childView();
  }

  Future<bool> _payMentTypeEvent() async {
    if (PostOrderController.to.userPaymentList.isNotEmpty) {
      return true;
    }
    await Api.payments();
    return true;
  }

  Widget _childView() {
    return FutureBuilder(
        future: _payMentTypeEvent(),
        builder: (c, AsyncSnapshot<bool> result) {
          List<Widget> options = [];
          for (final paymentType in PaymentType.values.where((e) => ![
                PaymentType.wechat,
                PaymentType.alipay,
                PaymentType.bank,
                PaymentType.usdt
              ].contains(e))) {
            bool disable = false;
            if (result.hasData) {
              PaymentTypeModel? item = PostOrderController.to.userPaymentList
                  .firstWhereOrNull(
                      (element) => paymentType.text == element.paymentMark);
              disable = item == null || item.paymentClick != "1";
            }
            options.add(_PaymentLine(
              title: paymentType.text,
              onTap: () {
                PaymentTypeModel? model = PostOrderController.to.userPaymentList
                    .firstWhereOrNull(
                        (element) => paymentType.text == element.paymentMark);
                if (model == null || model.paymentClick != "1") {
                  // 没有设置或者不可使用的不能点击
                  _userAuthEvent();
                  return;
                }
                if (widget.onlySingleSelect) {
                  if (paymentTypes.contains(paymentType)) {
                    paymentTypes.remove(paymentType);
                  } else {
                    paymentTypes.clear();
                    paymentTypes.add(paymentType);
                  }
                  setState(() {});
                  widget.select([paymentType]);
                } else {
                  // 多选
                  if (paymentTypes.contains(paymentType)) {
                    paymentTypes.remove(paymentType);
                  } else {
                    paymentTypes.add(paymentType);
                  }
                  setState(() {});
                  widget.select(paymentTypes.toList());
                }
              },
              selected: paymentTypes.contains(paymentType),
              disable: disable,
            ));
          }

          Widget bottomSheet = ListView(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.w.vb,
              Align(
                alignment: Alignment.center,
                child: Text(widget.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1,
                    )),
              ),
              10.w.vb,
              // _titleView(),
              12.w.vb,
              Column(
                children: options,
              ),
              10.w.vb,
            ],
          );

          return UnconstrainedBox(
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 520,
                  decoration: BoxDecoration(
                      color: Config.kTheme!.bgw,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  // bottom: 0,
                  child: Container(
                    width: Get.width,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Config.kTheme!.bgMain,
                              Config.kTheme!.bg1
                            ])),
                    // child: const CustomImage(
                    //   Assets.alertHead,
                    // ),
                  ),
                ),
                Positioned.fill(child: bottomSheet),
                Positioned(
                  right: 0,
                  top: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Config.kTheme!.text1,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  // 认证弹窗
  _userAuthEvent() async {
    Get.dialog(Builder(builder: (context) {
      return Container(
          padding: EdgeInsets.only(
              bottom: (Get.height - 360) / 2,
              left: 20,
              right: 20,
              top: (Get.height - 360) / 2),
          child: Center(
              child: Container(
                  height: 200.w,
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xff232322),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: const CustomImage(
                            Assets.alertHead,
                          ),
                        ),
                      ),
                      Positioned.fill(child: _authAlertChildView(context))
                    ],
                  ))));
    }));
  }

  // 弹窗子视图
  Widget _authAlertChildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const SizedBox(
                width: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Material(
                child: Text(
                  '温馨提示'.tr,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.close,
                  color: const Color(0xff9b9d9c),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
                child: Text(
              "未绑定收款方式，去绑定？".tr,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ))
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: 'cancel'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: Colors.black.withOpacity(0),
                borderSide:
                    const BorderSide(color: Color(0xff5d4c30), width: 0.8),
                onPressed: () {
                  Get.back();
                },
                radius: 8.w,
              ),
              AppButton(
                width: MediaQuery.of(context).size.width / 2 - 40.w,
                height: 52.w,
                title: '立即绑定'.tr,
                titleStyle: const TextStyle(color: Color(0xff5d4c30)),
                backgroundColor: const Color(0xfff4e0bd),
                onPressed: () {
                  Get.back();
                  Get.back();
                  Get.toNamed(Routes.PAYMENT_METHOD);
                },
                radius: 8.w,
              )
            ],
          ),
        )
      ],
    );
  }
}

class _PaymentLine extends StatelessWidget {
  const _PaymentLine({
    super.key,
    required this.selected,
    required this.title,
    required this.onTap,
    required this.disable,
  });

  final String title;
  final bool selected;
  final bool disable;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
        ),
        margin: const EdgeInsets.only(bottom: 12).w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                6.w.hb,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Config.kTheme!.text1,
                  ),
                ),
                6.w.hb,
                CustomImage(
                  pts[title],
                  height: 20.w,
                  color: Config.kTheme!.text2,
                )
              ],
            ),
            const Spacer(),
            Visibility(
              visible: !disable && selected,
              child: const CustomImage(
                Assets.ptSelect,
                // color: Config.kTheme!.bgMain,
              ),
            ),
            Visibility(
              visible: !disable && !selected,
              child: CustomImage(
                Assets.ptUnselect,
                color: Config.kTheme!.text2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> get pts => {
        "UPI": Assets.orderPpment1,
        "Paytm": Assets.orderPpment3,
        "Gpay": Assets.orderPpment2,
        "Phonepe": Assets.orderPpment4,
        "Amazon Pay": Assets.orderPpment5,
        "Digital Rupees": Assets.orderPpment6,
      };
}
