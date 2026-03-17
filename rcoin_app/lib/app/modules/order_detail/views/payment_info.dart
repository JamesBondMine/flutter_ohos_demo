import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/models/payment.dart';
import 'package:otc_app/models/payment_type.dart';

import 'order_detail_view.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({super.key, required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.w.vb,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '姓名'.tr,
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xff9b9b9b)),
                ),
                Text(
                  payment.name!,
                  style: TextStyle(
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            )
          ],
        ),
        12.w.vb,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${payment.payType.text}${'账号'.tr}',
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xff9b9b9b)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${payment.account}',
                      style: TextStyle(
                        color: Config.kTheme!.text1,
                      ),
                    ),
                    CopyBtn(text: '${payment.account}', size: 12.w),
                  ],
                ),
              ],
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 26, bottom: 10),
          width: 180,
          height: 180,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: CachedNetworkImage(imageUrl: payment.img!),
        ),
        Text(
          '收款二维码'.tr,
          style: style99,
        ),
      ],
    );

    if (payment.payType == PaymentType.wechat ||
        payment.payType == PaymentType.alipay) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '收款方式',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PingFang SC'),
              ),
              21.w.vb,
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
          12.w.vb,
          Column(
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
          12.w.vb,
          Column(
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
                          qrcodePath: payment.payType == PaymentType.wechat
                              ? payment.wechatImg!
                              : payment.zfbImg!));
                    },
                    child: CustomImage(
                      Assets.imagesQrcode,
                      color: context.appColors.primary,
                      width: 14.w,
                    ),
                  )
                ],
              )
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          payment.payType.text,
          style: style00Bold,
        ),
        Column(
          children: [
            10.w.vb,
            Column(
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
                        Text(
                          payment.bankAccount!,
                          style: style66,
                        ),
                        CopyBtn(text: payment.bankAccount!, size: 12.w),
                      ],
                    ),
                  ],
                )
              ],
            ),
            12.w.vb,
            Column(
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
                        Text(
                          '${payment.bankName}',
                          style: style66,
                        ),
                        CopyBtn(text: payment.bankName!, size: 12.w),
                      ],
                    ),
                  ],
                )
              ],
            ),
            12.w.vb,
            Column(
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
                        Text(
                          '${payment.name}',
                          style: style66,
                        ),
                        CopyBtn(text: payment.name!, size: 12.w),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
