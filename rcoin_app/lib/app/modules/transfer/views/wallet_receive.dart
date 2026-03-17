import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/order_filter_controller.dart';
import 'package:otc_app/app/modules/transfer/controllers/transfer_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/list_response.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/network/response/trade_fast_number_fon.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

final GlobalKey _boundaryKey = GlobalKey();

class WalletReceivePage extends StatefulWidget {
  const WalletReceivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WalletReceivePageState();
  }
}

class WalletReceivePageState extends State<WalletReceivePage> {
  TextEditingController inputController = TextEditingController();
  TextEditingController _equivalentQuantity = TextEditingController();

  int tradeType = 0; //交易方式  0 按金额  1 按数量

  // double equivalentQuantity = 0.0; //折合数量
  double equivalentAmount = 0.0; //折合金额
  // double get price => order.price;

  RxList<int> _options = RxList();

  final int optionIndex = -1;

  String feeStr = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFastOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      // appBar: _headerView(context),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: CustomImage(
                Assets.walletHeader,
                width: Get.width,
                height: 400,
              )),
          Positioned.fill(
              child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              _headerView(context),
              _codeView(),
            ],
          ))
        ],
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
              '收款'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Config.kTheme!.text1,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(Routes.TRANSFER_LOGS);
              },
              child: Container(
                margin: EdgeInsets.only(right: 14.w),
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  getFastOptions() async {
    final res = await NetRepository.client.fastNumbers();
    if (res.code == 0) {
      var list = (res.data as ListResponse<TradeFastNumberFon>).list;
      _options.clear();
      _options.addAll(list.map((e) => e.amount!));
    }
  }

  LinearGradient gradientAinmationgold1() {
    return LinearGradient(
        //渐变位置
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.decal, //左下
        stops: [
          0.0,
          1.0
        ],
        colors: [
          // Color(0xff7D6F51),
          // Color(0xff7D6F51),
          // Color(0xff5F543D),
          Color(0xff5F543D),
          Color(0xff232221).withOpacity(0.9)
        ]);
  }

  Widget _codeView() {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(top: 10.w, left: 12, right: 12),
        padding: EdgeInsets.only(top: 20.w, bottom: 20, left: 12),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
          // gradient: gradientAinmationgold1()
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '此地址仅支持与Gopay相关的资产'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Config.kTheme!.text1,
                  fontWeight: FontWeight.w600),
            ),
          ),
          10.w.vb,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
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
                            data: ApplicationController
                                    .to.assets.value?.address ??
                                "",
                          )))),
            ],
          ),
          Container(
            width: Get.width - 52,
            height: 0.6,
            margin: const EdgeInsets.only(top: 30, bottom: 16),
            color: Config.kTheme!.text2.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              ' - ${"接收地址".tr} -',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Config.kTheme!.text1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ApplicationController.to.assets.value?.address ?? '',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Config.kTheme!.text2,
                    )),
              ],
            ),
          ),
          20.w.vb,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                height: 52.w,
                width: 140,
                backgroundColor: Color(0xff131313).withOpacity(0),
                borderSide: BorderSide(
                    color: Config.kTheme!.text1.withOpacity(0.8), width: 0.8),
                onPressed: () {
                  Share.share(
                      ApplicationController.to.assets.value?.address ?? '',
                      subject: '收款地址'.tr);
                },
                titleStyle: TextStyle(
                    color: Config.kTheme!.text1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
                title: '分享'.tr,
                radius: 8.w,
              ),
              10.w.hb,
              AppButton(
                height: 52.w,
                width: 140,
                // backgroundColor: Config.kTheme!.text2,
                // titleStyle: TextStyle(
                //     color: Config.kTheme!.text1,
                //     fontSize: 14.sp,
                //     fontWeight: FontWeight.w500),
                onPressed: () async {
                  copyToClipboard(
                      ApplicationController.to.assets.value?.address ?? '');
                },
                title: '复制'.tr,
                radius: 8.w,
              ),
            ],
          ),
        ]));
  }

  Future _scanEvent() async {
    var scanData = await Get.toNamed(Routes.SCAN_PAGE);
    if (scanData != null) {
      if (scanData is String) {
        inputController.text = scanData;
        return;
      }
      String? code = (scanData as Barcode).code;
      if (code != null) {
        inputController.text = code;
      }
    }
  }

  Widget _cardDetail() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6).r,
          color: Config.kTheme!.bg1,
        ),
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 20.w, bottom: 7.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _scanEvent();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '转账信息'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  CustomImage(Assets.walletScan)
                ],
              ),
            ),
            SizedBox(
              height: 15.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  child: Text('转账地址'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xff9b9b9b),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 35,
                  width: Get.width - 170,
                  // color: Colors.amber,
                  child: TextField(
                    controller: inputController,
                    enabled: true,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                    decoration: outlineInputDecoration.copyWith(
                        hintText: '输入或粘贴收款地址'.tr,
                        hintStyle: TextStyle(
                            color: Color(0xff6d6d6d), fontSize: 14.sp),
                        focusColor: Colors.white,
                        fillColor: Colors.black.withOpacity(0)),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget buildFilterOption() {
    if (TransferController.to.filterIndex.value == 0) {
      return const _CooperateFilter();
    }
    if (TransferController.to.filterIndex.value == 1) {
      return NumberFilterOption(
        currentValue: Get.find<OrderFilterController>().filterMin.value,
        options: [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          TransferController.to.filterIndex.value = null;
          Get.find<OrderFilterController>().filterMin.value = value;
          Get.find<OrderFilterController>().confirmOptions();
        },
      );
    }
    if (TransferController.to.filterIndex.value == 2) {
      return NumberFilterOption(
        currentValue: Get.find<OrderFilterController>().filterMax.value,
        options: [
          ('100', 100),
          ('1000', 1000),
          ('5000', 5000),
          ('1万'.tr, 10000),
          ('10万'.tr, 100000),
          ('20万'.tr, 200000),
        ],
        onConfirm: (double? value) {
          TransferController.to.filterIndex.value = null;
          Get.find<OrderFilterController>().filterMax.value = value;
          Get.find<OrderFilterController>().confirmOptions();
        },
      );
    }
    if (TransferController.to.filterIndex.value == 3) {
      return const _PaymentTypeFilter();
    }
    return Container();
  }
}

class _PublishOrder extends StatelessWidget {
  const _PublishOrder({
    super.key,
    required this.order,
  });

  final PublishOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6).r,
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 9.w, bottom: 7.w),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xff999999),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${order.nickName}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("成单量".tr),
                          Text(" ${order.transactionCount}"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("成单率".tr),
                          Text(" ${order.closeRate}%"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.w),
                  Row(
                    children: [
                      const CustomImage(Assets.imagesTime),
                      3.w.hb,
                      Text('${order.transactionDuration}'),
                      Text('分钟'.tr),
                    ],
                  ),
                  SizedBox(height: 5.w),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '₹ ${removeTrailingZeros(order.price.toString())}',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('剩余金额 '.tr),
                              Text(
                                '${order.surplusNumber} ₹',
                                style: TextStyle(
                                  color: context.appColors.text1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.w),
                          Row(
                            children: [
                              Text('限额 '.tr),
                              Text(
                                '₹${order.minMoney}-${Config.coinName}${order.maxMoney}',
                                style: TextStyle(
                                  color: context.appColors.text1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 80.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: order.paymentTypes
                                  .map((e) => Text(
                                        e.text,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: context.appColors.primary,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppButton(
                      width: 63.w,
                      height: 28.w,
                      title:
                          order.type == PaySide.sell.value ? '购买'.tr : '出售'.tr,
                      backgroundColor: order.type == PaySide.sell.value
                          ? context.appColors.green
                          : context.appColors.red,
                      onPressed: () {
                        Get.toNamed(Routes.CONFIRM_ORDER, arguments: {
                          'order': order,
                        });
                      },
                      radius: 6.w,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NumberFilterOption extends StatefulWidget {
  const NumberFilterOption(
      {super.key,
      this.currentValue,
      required this.options,
      required this.onConfirm});

  final double? currentValue;
  final List<(String, double)> options;
  final void Function(double? value) onConfirm;

  @override
  State<NumberFilterOption> createState() => _NumberFilterOptionState();
}

class _NumberFilterOptionState extends State<NumberFilterOption> {
  late TextEditingController controller;

  @override
  void initState() {
    controller =
        TextEditingController(text: widget.currentValue?.toString() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
              inputFormatters: [
                positiveNumberFormatter,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: outlineInputDecoration.copyWith(
                hintText: '例如 100'.tr,
              ),
            ),
            7.w.vb,
            Container(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 6.w,
                runSpacing: 6.w,
                children: List.generate(
                  widget.options.length,
                  (index) {
                    final option = widget.options[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.text =
                            removeTrailingZeros(option.$2.toString());
                      },
                      child: Container(
                        width: 97.w,
                        height: 35.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          color: const Color(0xffe8e8e8),
                        ),
                        child: Text(
                          option.$1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: context.appColors.text1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    widget.onConfirm(
                      (controller.isBlank ?? true)
                          ? null
                          : double.tryParse(controller.text),
                    );
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CooperateFilter extends GetView<OrderFilterController> {
  const _CooperateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("有过合作用户".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.text1,
                    )),
                GestureDetector(
                  onTap: () {
                    controller.cooperation.toggle();
                  },
                  child: Obx(() => controller.cooperation.value
                      ? Icon(
                          Icons.check_circle_outline_outlined,
                          size: 14.w,
                          color: context.appColors.primary,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          size: 14.w,
                          color: Color(0xffC1C1C1),
                        )),
                ),
              ],
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.cooperation.value = false;
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.confirmOptions();
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _PaymentTypeFilter extends GetView<OrderFilterController> {
  const _PaymentTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      child: Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(left: 31.w, top: 6.w, right: 31.w, bottom: 17.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 5,
                runSpacing: 10,
                children: [
                  for (var option in PaymentType.values.where((e) => ![
                        PaymentType.wechat,
                        PaymentType.alipay,
                        PaymentType.bank,
                        PaymentType.usdt
                      ].contains(e)))
                    Obx(() => GestureDetector(
                        onTap: () {
                          if (controller.payMethods.contains(option.value)) {
                            controller.payMethods.remove(option.value);
                          } else {
                            controller.payMethods.add(option.value);
                          }
                        },
                        child: Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: controller.payMethods.contains(option.value)
                                ? context.appColors.primary
                                : context.appColors.primary.withOpacity(.1),
                          ),
                          child: Text(
                            option.text,
                            style: TextStyle(
                              color:
                                  controller.payMethods.contains(option.value)
                                      ? Colors.white
                                      : context.appColors.text1,
                            ),
                          ),
                        )))
                ],
              ),
            ),
            14.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.payMethods.clear();
                  },
                  backgroundColor: const Color(0xffe8e8e8),
                  radius: 4.w,
                  title: '重置'.tr,
                  titleStyle: TextStyle(
                      fontSize: 14.sp, color: context.appColors.text1),
                ),
                AppButton(
                  width: 153.w,
                  height: 28.w,
                  onPressed: () {
                    controller.confirmOptions();
                  },
                  backgroundColor: context.appColors.primary,
                  radius: 4.w,
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
