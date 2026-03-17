import 'dart:math';

import 'package:flutter/material.dart';

class CustomUnderlineDecoration extends Decoration {
  final BorderSide borderSide;
  final double width;
  final Radius borderRadius;

  CustomUnderlineDecoration({
    required this.borderSide,
    required this.width,
    this.borderRadius = Radius.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomUnderlinePainter(
      borderSide: borderSide,
      width: width,
      borderRadius: borderRadius,
      onChanged: onChanged,
    );
  }
}

class _CustomUnderlinePainter extends BoxPainter {
  final BorderSide borderSide;
  final double width;
  final Radius borderRadius;

  _CustomUnderlinePainter({
    required this.borderSide,
    required this.width,
    this.borderRadius = Radius.zero,
    VoidCallback? onChanged,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect =
    offset & Size(configuration.size!.width, configuration.size!.height);
    final Paint paint = borderSide.toPaint();

    final double indicatorWidth = min(rect.width, width);

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        rect.center.dx - indicatorWidth / 2,
        rect.bottom - borderSide.width,
        indicatorWidth,
        borderSide.width,
      ),
      borderRadius,
    );

    canvas.drawRRect(rrect, paint);
  }
}