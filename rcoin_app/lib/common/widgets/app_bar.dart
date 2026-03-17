import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otc_app/app.dart';

import 'app_bar_back_button.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    Key? key,
    this.leading,
    this.title,
    this.titleWidget,
    this.backgroundColor,
    this.shadow = false,
    this.systemOverlayStyle,
    this.backIconColor,
    this.actions,
    this.isRootNavigator = false,
  }) : super(key: key);

  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool shadow;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? backIconColor;
  final bool isRootNavigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: shadow
            ? Border(
                bottom: BorderSide(
                color: const Color(0xffefefef),
                width: 1.w,
              ))
            : null,
      ),
      child: AppBar(
        backgroundColor: backgroundColor,
        titleSpacing: 0,
        leadingWidth: kMinInteractiveDimensionCupertino * 2,
        leading: _buildLeading(context),
        automaticallyImplyLeading: !isRootNavigator,
        title: titleWidget ?? (title != null ? Text(title!) : null),
        systemOverlayStyle: systemOverlayStyle,
        actions: actions,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (isRootNavigator) return null;
    final route = ModalRoute.of(context);
    if (route is PageRoute && (route.canPop || route.fullscreenDialog)) {
      // return AppBarBackButton(color: backIconColor);
      return const CircleLeading();
    }
    return null;
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kMinInteractiveDimensionCupertino+20);
}
