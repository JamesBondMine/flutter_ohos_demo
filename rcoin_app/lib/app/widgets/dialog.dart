import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/confirm_bottomsheet.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:otc_app/common/tools/text_input_formatter.dart';
import 'package:otc_app/models/payment_type.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

//角色认证弹窗
class AuthRoleDialog extends StatelessWidget {
  const AuthRoleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding:
          EdgeInsets.only(left: 13.w, right: 13.w, top: 10.w, bottom: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Assets.imagesInformation, width: 118.w),
          8.w.vb,
          Text("您暂无权限发布广告，请认证角色身份",
              style: TextStyle(
                fontSize: 17,
                color: context.appColors.text1,
              )),
          26.w.vb,
          SizedBox(
            width: 261.w,
            height: 36.w,
            child: ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.AUTH_ROLE, arguments: {"type": 1});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  )),
              child: Text("认证成为承兑",
                  style: TextStyle(
                    fontSize: 17,
                    color: context.appColors.text1,
                  )),
            ),
          ),
          12.w.vb,
          SizedBox(
            width: 261.w,
            height: 36.w,
            child: ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.AUTH_ROLE, arguments: {"type": 2});
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  )),
              child: Text("认证成为商户",
                  style: TextStyle(
                    fontSize: 17,
                    color: context.appColors.text1,
                  )),
            ),
          ),
        ],
      ),
    );

    child = Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: Color(0xff8c8c8c),
            ),
          ),
        ),
      ],
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: child,
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.title, this.content = ""});

  final String title;

  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff131313),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.w),
            SvgPicture.asset(Assets.imagesWarning, width: 36.w),
            SizedBox(height: 20.w),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            content.isEmpty ? Container() : SizedBox(height: 20.w),
            content.isEmpty
                ? Container()
                : Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xff9b9b9b),
                    ),
                  ),
            SizedBox(height: 18.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 84.w,
                  height: 36.w,
                  radius: 8.w,
                  onPressed: () {
                    Get.back(result: false);
                  },
                  title: '取消'.tr,
                  backgroundColor: const Color(0xff232323),
                  titleStyle: TextStyle(
                    fontSize: 17.sp,
                    color: Config.kTheme!.text2,
                  ),
                ),
                AppButton(
                  width: 84.w,
                  height: 36.w,
                  radius: 8.w,
                  backgroundColor: Config.kTheme!.text2,
                  onPressed: () {
                    Get.back(result: true);
                  },
                  title: '确认'.tr,
                  titleStyle:
                      TextStyle(fontSize: 17.sp, color: Config.kTheme!.text1),
                ),
              ],
            ),
            SizedBox(height: 14.w),
          ],
        ),
      ),
    );
  }
}

class PasswordInputDialog extends HookWidget {
  const PasswordInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.w),
            Text(
              '请输入交易密码'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 18.w),
            TextField(
              controller: controller,
              obscureText: true,
              inputFormatters: [
                positiveIntegerFieldFormatter,
              ],
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: outlineInputDecoration.copyWith(),
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: 84.w,
                  height: 36.w,
                  radius: 8.w,
                  onPressed: () {
                    Get.back();
                  },
                  title: '取消'.tr,
                  backgroundColor: const Color(0xffF7F7F7),
                  titleStyle: TextStyle(
                    fontSize: 17.sp,
                    color: const Color(0xff999999),
                  ),
                ),
                AppButton(
                  width: 84.w,
                  height: 36.w,
                  radius: 8.w,
                  onPressed: () {
                    Get.back(result: controller.text);
                  },
                  title: '确认'.tr,
                  titleStyle: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.w),
          ],
        ),
      ),
    );
  }
}

class QrcodeDialog extends StatelessWidget {
  const QrcodeDialog({
    super.key,
    required this.qrcodePath,
  });

