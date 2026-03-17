import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/wechat_picker.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../controllers/appeal_controller.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AppealView extends GetView<AppealController> {
  const AppealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Config.kTheme!.bgMain,
      appBar: _headerView(context),
      body: Container(
        color: Config.kTheme!.bgMain,
        // padding: const EdgeInsets.all(16).r,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            _bodyView(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 20, bottom: 60),
              child: AppButton(
                onPressed: () {
                  _feedUploadEvent();
                },
                width: Get.width - 24,
                height: 52.w,
                radius: 8,
                title: '提交'.tr,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Config.kTheme!.bg1, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.w,
              ),
              Row(
                children: [
                  const Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '申诉原因'.tr,
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff042B32)),
                  ),
                ],
              ),
              10.w.vb,
              Container(
                height: 52,
                width: Get.width,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(color: Color(0xff9b9b9b), width: 0.8)),
                child: TextField(
                  controller: controller.reasonController,
                  onTap: () {
                    _picerShow();
                  },
                  readOnly: true,
                  style:
                      TextStyle(fontSize: 17.sp, color: Config.kTheme!.text1),
                  decoration: outlineInputDecoration.copyWith(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 10, horizontal: 10),
                      fillColor: Colors.transparent,
                      hintText: '请选择申诉原因'.tr,
                      hintStyle:
                          TextStyle(color: Config.kTheme!.text2, fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(0xff010101).withOpacity(.5)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(0xff010101).withOpacity(.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Color(0xff010101).withOpacity(.5)),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 18.0),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Config.kTheme!.text2,
                        ),
                      )),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.w,
              ),
              Row(
                children: [
                  const Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '申诉内容'.tr,
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff042B32)),
                  ),
                ],
              ),
              10.w.vb,
              Container(
                height: 200,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xff9b9b9b), width: 0.8)),
                child: Column(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller.contentController,
                      minLines: 13,
                      style: TextStyle(
                          fontSize: 17.sp, color: Config.kTheme!.text1),
                      maxLines: null,
                      onChanged: (value) {
                        if (controller.contentController.text.length >= 300) {
                          controller.contentController.text = controller
                              .contentController.text
                              .substring(0, 300);
                        }
                        controller.updateAppealContentNumRefresh();
                      },
                      decoration: outlineInputDecoration.copyWith(
                        hintText: '输入申诉内容'.tr,
                        hintStyle: TextStyle(
                            color: Config.kTheme!.text2, fontSize: 12),
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    )),
                    GetBuilder<AppealController>(
                        id: controller.appealContentNumRefreshId,
                        builder: (v) {
                          return SizedBox(
                            width: Get.width,
                            height: 44,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${controller.contentController.text.length}/300    ",
                                  style: TextStyle(color: Color(0xff9b9b9b)),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.w.vb,
              Row(
                children: [
                  const Text(
                    "*",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '添加交易截图'.tr,
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff042B32)),
                  ),
                ],
              ),
              10.w.vb,
              _selectImageView(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.w.vb,
              Text(
                '添加交易录屏 (可选)'.tr,
                style: TextStyle(fontSize: 16.sp, color: Color(0xff042B32)),
              ),
              10.w.vb,
              _selectsVideosView()
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Obx(() => Wrap(
              //         spacing: 5.w,
              //         runSpacing: 5.w,
              //         children: [
              //           ...List.generate(
              //               controller.videos.length,
              //               (index) => PickedVideo(
              //                     image: controller.videos[index].$2,
              //                     onDelete: () {
              //                       controller.videos.removeAt(index);
              //                     },
              //                   )),
              //           Visibility(
              //             visible:
              //                 controller.videos.length < controller.maxVideos,
              //             child: AddFile(
              //               onPicked: (AssetEntity assetEntity) async {
              //                 final res = await NetRepository.uploadClient
              //                     .upload((await assetEntity.file)!);
              //                 if (res.code != 0) {
              //                   Toast.showError(res.msg);
              //                   return;
              //                 }
              //                 final url = (res.data as UploadResponse).url!;
              //                 final image = MemoryImage(
              //                     (await assetEntity.thumbnailData)!);
              //                 controller.videos.add((url, image));
              //               },
              //               requestType: RequestType.video,
              //             ),
              //           ),
              //         ],
              //       )),
              // )
            ],
          ),
          70.w.vb,
        ],
      ),
    );
  }

  _picerShow() {
    Picker picker = Picker(
        backgroundColor: Config.kTheme!.bg1,
        headerColor: Color(0xff131313),
        adapter: PickerDataAdapter<String>(
            pickerData:
                controller.reasons.map((element) => element.content).toList()),
        changeToFirst: true,
        cancelText: '取消'.tr,
        confirmText: '确定'.tr,
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
        cancelTextStyle: const TextStyle(color: Color(0xff9b9b9b)),
        confirmTextStyle: TextStyle(color: Config.kTheme!.text2),
        headerDecoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Config.kTheme!.bg1,
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 56, 56, 56), Color(0xff131313)]),
            border: Border.all(color: Color(0xff131313))),
        containerColor: Color(0xff131313),
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          controller.reasonController.text =
              controller.reasons[value.first].content!;
          controller.reasonId = controller.reasons[value.first].id!;
        });
    picker.show(_scaffoldKey.currentState!);
  }

  _feedUploadEvent() async {
    try {
      if (AppealController.to.videsList.isNotEmpty) {
        AppealController.to.videsList.clear();
      }
      if (AppealController.to.pics.isNotEmpty) {
        AppealController.to.pics.clear();
      }
      if (AppealController.to.feedImgs.isNotEmpty) {
        Toast.showLoading(message: 'uploading'.tr);
        //  上传图片
        for (var i = 0; i < AppealController.to.feedImgs.length; i++) {
          final res = await NetRepository.uploadClient
              .upload(File(AppealController.to.feedImgs[i].path));
          if (res.code != 0) {
            Toast.showError(res.msg);
            break;
          }
          final url = (res.data as UploadResponse).url!;
          AppealController.to.pics.add(url);
        }
      }
      if (AppealController.to.feedVideos.isNotEmpty) {
        Toast.showLoading(message: 'uploading'.tr);
        // 上传视频
        for (var i = 0; i < AppealController.to.feedVideos.length; i++) {
          File fe = File(AppealController.to.feedVideos[i].path);
          final res = await NetRepository.uploadClient.upload(fe);
          if (res.code != 0) {
            Toast.showError(res.msg);
            break;
          }
          final url = (res.data as UploadResponse).url!;
          AppealController.to.videsList.add(url);
        }
      }
      Toast.hideLoading();
      bool res = await AppealController.to.postAppeal();
      if (res == true) {
        // 返回上一页
        Get.back();
      }
    } catch (e) {
      Toast.showError('error'.tr);
      Toast.hideLoading();
    }
  }

  Widget _selectsVideosView() {
    return GetBuilder<AppealController>(
        id: AppealController.to.appealImagesRefreshId,
        builder: (value) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 5.w,
              runSpacing: 5.w,
              children: [
                ...List.generate(
                    AppealController.to.feedVideos.length,
                    (index) => PickedVideo(
                          image: AppealController.to.videoCovers[index],
                          onDelete: () {
                            AppealController.to.videoCovers.removeAt(index);
                            AppealController.to.feedVideos.removeAt(index);
                            AppealController.to.updateAppealImagesRefresh();
                          },
                        )),
                Visibility(
                  visible: AppealController.to.feedVideos.length <
                      controller.maxVideos,
                  child: AddFile(
                    onPicked: (AssetEntity assetEntity) async {
                      final item = await assetEntity.file;
                      assetEntity.thumbnailData;
                      if (item is File) {
                        AppealController.to.feedVideos.add(item);
                        final image =
                            MemoryImage((await assetEntity.thumbnailData)!);
                        AppealController.to.videoCovers.add(image);
                        AppealController.to.updateAppealImagesRefresh();
                      }
                    },
                    requestType: RequestType.video,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _selectImageView() {
    return GetBuilder<AppealController>(
        id: AppealController.to.appealImagesRefreshId,
        builder: (value) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 5.w,
              runSpacing: 5.w,
              children: [
                ...List.generate(
                    AppealController.to.feedImgs.length,
                    (index) => PickedAsset(
                          path: AppealController.to.feedImgs[index].path,
                          onDelete: () {
                            AppealController.to.feedImgs.removeAt(index);
                            AppealController.to.updateAppealImagesRefresh();
                          },
                        )),
                Visibility(
                  visible:
                      AppealController.to.feedImgs.length < controller.maxPics,
                  child: AddFile(
                    onPicked: (AssetEntity assetEntity) async {
                      final item = await assetEntity.file;
                      if (item is File) {
                        AppealController.to.feedImgs.add(item);
                        AppealController.to.updateAppealImagesRefresh();
                      }
                    },
                    requestType: RequestType.image,
                  ),
                ),
              ],
            ),
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
                child: Icon(Icons.arrow_back_ios,
                    size: 16, color: Config.kTheme!.text1),
              ),
            ),
            Text(
              '申诉'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Config.kTheme!.text1),
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

class PickedVideo extends StatelessWidget {
  const PickedVideo({super.key, required this.image, this.onDelete});

  final ImageProvider image;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4).r,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5, top: 5),
            child: Image(
              image: image,
              width: 102.w,
              height: 102.w,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned.fill(
              child: Center(
            child: Icon(
              Icons.play_circle,
              color: Colors.white,
            ),
          )),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.red,
                    ),
                    child: const Text(
                      "一",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )))
        ],
      ),
    );
  }
}

