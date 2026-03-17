import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.color,
    this.onTap,
  });

  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? buildImage(context)
        : GestureDetector(
            onTap: onTap,
            child: buildImage(context),
          );
  }

  Widget buildImage(BuildContext context) {
    Widget errorWidget = SizedBox(
      width: width,
      height: height,
    );

    if (path.startsWith('http://') || path.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: path,
        color: color,
        fit: fit,
        width: width,
        height: height,
        errorListener: (e) {
          if (e is SocketException) {
            print('Error with ${e.address} and message ${e.message}');
          } else {
            print('Image Exception is: ${e.runtimeType}');
          }
        },
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) {
          return errorWidget;
        },
      );
    }
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        color: color,
        fit: fit,
        width: width,
        height: height,
      );
    }
    return Image.asset(
      path,
      color: color,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) =>
          errorWidget,
    );
  }
}
