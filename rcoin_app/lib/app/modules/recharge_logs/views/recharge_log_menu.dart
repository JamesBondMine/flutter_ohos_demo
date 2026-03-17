import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/controllers/home_controller.dart';
import 'package:otc_app/app/modules/recharge_logs/controllers/recharge_logs_controller.dart';

class RechargeLogMenu extends StatefulWidget {
  const RechargeLogMenu({required this.click});

  final ValueChanged<int> click;
  @override
  State<StatefulWidget> createState() {
    return RechargeLogMenuState();
  }
}

class RechargeLogMenuState extends State<RechargeLogMenu> {
  List<String> itemList = ["全部".tr, "进行中".tr, "失败".tr, "已完成".tr];

  List<Widget> children = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  Future<List<Widget>> _childrenView() async {
    children = [];
    for (var i = 0; i < itemList.length; i++) {
      Widget item = GestureDetector(
        onTap: () {
          widget.click(i);
          setState(() {
            RechargeLogsController.to.controllerIndex = i;
          });
        },
        child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Container(
              height: 26.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: RechargeLogsController.to.controllerIndex == i
                          ? Config.kTheme!.text2.withOpacity(0.5)
                          : Color.fromARGB(255, 177, 177, 177),
                      width: 0.8),
                  borderRadius: BorderRadius.circular(13)),
              child: Text(
                itemList[i],
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: RechargeLogsController.to.controllerIndex == i
                        ? Config.kTheme!.text1
                        : Config.kTheme!.text2,
                    fontSize: 13.sp),
              ),
            )),
      );
      children.add(item);
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _childrenView(),
        builder: ((context, snapshot) {
          return Container(
            width: Get.width,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(children: children),
          );
        }));
  }
}
