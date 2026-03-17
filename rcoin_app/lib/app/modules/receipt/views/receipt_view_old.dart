import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/receipt_controller.dart';

final GlobalKey _boundaryKey = GlobalKey();

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF6F6F6),
        child: Column(
          children: [
            50.w.vb,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 240.w,
                      height: 268.w,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF7C42B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          22.w.vb,
                          RepaintBoundary(
                            key: _boundaryKey,
                            child: Container(
                              color: Colors.white,
                              child: QrImageView(
                                padding: const EdgeInsets.all(30).w,
                                size: 200.w,
                                data: ApplicationController
                                    .to.assets.value?.address?? '',
                              ),
                            ),
                          ),
                          13.w.vb,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  final res =
                                      await saveImage2Gallery(_boundaryKey);
                                  Toast.showSuccess('保存成功'.tr);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.download,
                                      size: 18.w,
                                    ),
                                    2.w.hb,
                                    Text(
                                      '保存'.tr,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Share.share(
                                      ApplicationController.to.assets.value!.address!,
                                      subject: '收款地址'.tr);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 18.w,
                                    ),
                                    2.w.hb,
                                    Text(
                                      '分享'.tr,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    30.w.vb,
                    Container(
                      width: 300.w,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      padding: EdgeInsets.all(6.w),
                      child: Row(
                        children: [
                          Text(
                            '收款地址'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                          22.w.hb,
                          Expanded(
                              child: Text(
                            ApplicationController.to.assets.value?.address ?? '',
                            style: TextStyle(
                              color: context.appColors.primary,
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: ApplicationController
                                        .to.assets.value!.address!));
                                Toast.showSuccess('复制成功'.tr);
                              },
                              child: Icon(
                                Icons.copy,
                                color: context.appColors.primary,
                                size: 18.w,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 65.w,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 116.w,
                    height: 38.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333333),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          )),
                      onPressed: () async {
                        Get.toNamed(Routes.RECEIPT_LOGS);
                      },
                      child: Text(
                        '收款记录'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 116.w,
                    height: 38.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.appColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          )),
                      onPressed: () {

                        Get.toNamed(Routes.TRANSFER);
                      },
                      child: Text(
                        '转账'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xff48484A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