class PickedAsset extends StatelessWidget {
  const PickedAsset({super.key, this.path, this.image, this.onDelete});

  final String? path;
  final Image? image;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4).r,
      child: Stack(
        children: [
          image ??
              Padding(
                padding: EdgeInsets.only(right: 5, top: 5),
                child: CustomImage(
                  path!,
                  width: 97.w,
                  height: 97.w,
                  fit: BoxFit.cover,
                ),
              ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.red,
                  ),
                  child: const Text(
                    "一",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class AddFile extends StatelessWidget {
  const AddFile({
    super.key,
    required this.onPicked,
    required this.requestType,
  });

  final Function(AssetEntity entities) onPicked;
  final RequestType requestType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        List<AssetEntity>? entities = await pickAssetEntity(
          context: context,
          maxAssetsCount: 1,
          requestType: requestType,
        );
        if (entities?.isNotEmpty ?? false) {
          onPicked(entities!.first);
        }
      },
      child: Container(
        width: 102.w,
        height: 102.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4).r,
            // color: Colors.white,
            border: Border.all(width: 0.8, color: Color(0xff6d6d6d))),
        alignment: Alignment.center,
        child: Icon(
          Icons.add,
          color: Color(0xff9b9b9b),
          size: 30,
        ),
      ),
    );
  }
}
