import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/fill_remain_widget.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/receipt_controller.dart';

final GlobalKey _boundaryKey = GlobalKey();

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: FillRemainWidget(
        topChildren: [
         Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             Text('您的收款二维码'.tr),
           ],
         ),
          8.w.vb,
          const _ReceiveCode(),
          27.w.vb,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                width: 123.w,
                height: 41.w,
                onPressed: () async {
                  final res = await saveImage2Gallery(_boundaryKey);
                  Toast.showSuccess('保存成功'.tr);
                },
                title: '保存'.tr,
                titleStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primary,
                ),
                backgroundColor: context.appColors.primary.withOpacity(.3),
              ),
              20.w.hb,
              AppButton(
                width: 123.w,
                height: 41.w,
                onPressed: () {
                  Share.share(
                      ApplicationController.to.assets.value?.address ?? '',
                      subject: '收款地址'.tr);
                },
                title: '分享'.tr,
                titleStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primary,
                ),
                backgroundColor: context.appColors.primary.withOpacity(.3),
              ),
            ],
          ),
          20.w.vb,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '您的收款地址:'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff171717),
              ),
            ),
          ),
          5.w.vb,
          Container(
            height: 46.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Color(0xfff4f4f4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260.w,
                  child: Text(
                        ApplicationController.to.assets.value?.address ?? '',
                          style: TextStyle(
                              fontSize: 14.sp, color: context.appColors.primary),
                        ),
                ),
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
                // CustomImage(
                //   Assets.newimagesHomeCopy,
                //   color: context.appColors.primary,
                // )
              ],
            ),
          )
        ],
        bottomChild: Padding(
          padding:  const EdgeInsets.only(bottom: 28.0),
          child: AppButton(
            height: 41.w,
            width: 334.w,
            onPressed: () {
              Get.toNamed(Routes.TRANSFER);
            },
            title: '转账'.tr,
            radius: 40,
          ),
        ),
      ),
    );
  }
}

class _ReceiveCode extends StatelessWidget {
  const _ReceiveCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _boundaryKey,
      child: Container(
        width: 264.w,
        height: 264.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: context.appColors.primary,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
              spreadRadius: 10.0,
              offset: Offset(0, 30),
            ),
          ],
        ),
        child: QrImageView(
          padding: const EdgeInsets.all(25),
          embeddedImage: const AssetImage(Assets.iconIcon),
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.white,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.white,
          ),
          data: ApplicationController.to.assets.value?.address ?? '',
        ),
      ),
    );
  }
}
