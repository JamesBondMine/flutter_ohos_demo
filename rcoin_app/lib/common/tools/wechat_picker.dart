import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otc_app/common/widgets/toast.dart';
import 'package:otc_app/network/repository.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'compress_file.dart';

Future<List<AssetEntity>?> pickAssetEntity({
  required BuildContext context,
  required int maxAssetsCount,
  List<AssetEntity>? selectedAssets,
  RequestType requestType = RequestType.image,
}) {
  const AssetPickerTextDelegate textDelegate = AssetPickerTextDelegate();
  return AssetPicker.pickAssets(
    context,
    pickerConfig: AssetPickerConfig(
      maxAssets: maxAssetsCount,
      selectedAssets: selectedAssets,
      requestType: requestType,
      specialItemPosition: SpecialItemPosition.prepend,
      specialItemBuilder: (
        BuildContext context,
        AssetPathEntity? path,
        int length,
      ) {
        if (path?.isAll != true) {
          return null;
        }
        return Semantics(
          label: textDelegate.sActionUseCameraHint,
          button: true,
          onTapHint: textDelegate.sActionUseCameraHint,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final AssetEntity? result = await pickFromCamera(context,
                  enableRecording: requestType == RequestType.video);
              if (result == null) {
                return;
              }
              final AssetPicker<AssetEntity, AssetPathEntity> picker =
                  context.findAncestorWidgetOfExactType()!;
              final DefaultAssetPickerBuilderDelegate builder =
                  picker.builder as DefaultAssetPickerBuilderDelegate;
              final DefaultAssetPickerProvider p = builder.provider;
              await p.switchPath(
                PathWrapper<AssetPathEntity>(
                  path: await p.currentPath!.path.obtainForNewProperties(),
                ),
              );
              p.selectAsset(result);
            },
            child: const Center(
              child: Icon(Icons.camera_enhance, size: 42.0),
            ),
          ),
        );
      },
    ),
  );
}

Future<AssetEntity?> pickFromCamera(BuildContext c,
    {bool enableRecording = false}) {
  return CameraPicker.pickFromCamera(
    c,
    pickerConfig: CameraPickerConfig(enableRecording: enableRecording),
  );
}

Future<String?> uploadImageWithCompress(
  BuildContext context, {
  int minWidth = 200,
  int minHeight = 200,
}) async {
  List<AssetEntity>? entities =
      await pickAssetEntity(context: context, maxAssetsCount: 1);
  if (entities == null) {
    return null;
  }
  var file = (await (entities.first).file)!;
  file = await compressFile(file, minWidth: 500, minHeight: 500);

  final res = await NetRepository.uploadClient
      .upload(file);
  if (res.code != 0) {
    Toast.showError(res.msg);
    return null;
  }
  final url = (res.data as UploadResponse).url;
  return url;
}
