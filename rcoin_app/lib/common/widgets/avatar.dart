import 'package:flutter/material.dart';
import 'custom_image.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.width,
    this.imagePath,
    this.color,
  });

  final double width;
  final String? imagePath;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: (imagePath?.isNotEmpty ?? false)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(width),
              child: CustomImage(
                imagePath!,
                width: width,
                height: width,
                fit: BoxFit.fill,
              ),
            )
          : null,
    );
  }
}
