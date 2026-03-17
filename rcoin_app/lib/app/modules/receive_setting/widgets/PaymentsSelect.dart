import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/receive_setting/widgets/IntervalSelect.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';

import '../controllers/receive_setting_controller.dart';

class PaymentsSelect extends StatefulWidget {
  const PaymentsSelect({super.key, required this.selectedChannels});

  final List<TradePaymentChannel> selectedChannels;

  @override
  State<PaymentsSelect> createState() => _PaymentsSelectState();
}

class _PaymentsSelectState extends State<PaymentsSelect> {
  late List<TradePaymentChannel> selectedChannels;

  @override
  void initState() {
    selectedChannels = widget.selectedChannels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Stack(
        children: [
          Container(
            width: 375.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.w))),
            padding: const EdgeInsets.all(20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '付款类型'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                20.w.vb,
                Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  padding: const EdgeInsets.all(10).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '收款渠道'.tr,
                        style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 14.sp,
                        ),
                      ),
                      _Item(
                        paymentType: PaymentType.bank,
                        selectedChannels: selectedChannels
                            .where((element) =>
                                element.payMethod == PaymentType.bank.value)
                            .toList(),
                        onChange: (list) {
                          selectedChannels.removeWhere((element) =>
                              element.payMethod == PaymentType.bank.value);
                          selectedChannels.addAll(list);
                        },
                      ),
                      _Item(
                        paymentType: PaymentType.wechat,
                        selectedChannels: selectedChannels
                            .where((element) =>
                                element.payMethod == PaymentType.wechat.value)
                            .toList(),
                        onChange: (list) {
                          selectedChannels.removeWhere((element) =>
                              element.payMethod == PaymentType.wechat.value);
                          selectedChannels.addAll(list);
                        },
                      ),
                      _Item(
                        paymentType: PaymentType.alipay,
                        selectedChannels: selectedChannels
                            .where((element) =>
                                element.payMethod == PaymentType.alipay.value)
                            .toList(),
                        onChange: (list) {
                          selectedChannels.removeWhere((element) =>
                              element.payMethod == PaymentType.alipay.value);
                          selectedChannels.addAll(list);
                        },
                      ),
                      40.w.vb,
                      AppButton(
                        width: 320.w,
                        height: 40.w,
                        onPressed: () {
                          Get.back(result: selectedChannels);
                        },
                        title: '确认渠道'.tr,
                        titleStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xff999999),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    super.key,
    required this.paymentType,
    required this.selectedChannels,
    required this.onChange,
  });

  final PaymentType paymentType;
  final List<TradePaymentChannel> selectedChannels;
  final Function(List<TradePaymentChannel> list) onChange;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late List<TradePaymentChannel> selectedChannels;

  @override
  void initState() {
    selectedChannels = widget.selectedChannels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReceiveSettingController controller = Get.find();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.bottomSheet(
            IntervalSelect(
              selectedChannels: selectedChannels,
              allChannels: controller.paymentChannels
                  .where((e) => e.payMethod == widget.paymentType.value)
                  .toList(),
              paymentType: widget.paymentType,
              onChange: (list) {
                selectedChannels = list;
                widget.onChange(selectedChannels);
                setState(() {});
              },
            ),
            isScrollControlled: true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Text(
            widget.paymentType.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
          10.w.vb,
          Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 15.w,
              runSpacing: 10.w,
              children: selectedChannels
                  .map((e) => _ChannelInterval(channel: e))
                  .toList(),
            ),
          )
        ],
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
