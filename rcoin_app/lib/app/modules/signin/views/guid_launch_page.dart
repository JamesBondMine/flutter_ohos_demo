import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/generated/assets.dart';

// ignore: must_be_immutable
class GuidLaunchPage extends StatefulWidget {
  GuidLaunchPage({Key? key, required this.disappear}) : super(key: key);
  VoidCallback disappear;
  @override
  State<StatefulWidget> createState() {
    return GuidLaunchPageStates();
  }
}

class GuidLaunchPageStates extends State<GuidLaunchPage> {
  // late TabController _tabController;

  PageController pageController = PageController(keepPage: true);

  bool endView = false;

  bool guidLaunch = false;

  final box = Hive.box('app');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    guidLaunch = true;
    setState(() {});

    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!guidLaunch || (box.get("guid") != null && box.get("guid") == true)) {
      return const SizedBox();
    }
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    if (endView) {
      return _endView();
    }
    return PageView.builder(
      physics: const PageScrollPhysics(),
      controller: pageController,
      itemCount: 3,
      itemBuilder: buildPage,
      onPageChanged: (v) {
        // _tabController.animateTo(v);
      },
    );
  }

  Widget buildPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return GuidOneView(
          index: 0,
          click: () {},
          title1: "simple".tr,
          title2: "One key exchange".tr,
          title3: "The world of digital assets comes and goes freely".tr,
        );
      case 1:
        return GuidOneView(
          index: 1,
          click: () {},
          title1: 'security'.tr,
          title2: 'Multiple protections'.tr,
          title3: 'We will protect your digital assets'.tr,
        );
      case 2:
        return GuidOneView(
          index: 2,
          click: () {
            setState(() {
              endView = true;
            });
          },
          title1: 'save worry'.tr,
          title2: '24-hour customer service'.tr,
          title3: 'Everything for you to trade smoothly'.tr,
        );
      default:
        return GuidOneView(
          index: 0,
          click: () {},
          title1: '',
          title2: '',
          title3: '',
        );
    }
  }

  Widget _endView() {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                Config.kTheme!.bgMain,
                Config.kTheme!.bgMain,
                Config.kTheme!.bgMain.withOpacity(0.85),
                Config.kTheme!.bgMain.withOpacity(0.6),
                Config.kTheme!.bgMain.withOpacity(0.85),
                Config.kTheme!.bgMain,
                Config.kTheme!.bgMain,
                Config.kTheme!.bgMain,
              ])),
        )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Config.kTheme!.bg1,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              padding: const EdgeInsets.only(top: 25, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const CustomImage(Assets.homeotice),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Know risks and prevent fraud".tr,
                          style: TextStyle(
                              color: const Color(0xff9b9b9b), fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Reminder again: Dear user, we will not call or send text messages to urge you to release your funds before you have received the payment. Please refer to the actual receipt on the bank app for order processing."
                          .tr,
                      style: TextStyle(color: Config.kTheme!.text1),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // widget.disappear();
                      setState(() {
                        guidLaunch = false;
                      });
                      box.put("guid", true);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 5),
                      width: Get.width,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Config.kTheme!.bgbtn,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "I got it!".tr,
                        style: TextStyle(
                            color: Config.kTheme!.text1,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "4/4",
                        style: TextStyle(
                            color: const Color(0xff9b9b9b), fontSize: 13.sp),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
}

// ignore: must_be_immutable
class GuidOneView extends StatelessWidget {
  GuidOneView(
      {Key? key,
      required this.index,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.click})
      : super(key: key);

  int index;
  VoidCallback click;

  String title1 = "";
  String title2 = "";
  String title3 = "";

  List<String> logoList = [
    Assets.guidlogo1,
    Assets.guidlogo2,
    Assets.guidlogo3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        // color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Assets.loginGuidBg), // 背景图片路径
          // invertColors: GetPlatform.isDesktop,
          colorFilter:
              ColorFilter.mode(Config.kTheme!.bgMain, BlendMode.screen),
          invertColors: false,
          fit: BoxFit.cover, // 背景图片填充方式
        ),
      ),
      child: _childView(),
    ));
  }

  Widget _childView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, bottom: 40),
          child: Image.asset(logoList[index], width: Get.width),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            title1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Config.kTheme!.text1,
                fontSize: 32,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Text(
            title2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Config.kTheme!.text2.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          title3,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Config.kTheme!.text2.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        index == 2
            ? MaterialButton(
                onPressed: () {
                  click();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 200,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Config.kTheme!.bgbtn,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("start immediately".tr),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 60),
                width: 200,
                height: 52,
                alignment: Alignment.center,
                child: _pageLineView(),
              )
      ],
    );
  }

  Widget _pageLineView() {
    List<Widget> lines = [];
    if (index == 0) {
      lines.add(Container(
        width: 21,
        height: 5,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: Config.kTheme!.bgCard,
            borderRadius: BorderRadius.circular(2.5)),
      ));
    }
    lines.add(Container(
      width: 11,
      height: 5,
      decoration: BoxDecoration(
          color: Config.kTheme!.bgCard.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2.5)),
    ));
    if (index == 0) {
      lines.add(const SizedBox(width: 4));
    }
    if (index == 1) {
      lines.add(Container(
        width: 21,
        height: 5,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: Config.kTheme!.bgCard,
            borderRadius: BorderRadius.circular(2.5)),
      ));
    }
    lines.add(Container(
      width: 11,
      height: 5,
      decoration: BoxDecoration(
          color: Config.kTheme!.bgCard.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2.5)),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lines,
    );
  }
}
