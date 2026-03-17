import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/receipt/views/receipt_view.dart';
import 'package:otc_app/app/modules/teams/controllers/team_member_controller.dart';
import 'package:otc_app/app/modules/teams/controllers/team_reward_controller.dart';
import 'package:otc_app/app/modules/teams/views/team_rule.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/app/widgets/tab_indicator.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/network/response/brokerage_list_fon.dart';
import 'package:otc_app/network/response/user_statistic_fon.dart';

import '../controllers/teams_controller.dart';

class TeamsView extends GetView<TeamsController> {
  const TeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AAppBar(
        backgroundColor: Colors.white,
        title: '我的团队'.tr,
      ),
      body: Column(
        children: [
          _TabBar(controller: controller.tabController),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Column(
                  children: [
                    Obx(() => Container(
                          margin: const EdgeInsets.all(14).r,
                          child: Column(
                            children: [
                              Container(
                                height: 61.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(38, 86, 208, 0.10),
                                      blurRadius: 20.0,
                                      spreadRadius: 4.0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          12.w.hb,
                                          CustomImage(
                                            Assets.teamCrown,
                                            width: 16.w,
                                          ),
                                          6.w.hb,
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '我的团队'.tr,
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      context.appColors.text1,
                                                ),
                                              ),
                                              10.w.vb,
                                              Text(
                                                '${controller.statistics.value.totalReferral ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 19.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      context.appColors.text1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${controller.statistics.value.directReferral ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: context
                                                          .appColors.text1,
                                                    ),
                                                  ),
                                                  6.w.hb,
                                                  Text(
                                                    '直接邀请'.tr,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: context
                                                          .appColors.text1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.w.vb,
                                              Row(
                                                children: [
                                                  Text(
                                                    '${controller.statistics.value.indirectReferral ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: context
                                                          .appColors.text1,
                                                    ),
                                                  ),
                                                  6.w.hb,
                                                  Text(
                                                    '间接邀请'.tr,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: context
                                                          .appColors.text1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          17.w.hb,
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              vertical: 3)
                                          .r,
                                      child: CustomImage(
                                        Assets.teamPeople,
                                        width: 38.w,
                                      ),
                                    ),
                                    6.w.hb,
                                  ],
                                ),
                              ),
                              16.w.vb,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '今日收益'.tr,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: context.appColors.text1,
                                        ),
                                      ),
                                      Text(
                                        '${controller.statistics.value.todayEarnings ?? ''}'
                                            .rtz,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: context.appColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '昨日收益'.tr,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: context.appColors.text1,
                                        ),
                                      ),
                                      Text(
                                        '${controller.statistics.value.yesterdayEarnings ?? ''}'
                                            .rtz,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: context.appColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '累计收益'.tr,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: context.appColors.text1,
                                        ),
                                      ),
                                      Text(
                                        '${controller.statistics.value.totalEarnings ?? ''}'
                                            .rtz,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: context.appColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Expanded(
                      child: SpeedyPagedList<UserStatisticFon>.separator(
                        padding: EdgeInsets.all(16.w),
                        controller: Get.find<TeamMemberController>(),
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
                    ),
                  ],
                ),
                SpeedyPagedList<BrokerageListFon>.separator(
                  padding: EdgeInsets.all(16.w),
                  controller: Get.find<TeamRewardController>(),
                  refreshOnStart: true,
                  locatorMode: true,
                  emptyWidget: const EmptyList(
                    title: '',
                  ),
                  itemBuilder: (context, index, item) {
                    return RewardItem(detail: item);
                  },
                  separatorBuilder: (context, index) => 16.w.vb,
                ),
                // const TeamRule(),
                ReceiptView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.w, bottom: 18.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xffEFEFEF)))),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: context.appColors.primary,
        indicator: CustomUnderlineDecoration(
          borderSide: BorderSide(color: context.appColors.primary, width: 1.w),
          width: 30.w,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 17.sp),
        labelStyle: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
        labelColor: context.appColors.primary,
        unselectedLabelColor: const Color(0xff48484A),
        labelPadding: EdgeInsets.symmetric(vertical: 6.w),
        controller: controller,
        tabs: [
          Text('我的代理'.tr),
          Text('代理佣金'.tr),
          Text('转账'.tr),
        ],
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          formatDateTime(detail.CreatedAt!,
                              format: 'yyyy.MM.dd'),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.appColors.text4,
                          )),
                      4.w.vb,
                      Row(
                        children: [
                          Text("${detail.directReferral} ${'直邀'.tr}",
                              style: TextStyle(
                                fontSize: 14,
                                color: context.appColors.text1,
                              )),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.TEAM_SUB_MEMBERS,
                                    arguments: {
                                      'user_id': detail.userId,
                                    });
                              },
                              child: const Icon(Icons.keyboard_arrow_right)),
                        ],
                      ),
                      4.w.vb,
                      Text("${detail.indirectReferral} ${'间邀'.tr}",
                          style: TextStyle(
                            fontSize: 14,
                            color: context.appColors.text1,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1.w,
              color: context.appColors.divider2,
              padding: const EdgeInsets.only(left: 6, right: 3).r,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 29.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("今日贡献".tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.appColors.text1,
                          )),
                      Text(
                        "${detail.todayContribution}".rtz,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: context.appColors.primary,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("昨日贡献".tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.appColors.text1,
                          )),
                      Text(
                        "${detail.yesterdayContribution}".rtz,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: context.appColors.primary,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("累计贡献".tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.appColors.text1,
                          )),
                      Text(
                        "${detail.contribution}".rtz,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: context.appColors.primary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  const RewardItem({super.key, required this.detail});

  final BrokerageListFon detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        color: Colors.white,
      ),
      child: Container(
        padding:
            const EdgeInsets.only(top: 6, bottom: 8, left: 13, right: 15).w,
        child: Row(
          children: [
            Avatar(
              imagePath: detail.contributorHeaderImg!,
              width: 24.w,
            ),
            10.w.hb,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${detail.contributorNickName}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                5.w.vb,
                Text("${detail.contributorUsername}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.appColors.textPlaceholder,
                    )),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(formatDateTime(detail.CreatedAt!),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.appColors.text4,
                    )),
                8.w.vb,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(detail.tradeType == 1 ? "买入".tr : '卖出'.tr,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: detail.tradeType == 1
                                  ? context.appColors.green
                                  : context.appColors.red,
                            )),
                        Text("${detail.tradeAmount!.rtz} ${Config.coinName}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.primary))
                      ],
                    ),
                    21.w.hb,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("佣金金额".tr,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.appColors.text1,
                            )),
                        Text(detail.amount!.rtz,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.primary))
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
