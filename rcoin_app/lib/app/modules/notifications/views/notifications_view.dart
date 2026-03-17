import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/notifications/views/notifications_child_view.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/widgets/app_bar.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/paging_index.dart';
import 'package:otc_app/models/system_message.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotificationsViewState();
  }
}

class NotificationsViewState extends State<NotificationsView>
    with TickerProviderStateMixin {
  PageController pageController = PageController(keepPage: true);

  late TabController _tabController;

  late NotificationsController notiController;

  @override
  void initState() {
    notiController = NotificationsController();
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Column(
      children: [
        tabBarView(),
        Expanded(
            child: PageView.builder(
          physics: const PageScrollPhysics(),
          controller: pageController,
          itemCount: 3,
          itemBuilder: buildPage,
          onPageChanged: (v) {
            _tabController.animateTo(v);
          },
        ))
      ],
    );
  }

  Widget tabBarView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelPadding: const EdgeInsets.only(right: 20, left: 10),
            labelColor: Config.kTheme!.text1,
            labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1),
            unselectedLabelStyle: const TextStyle(
              fontSize: 18,
            ),
            unselectedLabelColor: Config.kTheme!.text2,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
            indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
            tabs: [
              Obx(() => Tab(
                  text: HomeController.to.unreadCount.value > 0
                      ? "${'交易'.tr}(${HomeController.to.unreadCount.value})"
                      : '交易'.tr)),
              Tab(text: '系统通知'.tr),
              Tab(text: '客服'.tr),
            ],
            onTap: (value) {
              pageController.jumpToPage(value);
            },
          )
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, int index) {
    if (index == 1 || index == 2) {
      return const NotificationsChildView();
    }
    return SpeedyPagedList<SystemMessage>.separator(
      controller: notiController,
      refreshOnStart: true,
      locatorMode: true,
      emptyWidget: const EmptyList(
        title: '',
      ),
      itemBuilder: (context, index, item) {
        return Item(
          detail: item,
          click: () async {
            if (item.tradeId != null) {
              //访问详情刷新已读状态
              await NetRepository.client.systemMessageDetail(item.id!);
              await Get.toNamed(Routes.ORDER_DETAIL, arguments: {
                'id': item.tradeId,
              });
            } else {
              await Get.toNamed(Routes.NOTIFICATION_DETAIL,
                  arguments: {'id': item.id!});
            }
            //更新未读数和未读状态
            HomeController.to.fetchUnreadCount();
            notiController.fetchData(0);
          },
        );
      },
      separatorBuilder: (context, index) => Container(),
    );
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
        child: Container(
            height: MediaQuery.of(context).padding.top + 48,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "消息".tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Config.kTheme!.text1,
                  ),
                ),
              ],
            )));
  }
}

class Item extends StatefulWidget {
  const Item({super.key, required this.detail, required this.click});

  final SystemMessage detail;

  final VoidCallback click;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool read = false;

  @override
  void initState() {
    read = widget.detail.readState == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        widget.click();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.w, left: 16, right: 16),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Config.kTheme!.bg1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              // padding: EdgeInsets.all(15.w),
              // decoration: BoxDecoration(
              //     // color: const Color(0xff232323),
              //     gradient: const LinearGradient(
              //         colors: [Color(0xff3C3832), Color(0xff594F42)]),
              //     borderRadius: BorderRadius.circular(26.w)),
              child: Stack(
                children: [
                  Positioned(
                      // top: 15.w,
                      // left: 15.w,
                      // right: 15.w,
                      // bottom: 15.w,
                      child: CustomImage(
                    Assets.msgIcon,
                    width: 52.w,
                  )),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Offstage(
                      offstage: read,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffCB1A1A),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            10.w.hb,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${widget.detail.title}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Config.kTheme!.text1,
                        ),
                      )),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          formatDateTime(widget.detail.createdAt!),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Config.kTheme!.text2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.w.vb,
                  Text(
                    '${widget.detail.content}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Config.kTheme!.text2,
                    ),
                  ),
                  6.w.vb,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
