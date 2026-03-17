import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ScanPageView extends StatefulWidget {
  const ScanPageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanPageViewState();
}

class _ScanPageViewState extends State<ScanPageView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const AAppBar(
      //   leading: CircleLeading(),
      // ),
      // appBar: ,
      body: Stack(
        children: [
          Positioned.fill(child: _buildQrView(context)),
          Positioned(
            bottom: 60,
            left: 0,
            width: Get.width,
            child: SizedBox(
              width: Get.width,
              height: 80,
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    _openGallery();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.withOpacity(0.5)),
                    child: const Icon(
                      Icons.image_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(left: 0, top: 0, right: 0, child: _headerView(context))
        ],
      ),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 48.w,
                height: 48.w,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Text(
              ''.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffffffff),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  //打开文件夹
  Future _openGallery() async {
    if (Platform.isAndroid) {
      // 检查权限
      await Permission.storage.request();
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.storage,
      ].request();

      // 检查权限是否被授予
      if (statuses[Permission.storage] == PermissionStatus.granted ||
          statuses[Permission.photos] == PermissionStatus.granted) {
        // 权限被授予，执行你的操作
        print("Storage permission has been granted.");
      } else {
        // 权限被拒绝，你可以选择再次解释为什么需要这个权限
        print("Storage permission has not been granted.");
        Toast.showInfo("Storage permission has not been granted.");
        return;
      }
    }
    // ignore: use_build_context_synchronously
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(maxAssets: 1));
    if (result != null) {
      AssetEntity assetEntity = result.first;
      File? item = await assetEntity.file;
      if (item != null) {
        String? result = await Scan.parse(item.path);
        if (result != null) {
          if (result.contains("orderSn")) {
            Get.back(result: result);
          } else {
            Toast.showInfo('未识别'.tr);
          }
        } else {
          Toast.showInfo('未识别'.tr);
        }
      } else {
        Toast.showInfo('未识别'.tr);
      }
    }
  }

  Future _canload() async {
    if (Platform.isAndroid) {
      return true;
    }
    // 处理iOS卡顿的问题
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget _buildQrView(BuildContext context) {
    return FutureBuilder(
        future: _canload(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          var scanArea = 300.r;
          // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
          // To ensure the Scanner view is properly sizes after rotation
          // we need to listen for Flutter SizeChanged notification and update controller
          return QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Theme.of(context).primaryColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          );
        }));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.first.then((scanData) {
      String? code = (scanData as Barcode).code;
      if (code != null) {
        if (code.contains("orderSn")) {
          Get.back(result: scanData);
        } else {
          Toast.showInfo('未识别'.tr);
        }
      } else {
        Toast.showInfo('未识别'.tr);
      }
    }).catchError((error) => null);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
