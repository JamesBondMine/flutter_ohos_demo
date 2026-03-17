import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';

import '../controllers/team_sub_members_controller.dart';

class TeamSubMembersView extends GetView<TeamSubMembersController> {
  const TeamSubMembersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AAppBar(
        title: '团队用户'.tr,
      ),
      body: SpeedyPagedList<UserStatisticFon>.separator(
        padding: EdgeInsets.all(16.w),
        controller: controller,
        refreshOnStart: true,
        locatorMode: true,
        emptyWidget: const EmptyList(
          title: '',
        ),
        itemBuilder: (context, index, item) {
          return MemberItem(detail: item);
        },
        separatorBuilder: (context, index) => 16.w.vb,
      ),
    );
  }
}

class MemberItem extends StatelessWidget {
  const MemberItem({super.key, required this.detail});

  final UserStatisticFon detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (detail.direct == 1) {
          Get.toNamed(Routes.AGENT_SETTING_PAGE, arguments: {
            'detail': detail,
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding:
              const EdgeInsets.only(top: 6, bottom: 8, left: 13, right: 15)
                  .w,
              child: Row(
                children: [
                  Avatar(
                    imagePath: detail.headerImg!,
                    width: 24.w,
                  ),
                  10.w.hb,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detail.nickName!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                      5.w.vb,
                      Text(detail.username!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.appColors.textPlaceholder,
                          )),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                      formatDateTime(detail.CreatedAt!,
                          format: 'yyyy.MM.dd'),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.appColors.text4,
                      )),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}