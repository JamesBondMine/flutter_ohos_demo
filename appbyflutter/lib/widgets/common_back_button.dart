import 'package:flutter/material.dart';

/// 通用返回按钮组件
class CommonBackButton extends StatelessWidget {
  /// 图标颜色
  final Color? color;

  /// 自定义点击回调，不传则默认返回上一页
  final VoidCallback? onTap;

  const CommonBackButton({
    super.key,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? Colors.black,
        size: 20,
      ),
      onPressed: onTap ??
          () {
            Navigator.maybePop(context);
          },
    );
  }
}

