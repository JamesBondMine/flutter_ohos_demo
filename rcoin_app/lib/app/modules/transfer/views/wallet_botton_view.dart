import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/transfer/views/wallet_receive.dart';
import 'package:otc_app/app/modules/transfer/views/wallet_transfer_view.dart';
import 'package:otc_app/app/widgets/bottom_select.dart';

class WalletButtons extends StatelessWidget {
  const WalletButtons({super.key, required this.trade});

  final VoidCallback trade;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Button(
          icon: const CustomImage(
            Assets.walletIcon1,
            width: 48,
            height: 48,
          ),
          title: '充值'.tr,
          onTap: () {
            Get.toNamed(Routes.RECHARGE);
          },
        ),
        _Button(
          icon: const CustomImage(
            Assets.walletIcon2,
            width: 48,
            height: 48,
          ),
          title: '转账'.tr,
          onTap: () async {
            Get.to(WalletTransferPage());
          },
        ),
        _Button(
          icon: const CustomImage(
            Assets.walletIcon3,
            width: 48,
            height: 48,
          ),
          title: '接收'.tr,
          onTap: () {
            Get.to(WalletReceivePage());
          },
        ),
        _Button(
          icon: const CustomImage(
            Assets.walletIcon4,
            width: 48,
            height: 48,
          ),
          title: '交易'.tr,
          onTap: () {
            trade();
          },
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    this.color,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final Color? color;
  final Widget icon;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)).r,
              color: color,
            ),
            alignment: Alignment.center,
            child: icon,
          ),
          10.w.vb,
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Config.kTheme!.text1,
            ),
          )
        ],
      ),
    );
  }
}
