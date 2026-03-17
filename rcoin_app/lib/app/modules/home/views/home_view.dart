import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_controller.dart';
import 'package:otc_app/app/modules/home/views/home_header_view.dart';
import 'package:otc_app/app/modules/home/views/home_trade_menu.dart';
import 'package:otc_app/common/tools/channel.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/api.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _userInfo();

    _channelConfig();

    _config();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        body: FutureBuilder(
            future: _tradeListEvent(),
            builder: (context, AsyncSnapshot<List<TradeDetail>> snapshot) {
              return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.hasData && snapshot.data != null
                      ? snapshot.data!.length + 2
                      : 2,
                  itemBuilder: (item, index) {
                    if (index == 0) {
                      return const HomeHeaderView();
                    }
                    if (index == 1) {
                      return HomeTradeMenu(
                        click: (value) {
                          if (value == 0) {
                            Get.toNamed(Routes.HISTORY_ORDERS);
                            return;
                          }
                          setState(() {});
                        },
                      );
                    }
                    TradeDetail trade = snapshot.data![index - 2];
                    return GestureDetector(
                      onTap: () {
                        // 去详情
                        Get.toNamed(Routes.ORDER_DETAIL, arguments: {
                          'id': trade.id,
                        });
                      },
                      child: _tradeCCell(trade),
                    );
                  });
            }));
  }

  Future<List<TradeDetail>> _tradeListEvent() async {
    List<TradeDetail> dl =
        await Api.requestCtcTradeList(HomeController.to.remoatTradeType);
    return dl;
  }

  Widget _tradeCCell(TradeDetail trade) {
    String createTime = trade.CreatedAt ?? "";
    if (createTime.isNotEmpty) {
      DateTime ct = DateTime.tryParse(createTime) ?? DateTime.now();
      createTime =
          "${ct.year}.${ct.month}.${ct.day} ${ct.hour}:${ct.minute}:${ct.second}";
    }
    final bool isBuyer = trade.type == 1;
    return Container(
      width: Get.width - 32,
      height: 78,
      color: Config.kTheme!.bg1,
      padding: const EdgeInsets.only(bottom: 20, right: 15),
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Config.kTheme!.text1.withOpacity(0.2), width: 0.7)),
            child: Text(
              "₹",
              style: TextStyle(
                  color: Config.kTheme!.text1,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "RSO ",
                    style: TextStyle(
                        color: Config.kTheme!.text1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomImage(
                    isBuyer ? Assets.homeBuy : Assets.homeSell,
                    width: 20.w,
                  )
                ],
              ),
              5.w.vb,
              Text(
                createTime,
                style: TextStyle(color: Config.kTheme!.text2, fontSize: 12.sp),
              )
            ],
          )),
          Text(
            isBuyer ? "+ ${trade.amount}" : "- ${trade.amount}",
            style: TextStyle(
                color: Config.kTheme!.text1,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  _userInfo() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await UserService.to.reFetchUser();
  }

  _config() async {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }

  _channelConfig() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    ChannelAndroidIos.configureFlutterEngine().then((value) {
      if (value.contains("orderSn")) {
        ApplicationController.to.postUserCoinPay(value);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    // 当应用从后台进入前台时
    _channelConfig();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        // backgroundColor: Colors.amberAccent,
        onRefresh: () async {
          controller.fetchData();
        },
        child: HomePage());
  }
}
