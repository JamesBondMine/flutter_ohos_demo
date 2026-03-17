import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/order_detail/controllers/order_detail_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/widgets/image_view.dart';
import 'package:otc_app/common/widgets/video_view.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/response/appeal_detail_res.dart';
import 'package:otc_app/services/chat_service.dart';

class AppealOrderView extends HookWidget {
  const AppealOrderView({Key? key, required this.detail}) : super(key: key);
  final TradeDetail detail;

  @override
  Widget build(BuildContext context) {
    final appealDetail = useState(const AppealDetailRes());
    Future<void> fetchData() async {
      final res = await NetRepository.client.appealDetail(detail.id!);
      if (res.code == 0) {
        appealDetail.value = res.data;
      }
    }

    useEffect(() {
      fetchData();
      return null;
    });

    final style_12_99 = TextStyle(fontSize: 14.sp, color: Color(0xff6d6d6d));
    final style_12_33 = TextStyle(fontSize: 14.sp, color: Colors.white);
    final style_12_33_b = TextStyle(
        fontSize: 14.sp, color: Color(0xff6d6d6d), fontWeight: FontWeight.w500);
    final style_12_66_b = TextStyle(
        fontSize: 14.sp, color: Color(0xff9b9b9b), fontWeight: FontWeight.w500);
    final style_10_33 = TextStyle(fontSize: 14.sp, color: Color(0xff9b9b9b));

    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff131313),
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 16.w, top: 17.w, right: 17.w, bottom: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: context.appColors.text1),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: Get.width - 75,
                                  child: Text(
                                    '请等待客服处理'.tr,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                detail.isBuyer ? '购买'.tr : '出售'.tr,
                                style: style_12_33.copyWith(
                                    color: detail.isBuyer
                                        ? const Color(0xff09C3AF)
                                        : const Color(0xffe35561)),
                              ),
                              Text(
                                Config.coinName,
                                style: style_12_33,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('总价'.tr, style: style_12_99),
                              Text(
                                '₹${detail.amount?.rtz}',
                                style: style_12_33.copyWith(
                                    fontSize: 17.sp,
                                    color: Color(0xff9b9b9b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          // SizedBox(height: 19.w),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('单价', style: style_12_99),
                          //     Text('₹${detail.price?.rtz}',
                          //         style: style_12_66_b),
                          //   ],
                          // ),
                          SizedBox(height: 16.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('数量'.tr, style: style_12_99),
                              Text('${detail.number?.rtz}',
                                  style: style_12_66_b),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const Divider(),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            unselectedWidgetColor:
                                context.appColors.textPlaceholder,
                            colorScheme: ColorScheme.light(
                              primary: context.appColors.textPlaceholder,
                            ), //
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,
                            title: Text('支付方式'.tr, style: style_12_33_b),
                            children: [
                              Row(
                                children: [
                                  Text(detail.ctcTradePay!.payType.text,
                                      style: style_12_33),
                                ],
                              ),
                              SizedBox(height: 10.w),
                              Visibility(
                                visible: detail.ctcTradePay!.payType ==
                                    PaymentType.bank,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('姓名'.tr, style: style_12_99),
                                        Text(detail.ctcTradePay!.name ?? '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('开户行'.tr, style: style_12_99),
                                        Text(detail.ctcTradePay!.bankName ?? '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('收款账号'.tr, style: style_12_99),
                                        Text(
                                            detail.ctcTradePay!.bankAccount ??
                                                '',
                                            style: style_10_33),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: detail.ctcTradePay!.payType ==
                                    PaymentType.wechat,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('账号'.tr, style: style_12_99),
                                        Text(
                                            detail.ctcTradePay!.wechatAccount ??
                                                '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('姓名'.tr, style: style_12_99),
                                        Text(detail.ctcTradePay!.name ?? '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('二维码'.tr, style: style_12_99),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(QrcodeDialog(
                                                qrcodePath: detail
                                                    .ctcTradePay!.wechatImg!));
                                          },
                                          child: CustomImage(
                                            Assets.imagesQrcode,
                                            width: 14.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: detail.ctcTradePay!.payType ==
                                    PaymentType.alipay,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('账号'.tr, style: style_12_99),
                                        Text(
                                            detail.ctcTradePay!.zfbAccount ??
                                                '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('姓名'.tr, style: style_12_99),
                                        Text(detail.ctcTradePay!.name ?? '',
                                            style: style_10_33),
                                      ],
                                    ),
                                    SizedBox(height: 16.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('二维码'.tr, style: style_12_99),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(QrcodeDialog(
                                                qrcodePath: detail
                                                    .ctcTradePay!.zfbAccount!));
                                          },
                                          child: CustomImage(
                                            Assets.imagesQrcode,
                                            width: 14.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 11.w),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              10.w.vb,
              AppealWidget(detail: appealDetail.value),
              80.w.vb,
              Visibility(
                visible:
                    appealDetail.value.userId == UserService.to.user.value.id,
                child: AppButton(
                  width: 315.w,
                  height: 48.w,
                  radius: 8,
                  backgroundColor: Config.kTheme!.bgMain,
                  borderSide: BorderSide(
                      color: Config.kTheme!.text1.withOpacity(0.8), width: 0.7),
                  onPressed: () {
                    Get.find<OrderDetailController>().cancelAppeal();
                  },
                  title: '撤销申诉'.tr,
                  titleStyle: TextStyle(
                    color: Config.kTheme!.text2,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              20.w.vb,
            ],
          ),
        ),
      ),
    );
  }
}

class AppealWidget extends HookWidget {
  const AppealWidget({super.key, required this.detail});

  final AppealDetailRes detail;

  @override
  Widget build(BuildContext context) {
    final reasonController = useTextEditingController();
    final contentController = useTextEditingController();
    reasonController.text = detail.reason ?? '';
    contentController.text = detail.content ?? '';

    var imgs = detail.imgs ?? [];
    var videos = detail.videoUrls ?? [];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Color(0xff131313), borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.w,
              ),
              Text(
                '申诉原因'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              10.w.vb,
              TextField(
                controller: reasonController,
                readOnly: true,
                style: TextStyle(fontSize: 17.sp, color: Color(0xff9b9b9b)),
                maxLines: null,
                decoration: outlineInputDecoration.copyWith(
                    fillColor: Color(0xff232323)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.w,
              ),
              Text(
                '申诉内容'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              10.w.vb,
              TextField(
                controller: contentController,
                style: TextStyle(fontSize: 17.sp, color: Color(0xff9b9b9b)),
                readOnly: true,
                maxLines: null,
                decoration: outlineInputDecoration.copyWith(
                    fillColor: Color(0xff232323)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.w.vb,
              Text(
                '添加交易截图'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              10.w.vb,
              Container(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 5.w,
                  runSpacing: 5.w,
                  children: [
                    ...List.generate(
                      imgs.length,
                      (index) => ClipRRect(
                        borderRadius: BorderRadius.circular(4).r,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => HeroPhotoViewRouteWrapper(
                                  imageProvider: NetworkImage(imgs[index]),
                                  tag: 'appealImage_$index'),
                              transition: Transition.zoom,
                            );
                          },
                          child: Hero(
                            tag: 'appealImage_$index',
                            child: CustomImage(
                              imgs[index],
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.w.vb,
              Text(
                '添加交易录屏 (可选)'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              10.w.vb,
              Container(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 5.w,
                  runSpacing: 5.w,
                  children: [
                    ...List.generate(
                      videos.length,
                      (index) => VideoItem(path: videos[index]),
                    ),
                  ],
                ),
              )
            ],
          ),
          18.w.vb,
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => VideoPreviewPage(url: path),
          transition: Transition.zoom,
        );
      },
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4).r,
          color: const Color(0xff1c1c1c),
        ),
        child: const Center(
          child: Icon(
            Icons.play_circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
