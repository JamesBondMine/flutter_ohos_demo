import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/copy_btn.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../widgets/button.dart';
import '../../appeal/views/appeal_view.dart';
import '../controllers/order_detail_controller.dart';
import 'order_detail_view.dart';

class WaitPayBuyer extends GetView<OrderDetailController> {
  const WaitPayBuyer({super.key, required this.state});

  final TradeDetail state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: FillRemainWidget(
        topChildren: [
          Padding(
            padding: const EdgeInsets.all(16.0).w,
            child: Column(
              children: [
                _buyerView(),
                _sellerView(),
                SizedBox(height: 10.w),
                _paymentTipsView(context),
              ],
            ),
          ),
        ],
        bottomChild: Column(
          children: [
            20.w.vb,
            AppButton(
              width: 334.w,
              height: 52.w,
              title: '我已付款'.tr,
              radius: 8,
              onPressed: () {
                controller.confirmPay();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentTipsView(BuildContext context) {
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20, left: 16),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 0, right: 10),
                  child: Text(
                    '添加付款凭证'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Obx(() => Wrap(
                  spacing: 5.w,
                  runSpacing: 5.w,
                  children: [
                    ...List.generate(
                        controller.pics.length,
                        (index) => PickedAsset(
                              path: controller.pics[index],
                              onDelete: () {
                                controller.pics.removeAt(index);
                              },
                            )),
                    Visibility(
                      visible: controller.pics.length < 5,
                      child: AddFile(
                        onPicked: (AssetEntity assetEntity) async {
                          // var file = await compressFile((await assetEntity.file)!);
                          var file = await assetEntity.file;
                          final res =
                              await NetRepository.uploadClient.upload(file!);
                          if (res.code != 0) {
                            Toast.showError(res.msg);
                            return;
                          }
                          controller.pics
                              .add((res.data as UploadResponse).url!);
                        },
                        requestType: RequestType.image,
                      ),
                    ),
                  ],
                )),
          ),
          _videosView(context)
        ]));
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

  Widget _sellerView() {
    String payTypePath =
        pts["${state.ctcTradePay!.payType.value}"] ?? Assets.orderPpment1;
    return Container(
        width: Get.width - 32,
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        padding: EdgeInsets.only(top: 16.w, bottom: 20),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '卖家信息'.tr,
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '收款类型'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                CustomImage(
                  payTypePath,
                  height: 20.w,
                  color: Config.kTheme!.text2,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              children: [
                Text(
                  '收款账户'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Spacer(),
                Text(
                  '${state.ctcTradePay!.name}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1),
                ),
                CopyBtn(text: state.orderSn!, size: 12.w),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '收款账号'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.ctcTradePay!.account}',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Config.kTheme!.text1),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26, bottom: 10),
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: CachedNetworkImage(imageUrl: state.ctcTradePay!.img!),
          ),
          Text(
            '收款二维码'.tr,
            style: style99,
          ),
        ]));
  }

  Widget _buyerView() {
    return Container(
        width: Get.width - 32,
        // margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          _buyerHeader(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30.w, left: 10, right: 10),
                  child: Text(
                    '${'购买'.tr}',
                    style: TextStyle(
                      color: Config.kTheme!.text1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '订单号'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.orderSn}',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Config.kTheme!.text1,
                      ),
                    ),
                    CopyBtn(text: state.orderSn!, size: 12.w),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '金额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.amount}₹',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '总金额'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${state.ctcTradePay!.payType == PaymentType.usdt ? state.usdtAmount : state.amount}',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w, left: 10, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '备注码'.tr,
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text2),
                ),
                Text(
                  '${(state.remarkCode)}',
                  style: TextStyle(
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  Widget _buyerHeader() {
    return Container(
      width: Get.width - 32,
      height: 78.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
      decoration: const BoxDecoration(
          color: Color(0xff131313),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          gradient: LinearGradient(colors: [
            Color(0xffF8F2EC),
            Color(0xffAC885B),
            Color(0xffAF9165)
          ])),
      child: Stack(
        children: [
          Positioned.fill(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '等待买家确认付款'.tr,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff45280F),
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width - 130,
                    child: Text(
                      '此卖家95%订单会在7:00处理'.tr,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff45280F)),
                    ),
                  )
                ],
              )
            ],
          )),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 105,
                child: const CustomImage(Assets.orderClockBig),
              ))
        ],
      ),
    );
  }

  Widget _videosView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.w.vb,
          Text(
            '添加付款凭证录屏（可选）'.tr,
            style: TextStyle(
              color: Config.kTheme!.text1,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.w.vb,
          Container(
            alignment: Alignment.centerLeft,
            child: Obx(() => Wrap(
                  spacing: 5.w,
                  runSpacing: 5.w,
                  children: [
                    ...List.generate(
                        controller.videos.length,
                        (index) => PickedVideo(
                              image: controller.videoCover[index],
                              onDelete: () {
                                controller.videos.removeAt(index);
                                controller.videoCover.removeAt(index);
                              },
                            )),
                    Visibility(
                      visible: controller.videos.isEmpty,
                      child: AddFile(
                        onPicked: (AssetEntity assetEntity) {
                          _uploadVideoEvent(assetEntity);
                        },
                        requestType: RequestType.video,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  // 上传视频
  _uploadVideoEvent(AssetEntity assetEntity) async {
    try {
      Toast.showLoading(message: "uploading...");
      var file = await assetEntity.file;
      if (file is File) {
        final image = MemoryImage((await assetEntity.thumbnailData)!);
        // 添加封面
        controller.videoCover.add(image);
      }

      final res = await NetRepository.uploadClient.upload(file!);
      if (res.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg);
        return;
      }
      controller.videos.add((res.data as UploadResponse).url!);
      Toast.hideLoading();
    } catch (e) {
      Toast.hideLoading();
      Toast.showError("net error");
    }
  }
}

class CancelAndAppeal extends StatelessWidget {
  const CancelAndAppeal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, -4),
          blurRadius: 12,
          color: Colors.black.withOpacity(0.05),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 156.w,
            height: 38.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  )),
              onPressed: () {},
              child: Text(
                '取消订单'.tr,
                style: style33.copyWith(
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            height: 38.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7F7F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  )),
              onPressed: () {},
              child: Text(
                '申诉'.tr,
                style: style33.copyWith(
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemindOrder extends StatelessWidget {
  const RemindOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 17.w),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 80.w,
        height: 30.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primary,
          ),
          onPressed: () {},
          child: Text(
            '催单'.tr,
            style: style00Bold.copyWith(
              fontSize: 17.sp,
            ),
          ),
        ),
      ),
    );
  }
}
