import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/application/controllers/application_upload_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateCenterView extends StatefulWidget {
  const UpdateCenterView({Key? key, required this.appBindInfo})
      : super(key: key);

  final AppBindInfo appBindInfo;

  @override
  State<StatefulWidget> createState() {
    return UpdateCenterViewState();
  }
}

class UpdateCenterViewState extends State<UpdateCenterView> {
  double progress = 0.0;

  int agreeUpdate = 0;

  String content = "";

  bool canPop = false;

  String apkfilePath = "";

  bool reInstall = false;

  @override
  void initState() {
    super.initState();

    content = widget.appBindInfo.updateText;

    canPop = widget.appBindInfo.isForce == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<ApplicationUploadController>(
            id: ApplicationUploadController.to.versionInfoRefreshId,
            builder: (value) {
              return Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: (agreeUpdate == 1 || agreeUpdate == 2)
                                  ? 80
                                  : 0),
                          decoration: BoxDecoration(
                              color: Config.kTheme!.bgw,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))))),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: (agreeUpdate == 1 || agreeUpdate == 2) ? 80 : 0,
                      child: Container(
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: gradientAinmationgold(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                      )),
                  Positioned.fill(child: _noticeView()),
                ],
              );
            }));
  }

  // 下载
  _apkDownload(String version) async {
    await Future.delayed(const Duration(milliseconds: 500));
    ApplicationUploadController.to
        .requestApkDownload(widget.appBindInfo.forceUrl, "$version.apk", (p) {
      progress = p;
      ApplicationUploadController.to.updateVersionRefreshEvent();
    }, (successFilePath) async {
      apkfilePath = successFilePath;
      File file = File(successFilePath);
      if (file.existsSync()) {
        // 下载完成 刷新页面
        agreeUpdate = 2;
        ApplicationUploadController.to.updateVersionRefreshEvent();
      } else {
        Toast.showError("update error");
      }
    }, () {
      Toast.showError("update fail");
    });
  }

  // 安装
  _apkInstall() async {
    await Future.delayed(const Duration(milliseconds: 500));
    ApplicationUploadController.to.updateVersionRefreshEvent();
    final res = await InstallPlugin.install(apkfilePath);
    if (res['isSuccess'] != true) {
      reInstall = true;
      ApplicationUploadController.to.updateVersionRefreshEvent();
      Toast.showError("install error");
    }
  }

  LinearGradient gradientAinmationgold() {
    return LinearGradient(
        //渐变位置
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.decal, //左下
        stops: const [
          0.0,
          1.0
        ],
        colors: [
          Config.kTheme!.bgMain.withOpacity(0.3),
          Config.kTheme!.bgw,
        ]);
  }

  Widget _noticeView() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: (agreeUpdate == 1 || agreeUpdate == 2) ? 80 : 0),
      padding: const EdgeInsets.only(bottom: 25),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
                color: const Color(0xff9b9b9b),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(agreeUpdate == 2
                            ? Assets.loginRegisterPinSuccess
                            : Assets.homeUploadRocket),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          Text(
            agreeUpdate == 1
                ? "loading..."
                : agreeUpdate == 2
                    ? "Download completed".tr
                    : "New Version",
            style: TextStyle(
                fontSize: 18.sp,
                color: Config.kTheme!.text1,
                fontWeight: FontWeight.w500),
          ),
          (agreeUpdate == 1 || agreeUpdate == 2)
              ? Container()
              : Container(
                  height: 30,
                  width: 60,
                  margin: EdgeInsets.only(top: 15.w),
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: Config.kTheme!.text2, width: 0.5)),
                  child: Text(
                    "v${widget.appBindInfo.version}",
                    style: TextStyle(fontSize: 13, color: Config.kTheme!.text1),
                  ),
                ),
          (agreeUpdate == 1 || agreeUpdate == 2)
              ? Container()
              : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        '${"Update Content".tr} :',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Config.kTheme!.text1),
                      ),
                    )
                  ],
                ),
          (agreeUpdate == 1 || agreeUpdate == 2)
              ? Container()
              : Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Text(
                    content,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15, height: 1.6, color: Config.kTheme!.text2),
                  ),
                ),
          const Spacer(),
          _lineProgressView(),
          agreeUpdate == 2
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Download completed, install now?".tr,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: Config.kTheme!.text1,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Container(),
          agreeUpdate == 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "~${'WiFi environment, only takes 30 seconds'.tr}~",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: Config.kTheme!.text2,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Container(),
          _noticeBottomView()
        ],
      ),
    );
  }

  Widget _noticeBottomView() {
    List<Widget> childList = [];
    if (canPop) {
      childList.add(
        MaterialButton(
          onPressed: () {
            // AppNavigator.pop(context);
            Get.back();
          },
          child: Container(
              height: 52.w,
              width: Get.width / 2 - 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Config.kTheme!.text1, width: 0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Text(
                "Cruel Rejection".tr,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Config.kTheme!.text2),
              )),
        ),
      );
    }
    childList.add(MaterialButton(
      onPressed: () async {
        if (agreeUpdate == 1) {
          // 下载中不能惦记
          return;
        }
        if (agreeUpdate == 2) {
          // 点击安装
          _apkInstall();
          return;
        }
        if (Platform.isAndroid) {
          agreeUpdate = 1;
          ApplicationUploadController.to.updateVersionRefreshEvent();
          _apkDownload(widget.appBindInfo.version);
        } else {
          Get.back();
          launchUrl(Uri.parse(widget.appBindInfo.forceUrl));
        }
      },
      child: Container(
        height: 52.w,
        width: Get.width / 2 - 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Config.kTheme!.bgbtn,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          agreeUpdate == 2 ? "Update Now".tr : "upgrade",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: agreeUpdate == 1
                  ? Config.kTheme!.text1.withOpacity(0.3)
                  : Config.kTheme!.text1),
        ),
      ),
    ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: childList,
    );
  }

  Widget _lineProgressView() {
    if (agreeUpdate != 1) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
      child: LinearProgressIndicator(
        backgroundColor: Config.kTheme!.bg2,
        color: Config.kTheme!.bgMain,
        borderRadius: BorderRadius.circular(2),
        value: progress,
      ),
    );
  }
}

class AppBindInfo {
  late int id = 0;
  late int isForce = 0;
  late int addtime = 0;
  late int commentStatus = 0;
  late String device = "";
  late String version = "";
  late String downUrl = "";
  late String updateText = "";

  late String forceUrl = "";
  late int forceType = 0;

  AppBindInfo();

  AppBindInfo.fromJson(Map json) {
    id = json["id"] ?? 0;
    isForce = json["is_force"] ?? 0;
    addtime = json["addtime"] ?? 0;
    commentStatus = json["comment_status"] ?? 0;
    device = json["device"] ?? "";
    version = json["version"] ?? "";
    downUrl = json["down_url"] ?? "";
    updateText = json["update_text"] ?? "";

    forceUrl = json["force_url"] ?? "";
    forceType = json["force_type"] ?? 1;
  }

  Map<String, dynamic> toJson() => {};
}
