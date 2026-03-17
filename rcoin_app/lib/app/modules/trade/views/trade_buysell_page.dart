import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/trade/controllers/trade_controller.dart';
import 'package:otc_app/app/modules/trade/views/trade_child_view.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/services/chat_service.dart';

class TradeBuySellPage extends StatefulWidget {
  TradeBuySellPage({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  State<StatefulWidget> createState() {
    return TradeBuySellPageState();
  }
}

class TradeBuySellPageState extends State<TradeBuySellPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  PageController pageController = PageController(keepPage: true);

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.index);
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerView(context),
      backgroundColor: Config.kTheme!.bgMain,
      body: _childrenView(context),
    );
  }

  Widget _childrenView(BuildContext context) {
    return Column(
      children: [tabBarView(), Expanded(child: _bodyView())],
    );
  }

  Widget _bodyView() {
    return PageView.builder(
      physics: const PageScrollPhysics(),
      controller: pageController,
      itemCount: 2,
      itemBuilder: buildPage,
      onPageChanged: (v) {
        _tabController.animateTo(v);
      },
    );
  }

  Widget buildPage(BuildContext context, int index) {
    if (index == 0) {
      return TradeChildView(side: PaySide.buy);
    }
    return TradeChildView(side: PaySide.sell);
  }

  Widget tabBarView() {
    return GetBuilder<TradeController>(
        id: TradeController.to.tradePageRefreshId,
        builder: (value) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(right: 20, left: 10),
                    labelColor: Config.kTheme!.text1,
                    labelStyle: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Config.kTheme!.text2,
                    indicatorColor: Color(0xffffffff),
                    // dividerColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1,
                    indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide.none),
                    indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                    tabs: [Tab(text: '买币'.tr), Tab(text: '卖币'.tr)],
                    onTap: (value) {
                      pageController.jumpToPage(value);
                    },
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.POST_ORDER_PAGE);
                },
                child: Container(
                  width: Get.width,
                  height: 36.w,
                  padding: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Config.kTheme!.bgbtn,
                    Config.kTheme!.bgw,
                    Config.kTheme!.bgbtn,
                    Config.kTheme!.bgMain
                  ])),
                  child: Row(
                    children: [
                      Text(
                        "There are no suitable merchants",
                        style: TextStyle(
                            color: Config.kTheme!.text2, fontSize: 12.sp),
                      ),
                      Text(
                        "pending order".tr,
                        style: TextStyle(
                          color: Config.kTheme!.text1,
                          decoration: TextDecoration.underline,
                          decorationColor: Config.kTheme!.text1,
                          decorationThickness: 1.0,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  PreferredSize _headerView(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Text(
              '交易'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Config.kTheme!.text1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              child: CustomImage(
                Assets.newimagesCommentService,
                color: Config.kTheme!.text1,
                onTap: () {
                  ChatService.to.goChatWithService();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
