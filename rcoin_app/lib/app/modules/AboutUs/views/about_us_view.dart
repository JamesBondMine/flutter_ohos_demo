import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/about_us_controller.dart';
import 'package:html/parser.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  width: Get.width,
                  height: 300 + MediaQuery.of(context).padding.top,
                  child: CustomImage(Assets.aboutHeader),
                )),
            Positioned.fill(
                child: Column(
              children: [
                _headerView(context),
                Expanded(
                    child: _card([
                  Padding(
                      padding: EdgeInsets.only(
                          top: 40.w, bottom: 20.w, left: 16.w, right: 16.w),
                      child: SizedBox(
                        width: 90.w,
                        height: 90.w,
                        child: const CustomImage(Assets.iconIconIos),
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                    child: _bodyView(),
                  ))
                ]))
              ],
            ))
          ],
        ));
  }

  Widget _card(List<Widget> childrren) {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1,
          borderRadius: BorderRadius.circular(10).w,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Config.kTheme!.bgMain,
                Config.kTheme!.bg1,
                Config.kTheme!.bgbtn,
                Config.kTheme!.bgbtn
              ]),
          border: Border.all(
              color: Color(0xff6d6d6d).withOpacity(0.6), width: 0.5)),
      child: Column(children: childrren),
    );
  }

  Widget _bodyView() {
    return Container(
      // color: Colors.red,
      margin: EdgeInsets.all(10.w),
      padding: const EdgeInsets.all(10).w,
      child: controller.obx((state) {
        String htmlString = "";
        if (state != null && state.content != null) {
          var document = parse(state.content!);
          document.getElementsByTagName("p").forEach((element) {
            // print("------------------");
            // print(element.text);
            htmlString = htmlString + element.text;
            htmlString = htmlString + '\n\n';
          });
        }
        return Text(
          htmlString,
          style: TextStyle(color: Config.kTheme!.text1),
        );
        // var c = WebViewController()
        //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
        //   ..loadHtmlString(state?.content ?? '');

        // c.setBackgroundColor(Colors.transparent);

        // return WebViewWidget(
        //   controller: c,
        // );
      },
          onLoading: SpinKitFadingCircle(
            size: 25,
            color: Config.kTheme!.text1,
          )),
    );
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
              '关于我们'.tr,
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
            ),
          ],
        ),
      ),
    );
  }
}
