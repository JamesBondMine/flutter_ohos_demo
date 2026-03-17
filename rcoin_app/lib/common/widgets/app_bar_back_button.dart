import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/main.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Image.asset(
          Assets.imagesIcNavBack,
          width: 22,
          height: 22,
          color: color ?? const Color(0xff999999),
        ),
        onPressed: () async {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        },
      ),
    );
  }
}
