import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';

class CopyBtn extends StatelessWidget {
  const CopyBtn(
      {super.key, required this.text, this.color, required this.size});

  final String text;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: text))
            .then((value) => Toast.showSuccess('复制成功'.tr));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
        child: CustomImage(Assets.newimagesHomeCopy,
            color: color ?? Config.kTheme!.bg5),
      ),
    );
  }
}
