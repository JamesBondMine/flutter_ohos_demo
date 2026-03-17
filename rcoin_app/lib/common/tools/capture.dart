import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<Uint8List> captureImage(GlobalKey boundaryKey) async {
  RenderRepaintBoundary? boundary =
      boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
  if (boundary == null ||
      (kDebugMode &&
          boundary.debugNeedsPaint)) {
    await Future.delayed(const Duration(milliseconds: 20));
    return captureImage(boundaryKey);
  }
  double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
  var image = await boundary.toImage(pixelRatio: dpr);
  // 将image转化成byte
  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

  Uint8List pngBytes = byteData!.buffer.asUint8List();
  return pngBytes;
}

Future<bool> saveImage2Gallery(GlobalKey key) async {
  Uint8List uint8List = await captureImage(key);
  // if (Platform.isAndroid && !(await Permission.storage.isGranted)) {
  //   await Permission.storage.request();
  // }
  final result = await ImageGallerySaver.saveImage(uint8List, quality: 100);
  if (result != null) {
    return true;
  }
  return false;
}
