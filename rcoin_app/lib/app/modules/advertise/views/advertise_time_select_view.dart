import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/advertise/controllers/advertise_controller.dart';

class AdvertiseTimeSelectView extends StatelessWidget {
  AdvertiseTimeSelectView({required this.timeIndex});

  ScrollController _scrollController = ScrollController();

  final ValueChanged<int> timeIndex;
  @override
  Widget build(Object context) {
    return GetBuilder<AdvertiseController>(
        id: AdvertiseController.to.adverTimeSelectRefreshId,
        builder: (value) {
          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: _bodyView(),
          );
        });
  }

  Widget _bodyView() {
    TextStyle selectStyle = TextStyle(
        fontSize: 18.sp,
        color: Config.kTheme!.text1,
        fontWeight: FontWeight.w500);
    TextStyle defaultStyle =
        TextStyle(fontSize: 16.sp, color: Config.kTheme!.text2);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            AdvertiseController.to.dateMap = AdvertiseController.to.today();
            AdvertiseController.to.timeSelectIndex = 0;
            AdvertiseController.to.updateAdverTimeSelectRefresh();
            timeIndex(AdvertiseController.to.timeSelectIndex);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text("today",
                style: AdvertiseController.to.timeSelectIndex == 0
                    ? selectStyle
                    : defaultStyle),
          ),
        ),
        GestureDetector(
          onTap: () {
            AdvertiseController.to.dateMap = AdvertiseController.to.yesterday();
            AdvertiseController.to.timeSelectIndex = 1;
            AdvertiseController.to.updateAdverTimeSelectRefresh();
            timeIndex(AdvertiseController.to.timeSelectIndex);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text("yestoday",
                style: AdvertiseController.to.timeSelectIndex == 1
                    ? selectStyle
                    : defaultStyle),
          ),
        ),
        GestureDetector(
          onTap: () {
            AdvertiseController.to.dateMap = AdvertiseController.to.weekday();
            AdvertiseController.to.timeSelectIndex = 2;
            AdvertiseController.to.updateAdverTimeSelectRefresh();
            timeIndex(AdvertiseController.to.timeSelectIndex);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text("week",
                style: AdvertiseController.to.timeSelectIndex == 2
                    ? selectStyle
                    : defaultStyle),
          ),
        ),
        GestureDetector(
          onTap: () {
            AdvertiseController.to.dateMap = AdvertiseController.to.monthday();
            AdvertiseController.to.timeSelectIndex = 3;
            AdvertiseController.to.updateAdverTimeSelectRefresh();
            timeIndex(AdvertiseController.to.timeSelectIndex);
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Text("month",
                style: AdvertiseController.to.timeSelectIndex == 3
                    ? selectStyle
                    : defaultStyle),
          ),
        ),
        GestureDetector(
          onTap: () {
            AdvertiseController.to.timeSelectIndex = 4;
            AdvertiseController.to.updateAdverTimeSelectRefresh();
            timeIndex(AdvertiseController.to.timeSelectIndex);
            _scrollToBottomImmediately();
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                _dateTimeLastView(selectStyle, defaultStyle),
                Icon(
                  Icons.arrow_drop_down,
                  color: AdvertiseController.to.timeSelectIndex == 4
                      ? Config.kTheme!.text1
                      : Config.kTheme!.text2,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _scrollToBottomImmediately() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  Widget _dateTimeLastView(TextStyle selectStyle, TextStyle defaultStyle) {
    TextStyle selectStyle1 = TextStyle(
        fontSize: 15.sp,
        color: Config.kTheme!.text1,
        fontWeight: FontWeight.w500);

    String title = "customize".tr;
    if (AdvertiseController.to.timeSelectIndex == 4) {
      selectStyle = selectStyle1;
      DateTime ts = AdvertiseController.to.dateMap["start"] ?? DateTime.now();
      DateTime te = AdvertiseController.to.dateMap["end"] ?? DateTime.now();
      title =
          "${ts.year}-${ts.month}-${ts.day}~${te.year}-${te.month}-${te.day}";
    }
    return Text(title,
        style: AdvertiseController.to.timeSelectIndex == 4
            ? selectStyle
            : defaultStyle);
  }
}

class TimePickerSelectView extends StatefulWidget {
  TimePickerSelectView({super.key, required this.select});
  final ValueChanged<Map<String, DateTime>> select;

  @override
  State<TimePickerSelectView> createState() => _TimePickerSelectViewState();
}

class _TimePickerSelectViewState extends State<TimePickerSelectView> {
  // late final Set<PaymentType> paymentTypes;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  bool isFromTime = true;

  Map<String, DateTime> dateMap = {};

  @override
  void initState() {
    // paymentTypes = widget.paymentTypes;
    super.initState();
    dateMap = {"start": startTime, "end": endTime};
  }

  @override
  Widget build(BuildContext context) {
    return _childView();
  }

  Widget _dayaPickerView() {
    return SizedBox(
      width: Get.width,
      height: 100,
      child: CupertinoTheme(
          data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      TextStyle(fontSize: 18.sp, color: Config.kTheme!.text1))),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime) {
              setState(() {
                if (isFromTime) {
                  startTime = dateTime;
                } else {
                  endTime = dateTime;
                }
              });
            },
          )),
    );
  }

  Widget _childView() {
    return UnconstrainedBox(
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 350,
            decoration: BoxDecoration(
                color: Config.kTheme!.bgw,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // bottom: 0,
            child: Container(
              width: Get.width,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Config.kTheme!.bgMain, Config.kTheme!.bgw])),
              // child: const CustomImage(
              //   Assets.alertHead,
              // ),
            ),
          ),
          Positioned.fill(
              child: Column(
            children: [
              _pickerHeaderView(),
              Expanded(child: _dayaPickerView()),
              const SizedBox(
                height: 30,
              )
            ],
          )),
          Positioned(
              right: 0,
              top: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "取消".tr,
                        style: TextStyle(color: Config.kTheme!.text1),
                      )),
                  // Spacer(),
                  TextButton(
                      onPressed: () {
                        dateMap = {"start": startTime, "end": endTime};
                        widget.select(dateMap);
                        Get.back();
                      },
                      child: Text(
                        "确定".tr,
                        style: TextStyle(color: Config.kTheme!.text1),
                      ))
                ],
              )),
        ],
      ),
    );
  }

  Widget _pickerHeaderView() {
    return Container(
      margin: EdgeInsets.only(top: 60.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      width: Get.width,
      height: 52.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFromTime = true;
              });
            },
            child: Container(
              width: (Get.width - 100) / 2,
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                      bottom: BorderSide(
                          color: isFromTime
                              ? Config.kTheme!.text1
                              : Config.kTheme!.text2,
                          width: 2))),
              child: Text(
                "${startTime.year}-${startTime.month}-${startTime.day}",
                style: TextStyle(
                    color: isFromTime
                        ? Config.kTheme!.text1
                        : Config.kTheme!.text2,
                    fontSize: 18.sp),
              ),
            ),
          ),
          Container(
            // width: Get.width / 3,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            height: 52,
            child: Text(
              "to".tr,
              style: TextStyle(color: const Color(0xff6d6d6d), fontSize: 18.sp),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFromTime = false;
              });
            },
            child: Container(
              width: (Get.width - 100) / 2,
              alignment: Alignment.center,
              height: 52,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                      bottom: BorderSide(
                          color: !isFromTime
                              ? Config.kTheme!.text1
                              : Config.kTheme!.text2,
                          width: 2))),
              child: Text(
                "${endTime.year}-${endTime.month}-${endTime.day}",
                style: TextStyle(
                    color: !isFromTime
                        ? Config.kTheme!.text1
                        : Config.kTheme!.text2,
                    fontSize: 18.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
