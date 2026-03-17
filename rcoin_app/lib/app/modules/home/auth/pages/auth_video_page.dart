import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/auth/pages/auth_result_page.dart';
import 'package:otc_app/app/modules/identityVerification/controllers/identity_verification_controller.dart';
import 'package:otc_app/app/modules/mine/controllers/mine_controller.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class AuthVideoPage extends StatefulWidget {
  const AuthVideoPage({Key? key, required this.authInfo}) : super(key: key);
  final Map<String, dynamic> authInfo;

  @override
  State<StatefulWidget> createState() {
    return AuthVideoPageState();
  }
}

class AuthVideoPageState extends State<AuthVideoPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;

  List<CameraDescription> _cameras = <CameraDescription>[];

  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  bool showVideoWindow = false;

  int _pointers = 0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cameraConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerView(context),
      backgroundColor: const Color(0xff232322),
      body: Stack(
        children: [
          Positioned.fill(
            child: showVideoWindow ? _cameraPreviewWidget() : Container(),
          ),
          Positioned.fill(
            child: !showVideoWindow
                ? Container()
                : Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: (300) / 2,
                        ),
                        top: BorderSide(
                          color: Colors.black,
                          width: (300) / 2,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 16,
                        ),
                        right: BorderSide(
                          color: Colors.black,
                          width: 16,
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned.fill(
              child: Column(
            children: [Expanded(child: _childrenView()), _footerView(context)],
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _cameraConfig() async {
    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      Toast.showInfo("${e.description}");
    }
  }

  Widget _childrenView() {
    return ListView(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0, bottom: 0),
      children: [
        _stepView(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('authentication'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xffffffff),
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('980'.tr,
                style: TextStyle(
                  fontSize: 36.sp,
                  color: const Color(0xfff4e0bd),
                ))
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        _idcardView(1),
        SizedBox(
          height: 10.w,
        ),
        _idcardfView(),
        SizedBox(
          height: 50.w,
        ),
      ],
    );
  }

  Widget _idcardfView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //authIDf
        _cardFooterCard(Assets.authMedia1, 'light'.tr),
        _cardFooterCard(Assets.authMedia2, 'face'.tr),
        _cardFooterCard(Assets.authMedia3, 'No glasses'.tr),
        _cardFooterCard(Assets.authMedia4, 'No hat'.tr)
      ],
    );
  }

  Widget _cardFooterCard(String img, String title) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          CustomImage(
            img,
            width: 40.w,
          ),
          SizedBox(
            height: 5.w,
          ),
          Row(
            children: [
              // CustomImage(
              //   img,
              //   width: 13,
              // ),
              Text(title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xffffffff),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _idcardView(int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width - 32.w,
        height: 327.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.white.withOpacity(0.08)),
        alignment: Alignment.center,
        child: showVideoWindow
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(
                    Assets.authMediav,
                    width: 80.w,
                    height: 80.w,
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "click".tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffaeaeae),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '"Start certification"'.tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "Video recording,".tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffaeaeae),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "\n",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffaeaeae),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "end after reading the numbers above".tr,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffaeaeae),
                                fontWeight: FontWeight.bold))
                      ]))
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Widget _stepView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomImage(
                Assets.authStep2,
                width: 16.w,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('auth'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff5d4c30),
                  ))
            ],
          ),
          Container(
            width: 80.w,
            height: 2.w,
            color: const Color(0xfff4e0bd),
          ),
          Row(
            children: [
              CustomImage(
                Assets.authStep1,
                width: 16.w,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('video auth'.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xff5d4c30),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Widget _footerView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20.w,
          left: 16.w,
          right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton(
            width: MediaQuery.of(context).size.width / 2 - 40.w,
            height: 52.w,
            title: 'Start certification'.tr,
            titleStyle:
                TextStyle(color: const Color(0xfff4e0bd), fontSize: 16.sp),
            backgroundColor: const Color(0xfff4e0bd).withOpacity(0),
            borderSide: BorderSide(
                color: const Color(0xfff4e0bd).withOpacity(0.7), width: 0.8),
            onPressed: () async {
              if (_cameras.isEmpty) {
                SchedulerBinding.instance.addPostFrameCallback((_) async {
                  Toast.showInfo('No camera found.');
                });
                return;
              }
              await onNewCameraSelected(_cameras[1]);
              await Future.delayed(Duration(milliseconds: 500));
              onVideoRecordButtonPressed();
            },
            radius: 8.w,
          ),
          AppButton(
            width: MediaQuery.of(context).size.width / 2 - 40.w,
            height: 52.w,
            title: 'End certification'.tr,
            titleStyle:
                TextStyle(color: const Color(0xff5d4c30), fontSize: 16.sp),
            backgroundColor: const Color(0xfff4e0bd),
            onPressed: () {
              // 录像完成  上传视频

              final CameraController? cameraController = controller;
              if (cameraController != null &&
                  cameraController.value.isInitialized &&
                  cameraController.value.isRecordingVideo) {
                onStopButtonPressed();
              }
            },
            radius: 8.w,
          )
        ],
      ),
    );
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((XFile? file) async {
      if (mounted) {
        setState(() {});
      }
      if (file != null) {
        try {
          Toast.showLoading(message: "uploading");
          // 上传  图片 + 视频
          String cardImg1 = widget.authInfo["cardImg1"];
          String cardImg2 = widget.authInfo["cardImg2"];
          String card1Url = await IdentityVerificationController.to
              .authUploadFiles(File(cardImg1));
          String card2Url = await IdentityVerificationController.to
              .authUploadFiles(File(cardImg2));
          String videoUrl = await IdentityVerificationController.to
              .authUploadFiles(File(file.path));

          Map<String, dynamic> authInfo = {
            "cardImg1": card1Url,
            "cardImg2": card2Url,
            "video": videoUrl,
            "realName": widget.authInfo["realName"],
            "cardNum": widget.authInfo["cardNum"]
          };
          Toast.hideLoading();
          // print("文件上传结果：===========================");
          // print(authInfo);
          // 提交
          await IdentityVerificationController.to.authApplyEvent(authInfo);
          MineController.to.updateUserAuthRefresh();
          // 跳转
          _pushSuccessView();
        } catch (e) {
          Toast.hideLoading();
          Toast.showError("error");
        }
      }
    });
  }

  // 跳转
  _pushSuccessView() {
    Navigator.popUntil(context, (route) => route.isFirst);
    Toast.showInfo("成功".tr);
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      Toast.showError('Error: ${e.code}\n${e.description}');
      return null;
    }
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Text(
              '实名认证'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: const Color(0xffffffff),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 14.w), width: 48.w, height: 48.w)
          ],
        ),
      ),
    );
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        Toast.showInfo(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });
    try {
      await cameraController.initialize();
      controller = cameraController;
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
      controller!.setDescription(cameraDescription);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          Toast.showInfo('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          Toast.showInfo('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          Toast.showInfo('Camera access is restricted.');
        case 'AudioAccessDenied':
          Toast.showInfo('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          Toast.showInfo('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          Toast.showInfo('Audio access is restricted.');
        default:
          Toast.showError('Error: ${e.code}\n${e.description}');
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) {
        setState(() {
          showVideoWindow = true;
        });
      }
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      Toast.showInfo('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      Toast.showError('Error: ${e.code}\n${e.description}');
      return;
    }
  }
}
