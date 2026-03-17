import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';

class HomeTradeMenu extends StatefulWidget {
  const HomeTradeMenu({required this.click});
  final ValueChanged<int> click;
  @override
  State<StatefulWidget> createState() {
    return HomeTradeMenuState();
  }
}

class HomeTradeMenuState extends State<HomeTradeMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 107.w,
      padding: const EdgeInsets.only(top: 10),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Recent Trades".tr,
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: Config.kTheme!.text1),
                ),
              ),
              IconButton(
                  onPressed: () {
                    widget.click(0);
                  },
                  icon: CustomImage(
                    Assets.remoatTrade,
                    color: Config.kTheme!.text1,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.click(1);
                  setState(() {
                    HomeController.to.remoatTradeType = 0;
                  });
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Container(
                      height: 30.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                          border: HomeController.to.remoatTradeType == 0
                              ? Border.all(
                                  color: Config.kTheme!.text1.withOpacity(0.5),
                                  width: 0.8)
                              : null,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "All Trades".tr,
                        style: TextStyle(
                            color: HomeController.to.remoatTradeType == 0
                                ? Config.kTheme!.text1
                                : Config.kTheme!.text2,
                            fontSize: 13.sp),
                      ),
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    widget.click(1);
                    setState(() {
                      HomeController.to.remoatTradeType = 1;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Container(
                        height: 30.w,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        decoration: BoxDecoration(
                            border: HomeController.to.remoatTradeType == 1
                                ? Border.all(
                                    color:
                                        Config.kTheme!.text1.withOpacity(0.5),
                                    width: 0.8)
                                : null,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "卖出".tr,
                          style: TextStyle(
                              color: HomeController.to.remoatTradeType == 1
                                  ? Config.kTheme!.text1
                                  : Config.kTheme!.text2,
                              fontSize: 13.sp),
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    widget.click(1);
                    setState(() {
                      HomeController.to.remoatTradeType = 2;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Container(
                      height: 30.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                          border: HomeController.to.remoatTradeType == 2
                              ? Border.all(
                                  color: Config.kTheme!.text1.withOpacity(0.5),
                                  width: 0.8)
                              : null,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "买入".tr,
                        style: TextStyle(
                            color: HomeController.to.remoatTradeType == 2
                                ? Config.kTheme!.text1
                                : Config.kTheme!.text2,
                            fontSize: 13.sp),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
