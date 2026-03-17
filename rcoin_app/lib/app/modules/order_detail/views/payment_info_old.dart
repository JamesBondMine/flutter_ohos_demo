import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';

import 'order_detail_view.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key, required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    if (payment.payType == PaymentType.wechat ||
        payment.payType == PaymentType.alipay) {
      return Column(
        children: [
          13.w.vb,
          Row(
            children: [
              12.w.hb,
              Container(
                  width: 2,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: payment.payType.color,
                  )),
              6.w.hb,
              Text(
                payment.payType.text,
                style: style00Bold,
              ),
            ],
          ),
          Column(
            children: [
              10.w.vb,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '姓名'.tr,
                          style: style99,
                        ),
                        Text(
                          payment.name!,
                          style: style66,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              12.w.vb,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${payment.payType.text}${'账号'.tr}',
                          style: style99,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${payment.payType == PaymentType.wechat ? payment.wechatAccount : payment.zfbAccount}',
                              style: style66,
                            ),
                            CopyBtn(
                                text:
                                    '${payment.payType == PaymentType.wechat ? payment.wechatAccount : payment.zfbAccount}',
                                size: 12.w),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              12.w.vb,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '收款二维码'.tr,
                          style: style99,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(QrcodeDialog(
                                qrcodePath:
                                    payment.payType == PaymentType.wechat
                                        ? payment.wechatImg!
                                        : payment.zfbImg!));
                          },
                          child: SvgPicture.asset(
                            Assets.imagesQrcode,
                            width: 14.w,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    if (payment.payType == PaymentType.usdt) {
      return Column(
        children: [
          13.w.vb,
          Row(
            children: [
              12.w.hb,
              Container(
                  width: 2,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: payment.payType.color,
                  )),
              6.w.hb,
              Text(
                payment.payType.text,
                style: style00Bold,
              ),
            ],
          ),
          Column(
            children: [
              10.w.vb,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '链类型'.tr,
                          style: style99,
                        ),
                        Text(
                          payment.addressProtocol!,
                          style: style66,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              12.w.vb,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 13.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '地址'.tr,
                          style: style99,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${payment.address}',
                              style: style66,
                            ),
                            CopyBtn(text: payment.address!, size: 12.w),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            12.w.hb,
            Container(
                width: 2,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: payment.payType.color,
                )),
            6.w.hb,
            Text(
              payment.payType.text,
              style: style00Bold,
            ),
          ],
        ),
        Column(
          children: [
            10.w.vb,
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 13.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '银行卡号'.tr,
                        style: style99,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CopyBtn(text: payment.bankAccount!, size: 12.w),
                          Text(
                            payment.bankAccount!,
                            style: style66,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            12.w.vb,
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 13.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '开户行'.tr,
                        style: style99,
                      ),
                      Row(
                        children: [
                          CopyBtn(text: payment.bankName!, size: 12.w),
                          Text(
                            '${payment.bankName}',
                            style: style66,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            12.w.vb,
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 13.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '收款人姓名'.tr,
                        style: style99,
                      ),
                      Row(
                        children: [
                          CopyBtn(text: payment.name!, size: 12.w),
                          Text(
                            '${payment.name}',
                            style: style66,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
