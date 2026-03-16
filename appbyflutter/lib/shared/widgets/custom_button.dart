import 'package:flutter/material.dart';

/// 通用主按钮
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(title, style: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
