import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/empty_list.dart';
import 'package:otc_app/common/widgets/app_bar.dart';
import 'package:otc_app/models/app_response.dart';
import 'package:otc_app/models/paging_index.dart';
import 'package:otc_app/models/system_message.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/network/request/paging_request.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/notifications_controller.dart';

class NotificationsChildView extends StatefulWidget {
  const NotificationsChildView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotificationsChildViewState();
  }
}

class NotificationsChildViewState extends State<NotificationsChildView> {
  late NotificationsController notiController;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int pageNumber = 1;

  late List<SystemMessage> dataList = [];

  @override
  void initState() {
    notiController = NotificationsController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.kTheme!.bgMain,
      body: _listView(),
    );
  }

  Widget _listView() {
    return GetBuilder<NotificationsController>(
        id: NotificationsController.to.notificationListRefreshId,
        builder: (value) {
          return FutureBuilder(
              future: loadListData(),
              builder: (c, AsyncSnapshot<List<SystemMessage>> s) {
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(
                      complete: Text("成功".tr),
                    ),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("上拉加载".tr);
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = const Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = const Text("");
                        } else {
                          body = Text("没有更多".tr);
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                        itemCount:
                            !s.hasData || s.data!.isEmpty ? 1 : s.data!.length,
                        itemBuilder: (c, i) {
                          if (!s.hasData) {
                            return Container();
                          }
                          if (s.data!.isEmpty) {
                            return const EmptyList(
                              title: '',
                            );
                          }
                          SystemMessage item = s.data![i];
                          return InkWell(
                              onTap: () {
                                // AppNavigator.pushNovelDetail(context, model..isShelf=false);
                              },
                              child: Item(
                                detail: item,
                                click: () async {
                                  if (item.tradeId != null) {
                                    //访问详情刷新已读状态
                                    await NetRepository.client
                                        .systemMessageDetail(item.id!);
                                    await Get.toNamed(Routes.ORDER_DETAIL,
                                        arguments: {
                                          'id': item.tradeId,
                                        });
                                  } else {
                                    await Get.toNamed(
                                        Routes.NOTIFICATION_DETAIL,
                                        arguments: {'id': item.id!});
                                  }
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                              ));
                        }));
              });
        });
  }

  Future<List<SystemMessage>> loadListData() async {
    return [];
    List dl = [];
    AppResponse res = await Api.requestUserNotificationList({
      "pageSize": 10,
      "page": pageNumber,
    });
    if (res.code != 0) {
      return [];
    }

    Map daMap = res.data ?? {};
    dl = daMap["list"] ?? [];

    List<SystemMessage> datal =
        dl.map((e) => SystemMessage.fromJson(e)).toList();
    if (pageNumber == 1) {
      dataList = datal;
    } else {
      dataList.addAll(datal);
    }
    int total = daMap["total"] ?? 0;
    if (dataList.length >= total) {
      // 没有更多了
      _refreshController.loadNoData();
    } else {
      _refreshController.resetNoData();
    }
    return dataList;
  }

  void _onRefresh() async {
    pageNumber = 1;
    loadListData();
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    pageNumber += 1;
    loadListData();
    _refreshController.loadComplete();
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
                    color: const Color(0xffffffff),
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
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xff131313)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              // padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: const Color(0xff232323),
                  gradient: const LinearGradient(
                      colors: [Color(0xff3C3832), Color(0xff594F42)]),
                  borderRadius: BorderRadius.circular(26.w)),
              child: Stack(
                children: [
                  Positioned(
                      top: 15.w,
                      left: 15.w,
                      right: 15.w,
                      bottom: 15.w,
                      child: CustomImage(
                        Assets.msgIcon,
                        width: 20.w,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.detail.title}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        formatDateTime(widget.detail.createdAt!),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: context.appColors.textPlaceholder,
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
                      color: context.appColors.text4,
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
