import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File> compressFile(
  File file, {
  int minWidth = 200,
  int minHeight = 200,
  int quality = 95,
}) async {
  final directory = await getTemporaryDirectory();

  // 构建文件路径
  final filePath = '${directory.path}/temp.jpg';
  await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    filePath,
    minHeight: minHeight,
    minWidth: minWidth,
    quality: quality,
  );
  return File(filePath);
}