  final String qrcodePath;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 251.w,
        height: 300.w,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 17.w),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '卖家收款二维码'.tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: context.appColors.text1,
                    ),
                  ),
                  23.w.vb,
                  Container(
                    width: 135.w,
                    height: 135.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.appColors.primary,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    child: UnconstrainedBox(
                      child: CustomImage(
                        qrcodePath,
                        width: 120.w,
                        height: 120.w,
                      ),
                    ),
                  ),
                  8.w.vb,
                  AppButton(
                    width: 88.w,
                    height: 30.w,
                    radius: 30.w,
                    onPressed: () async {
                      final res = await GallerySaver.saveImage(qrcodePath);
                      if (res != null && res) {
                        Toast.showSuccess('保存成功'.tr);
                      }
                    },
                    title: '保存'.tr,
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  color: Color(0xff8c8c8c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareAppDialog extends StatefulWidget {
  const ShareAppDialog({super.key});

  @override
  State<ShareAppDialog> createState() => _ShareAppDialogState();
}

class _ShareAppDialogState extends State<ShareAppDialog> {
  final GlobalKey _boundaryKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 100));
      final imageData = await captureImage(_boundaryKey);
      final file = await saveImage(imageData);
      Share.shareXFiles([
        XFile(file.path),
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RepaintBoundary(
        key: _boundaryKey,
        child: SizedBox(
          width: 323.w,
          height: 573.w,
          child: Stack(
            children: [
              CustomImage(
                Assets.imagesShareApp,
                width: 323.w,
                height: 573.w,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 82.w,
                child: Container(
                  alignment: Alignment.center,
                  child: QrImageView(
                    size: 170.w,
                    padding: const EdgeInsets.all(5),
                    data:
                        'https://h5.ddzf1.com/register.html?code=${UserService.to.user.value.inviteCode}',
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TradesDialog extends HookWidget {
  const TradesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return Timer.periodic(const Duration(milliseconds: 200), (_) {
        if (AppService.to.trades.isEmpty) {
          Get.back();
        }
      }).cancel;
    }, []);
    return Dialog(
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.w),
      // ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 335.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  14.w.vb,
                  Text(
                    '您有一笔新订单',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  10.w.vb,
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 450.w,
                    ),
                    color: const Color(0xFFF5F5F5),
                    padding: const EdgeInsets.all(10).w,
                    child: Obx(() => ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            _OrderItem(
                              key: ValueKey(AppService.to.trades[index]),
                              detail: AppService.to.trades[index],
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            10.w.vb,
                        itemCount: AppService.to.trades.length)),
                  ),
                  20.w.vb
                ],
              ),
            ),
            Container(
              height: 16.w,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const ShapeDecoration(
                  color: Colors.black,
                  shape: OvalBorder(),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({super.key, required this.detail});

  final TradeDetail detail;

  @override
  Widget build(BuildContext context) {
    var state = switch ((detail.isBuyer, detail.state!)) {
      (true, 1) => '待付款'.tr, //待付款
      (false, 1) => '待付款'.tr, //待付款

      (true, 2) => '待确认收款'.tr, //已付款/待确认
      (false, 2) => '待确认收款'.tr, //已付款/待确认
      (_, _) => '',
    };
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.ORDER_DETAIL, arguments: {
          'id': detail.id,
        });
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8).r),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                      left: 17, right: 15, top: 12, bottom: 10)
                  .w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '￥${detail.amount}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1.w,
              decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
            ),
            20.w.vb,
            Container(
              padding: const EdgeInsets.only(left: 19, right: 15).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomImage(Assets.homeCny),
                      Text(
                        PaymentType.fromValue(detail.payMethod!).text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        Assets.homeCopy,
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: '${detail.orderSn}'));
                          Toast.showSuccess('复制成功'.tr);
                        },
                      ),
                      Text(
                        '${detail.orderSn}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.w.vb,
            Container(
              padding: const EdgeInsets.only(left: 19, right: 15).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDateTime(detail.CreatedAt ?? ''),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
            ),
            17.w.vb,
          ],
        ),
      ),
    );
  }
}

class NoticeDialog extends HookWidget {
  const NoticeDialog(this.content, {super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    var c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(content);

    return Dialog(
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.w),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 335.w,
            constraints: BoxConstraints(
              maxHeight: 450.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            child: WebViewWidget(
              controller: c,
            ),
          ),
          Container(
            height: 16.w,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: OvalBorder(),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoticeDialogTip extends HookWidget {
  const NoticeDialogTip(this.content, {super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    // var c = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadHtmlString(content);

    return Dialog(
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.w),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 335.w,
            // constraints: BoxConstraints(
            //   maxHeight: Get.locale!.languageCode == 'zh' ? 200.w : 300.w,
            //   minHeight: Get.locale!.languageCode == 'zh' ? 150.w : 150.w,
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: Config.kTheme!.bgCard,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "温馨提示".tr,
                    style: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Text(
                  content,
                  style: TextStyle(
                    color: Config.kTheme!.text1,
                    fontSize: 16.sp,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 16.w,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                color: Config.kTheme!.bgCard,
                shape: OvalBorder(),
              ),
              child: Icon(Icons.close_rounded, color: Config.kTheme!.text1),
            ),
          )
        ],
      ),
    );
  }
}

Future<bool?> confirmBottomSheet(
    {required String title, required String subTitle}) async {
  return await Get.bottomSheet(
      ConfirmBottomSheet(title: title, subTitle: subTitle),
      backgroundColor: Config.kTheme!.bgw,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
}
