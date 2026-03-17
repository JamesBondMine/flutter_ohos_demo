import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/tools/capture.dart';
import 'package:photo_view/photo_view.dart';

import 'app_bar_back_button.dart';

final GlobalKey _boundaryKey = GlobalKey();

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    super.key,
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    required this.tag,
  });

  final String tag;
  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            key: _boundaryKey,
            child: Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: PhotoView(
                imageProvider: imageProvider,
                backgroundDecoration: backgroundDecoration,
                minScale: minScale,
                maxScale: maxScale,
                heroAttributes: PhotoViewHeroAttributes(tag: tag),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: statusBarHeight,
            child: AppBarBackButton(),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              onPressed: () async {
                final res = await saveImage2Gallery(_boundaryKey);
                Toast.showSuccess('保存成功'.tr);
              },
            ),
          )
        ],
      ),
    );
  }
}
