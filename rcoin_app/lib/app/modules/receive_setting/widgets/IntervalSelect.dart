import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/network/response/trade_payment_channel.dart';

class IntervalSelect extends StatefulWidget {
  const IntervalSelect({
    super.key,
    required this.paymentType,
    required this.selectedChannels,
    required this.allChannels,
    required this.onChange,
  });

  final PaymentType paymentType;
  final List<TradePaymentChannel> selectedChannels;
  final List<TradePaymentChannel> allChannels;
  final Function(List<TradePaymentChannel> list) onChange;

  @override
  State<IntervalSelect> createState() => _IntervalSelectState();
}

class _IntervalSelectState extends State<IntervalSelect> {
  late List<TradePaymentChannel> selectedChannels;

  @override
  void initState() {
    selectedChannels = widget.selectedChannels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.w))),
          padding: const EdgeInsets.all(20).w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.paymentType.text,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.paymentType.text,
                          style: TextStyle(
                            color: const Color(0xFF999999),
                            fontSize: 14.sp,
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            selectedChannels..clear()..addAll(widget.allChannels);
                            widget.onChange(selectedChannels);
                            setState(() {});
                          },
                          child: Container(
                            width: 44.w,
                            height: 24.w,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF5A91F7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '全选'.tr,
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(0.8199999928474426),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    22.w.vb,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 400.w,
                      ),
                      child: ListView(
                        children: widget.allChannels
                            .where(
                                (e) => e.payMethod == widget.paymentType.value)
                            .map((e) => GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (selectedChannels.contains(e)) {
                                      selectedChannels.remove(e);
                                    } else {
                                      selectedChannels.add(e);
                                    }
                                    widget.onChange(selectedChannels);
                                    setState(() {});
                                  },
                                  child: _Item(
                                    channel: e,
                                    isSelected: selectedChannels.contains(e),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    40.w.vb,
                    AppButton(
                      width: 320.w,
                      height: 40.w,
                      onPressed: () {
                        Get.back();
                      },
                      title: '确认'.tr,
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
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.channel,
    required this.isSelected,
  });

  final TradePaymentChannel channel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 299.w,
          height: 59.w,
          margin: EdgeInsets.only(bottom: 4.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1, color: Color(isSelected ? 0xFFF5C944 : 0xFFE5E5E5)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              15.w.hb,
              Container(
                width: 5,
                height: 13,
                decoration: const BoxDecoration(color: Color(0xFFF5C944)),
              ),
              3.w.hb,
              Text(
                '${channel.name}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '交易区间',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 10,
                    ),
                  ),
                  5.w.vb,
                  Text(
                    '${channel.minAmount}-${channel.maxAmount}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              49.w.hb,
            ],
          ),
        ),
        if (isSelected)
          Positioned(
            top: 0,
            right: 0,
            child: CustomImage(
              Assets.imagesPolygon,
              width: 20.w,
            ),
          ),
        if (isSelected)
          Positioned(
            top: 2.w,
            right: 2.w,
            child: const CustomImage(
              Assets.imagesUnion,
            ),
          ),
      ],
    );
  }
}
