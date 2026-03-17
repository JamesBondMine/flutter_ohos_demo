import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/service_online/models/message.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/services/chat_service.dart';

import '../controllers/conversation_list_controller.dart';

class ConversationListView extends GetView<ConversationListController> {
  const ConversationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: '聊天',
        shadow: true,
      ),
      body: Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (BuildContext context, int index) {
              return ConversationItem(detail: controller.groups[index]);
            },
            itemCount: controller.groups.length,
          )),
    );
  }
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key, required this.detail});

  final ChatDialogue detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.toNamed(Routes.CHAT_PAGE, arguments: {
          'group_id': detail.groupId,
          'user_id': 0,
          'group': detail,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.w),
        child: Row(
          children: [
            Avatar(width: 32.w, imagePath: detail.groupAvatar),
            10.w.hb,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.groupName,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  5.w.vb,
                  Obx(() => Text(
                    detail.lastMsg.value == null ? '' : detail.lastMsg.value!.summary(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff7E7E7E),
                    ),
                  )),
                ],
              ),
            ),
            20.w.hb,
            Container(
              height: 43.w,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Text(
                    detail.lastMsg.value == null
                        ? ''
                        : ucTimeAgo(
                        detail.lastMsg.value!.createdAt),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.textPlaceholder,
                    ),
                  )),
                  5.w.vb,
                  Offstage(
                    offstage: detail.unreadCount.value == 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                      decoration: detail.unreadCount.value < 9
                          ? const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE65157),
                            )
                          : const ShapeDecoration(
                              shape: StadiumBorder(),
                              color: Color(0xffE65157),
                            ),
                      alignment: Alignment.center,
                      child: Text(
                        '${detail.unreadCount.value > 99 ? '99+' : detail.unreadCount.value}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
