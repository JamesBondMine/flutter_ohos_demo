import 'package:flutter/material.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/views/home_botton_view.dart';
import 'package:otc_app/app/modules/home/views/home_view.dart';

class BuyMoney extends StatelessWidget {
  const BuyMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        color: const Color(0xfff9f9f9),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xff171717),
            fontWeight: FontWeight.bold,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Step 1: Access to payments and receipts'),
              12.w.vb,
              Container(
                padding:
                    const EdgeInsets.only(left: 2, top: 12, right: 2, bottom: 7)
                        .w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  child: IgnorePointer(
                      child: Stack(
                    children: [
                      Transform.scale(scale: 0.9, child: const HomeButtons()),
                      const Positioned(
                        right: 10,
                        bottom: 14,
                        child: CustomImage(Assets.otherFinger),
                      )
                    ],
                  )),
                ),
              ),
              8.w.vb,
              const Text('Step 2: Add Receipts and Payments'),
              12.w.vb,
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                child: const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      children: [
                        IgnorePointer(child: CircleLeading()),
                        Expanded(
                          child: Center(child: Text('payee')),
                        ),
                        Text(
                          'increase',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      bottom: -12,
                      child: CustomImage(Assets.otherFinger),
                    )
                  ],
                ),
              ),
              8.w.vb,
              const Text('Step 3：Fill in Receipt and Payment'),
              Text(
                'Click to select the channel to be bound and fill in the information',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xff999999),
                  fontWeight: FontWeight.normal,
                ),
              ),
              12.w.vb,
              const Text('Card Theme'),
              12.w.vb,
              Container(
                height: 45.w,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(
                    side: BorderSide(color: Color(0xff010101), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    7.w.hb,
                    Container(
                      width: 31.w,
                      height: 31.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff008000),
                      ),
                    ),
                    10.w.hb,
                    const Text('Green'),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.black,
                    ),
                    20.w.hb,
                  ],
                ),
              ),
              4.w.vb,
              Container(
                padding: const EdgeInsets.all(8).w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffD9D9D9), width: 1),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.w),
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(
                          side: BorderSide(color: Color(0xffF5F5F5), width: 1),
                        ),
                        color: Color(0xfffafafa),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 31.w,
                            height: 31.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff010101),
                            ),
                          ),
                          10.w.hb,
                          const Text('银行'),
                        ],
                      ),
                    ),
                    6.w.vb,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.w),
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(
                          side: BorderSide(color: Color(0xffF5F5F5), width: 1),
                        ),
                        color: Color(0xfffafafa),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 31.w,
                            height: 31.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff010101),
                            ),
                          ),
                          10.w.hb,
                          const Text('微信'),
                        ],
                      ),
                    ),
                    6.w.vb,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.w),
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(
                          side: BorderSide(color: Color(0xffF5F5F5), width: 1),
                        ),
                        color: context.appColors.primary,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 31.w,
                            height: 31.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffEDD6FF),
                            ),
                          ),
                          10.w.hb,
                          const Text('支付宝'),
                        ],
                      ),
                    ),
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
