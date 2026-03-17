import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/common/widgets/app_bar.dart';

import '../controllers/notification_detail_controller.dart';

class NotificationDetailView extends GetView<NotificationDetailController> {
  const NotificationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: '通知',
        shadow: true,
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text(
                '${state?.title}',
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              10.w.vb,
              Text(
                '${state?.content}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.appColors.text4,
                ),
              ),
              10.w.vb,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formatDateTime(state!.createdAt!),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.appColors.textPlaceholder,
                  ),
                ),
              ),
            ],
          ),
        ),
        onLoading: SpinKitFadingCircle(
          size: 25,
          color: Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}
