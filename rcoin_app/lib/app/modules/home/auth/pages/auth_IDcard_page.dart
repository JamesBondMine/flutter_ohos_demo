import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/home/auth/pages/auth_video_page.dart';
import 'package:otc_app/app/modules/identityVerification/controllers/identity_verification_controller.dart';
import 'package:otc_app/app/modules/identityVerification/models/auth_model.dart';
import 'package:otc_app/app/widgets/button.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/wechat_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AuthIDCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthIDCardPageState();
  }
}

class AuthIDCardPageState extends State<AuthIDCardPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  String frontImage = "";
  String backImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerView(context),
      backgroundColor: Config.kTheme!.bgpage,
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: _requestAuthState(),
                  builder: (c, s) {
                    return _childrenView(s.hasData ? s.data : null);
                  })),
        ],
      ),
    );
  }

  Future<AuthModel?> _requestAuthState() async {
    AuthModel? res =
        await IdentityVerificationController.to.authApplyStateInfo();
    return res;
  }

  Widget _childrenView(AuthModel? data) {
    bool canEdit = true;
    if (data != null && data.id != 0) {
      // _nameController.text = data.realName;
      // _idController.text = data.cardNum;
    }
    return ListView(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 0, bottom: 50),
      children: [
        _stepView(),
        data == null
            ? Container()
            : Container(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 20, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Config.kTheme!.bgCard),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload ID card photo'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xffffffff),
                        )),
                    Text('ID card is used to bind: transaction info'.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff5d4c30),
                        )),
                    Text("* ${'请手持身份证证件和头部进行实名认证'.tr}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red,
                        )),
                    SizedBox(
                      height: 10.w,
                    ),
                    _idcardView(1, data),
                    SizedBox(
                      height: 10.w,
                    ),
                    _idcardView(2, data),
                    SizedBox(
                      height: 10.w,
                    ),
                    _idcardfView(),
                  ],
                ),
              ),
        SizedBox(
          height: 10.w,
        ),
        Container(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 20, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Config.kTheme!.bgCard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Identity information'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xffffffff),
                  )),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Real name'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xffffffff),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 44,
                    width: Get.width - 160,
                    child: TextField(
                      controller: _nameController,
                      enabled: canEdit,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
                      decoration: outlineInputDecoration.copyWith(
                          hintText: 'Enter a real name'.tr,
                          focusColor: Colors.white,
                          fillColor: Colors.black.withOpacity(0)),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ID Number'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xffffffff),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 44,
                    width: Get.width - 160,
                    child: TextField(
                      controller: _idController,
                      enabled: canEdit,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
                      decoration: outlineInputDecoration.copyWith(
                          hintText: 'Enter your ID number'.tr,
                          focusColor: Colors.white,
                          fillColor: Colors.black.withOpacity(0)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        _footerView(context, data)
      ],
    );
  }

  Widget _idcardfView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //authIDf
        _cardFooterCard(true, 'standard'.tr),
        _cardFooterCard(false, 'defect'.tr),
        _cardFooterCard(false, 'vague'.tr),
        _cardFooterCard(false, 'Strong light'.tr)
      ],
    );
  }

  Widget _cardFooterCard(bool right, String title) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Column(
        children: [
          CustomImage(
            Assets.authIDf,
            width: (Get.width - 32.w) / 4 - 12,
          ),
          SizedBox(
            height: 5.w,
          ),
          Row(
            children: [
              CustomImage(
                right ? Assets.authMedias : Assets.authMediaw,
                width: 13,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xffffffff),
                  ))
            ],
          )
        ],
      ),
    );
  }

//选择文件
  _selectMedia(bool front) async {
    final entities = await pickAssetEntity(
      context: context,
      maxAssetsCount: 1,
      requestType: RequestType.common,
    );

    if (entities != null && entities.isNotEmpty) {
      AssetEntity item = entities.first;
      File? file = await item.file;
      if (file != null) {
        if (front) {
          frontImage = file.path;
          IdentityVerificationController.to.pic1 = frontImage;
          IdentityVerificationController.to.updateMediaPhotosRefresh();
          return;
        }
        backImage = file.path;
        IdentityVerificationController.to.pic2 = backImage;
        IdentityVerificationController.to.updateMediaPhotosRefresh();
      }
    }
  }

  Widget _localImage(int index) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
                width: Get.width - 32,
                height: 175.w,
                alignment: Alignment.center,
                child: Container(
                  width: 130.w,
                  height: 80.w, //
                  child: CustomImage(
                    index == 1 ? Assets.authID1 : Assets.authID2,
                    width: 36.w,
                    height: 36.w,
                  ),
                ))),
        Positioned.fill(
            child: Container(
                width: Get.width - 32,
                height: 175.w,
                alignment: Alignment.center,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  child: CustomImage(
                    Assets.authCrame,
                    width: 36.w,
                    height: 36.w,
                  ),
                ))),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(index == 1 ? '人像'.tr : '反面'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xffaeaeae),
                    ))
              ],
            ))
      ],
    );
  }

  Widget _idcardView(int index, AuthModel data) {
    return GestureDetector(
        onTap: () {
          // 审核中和通过不可点击
          if (data.state == 1 || (data.state == 0 && data.id != 0)) {
            // return;
          }
          // 选相册
          _selectMedia(index == 1);
        },
        child: GetBuilder<IdentityVerificationController>(
          id: IdentityVerificationController.to.mediaPhotosRefreshId,
          builder: ((controller) {
            Widget child = _localImage(index);
            if (index == 1) {
              // 网络
              // if (data.cardImg1.isNotEmpty) {
              //   child = Container(
              //       width: Get.width - 32,
              //       height: 175.w,
              //       alignment: Alignment.center,
              //       child: Image.network(data.cardImg1));
              // }
              // 本地
              if (frontImage.isNotEmpty) {
                child = Container(
                    width: Get.width - 32,
                    height: 175.w,
                    alignment: Alignment.center,
                    child: Image.file(File(frontImage)));
              }
            } else {
              // 网络
              // if (data.cardImg2.isNotEmpty) {
              //   child = Container(
              //       width: Get.width - 32,
              //       height: 175.w,
              //       alignment: Alignment.center,
              //       child: Image.network(data.cardImg2));
              // }
              // 本地
              if (backImage.isNotEmpty) {
                child = Container(
                    width: Get.width - 32,
                    height: 175.w,
                    alignment: Alignment.center,
                    child: Image.file(File(backImage)));
              }
            }
            return Container(
              width: Get.width - 32,
              height: 175.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: Colors.white.withOpacity(0.08)),
              alignment: Alignment.center,
              child: child,
            );
          }),
        ));
  }

  Widget _stepView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                CustomImage(
                  Assets.authStep1,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('auth'.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff5d4c30),
                    ))
              ],
            ),
          ),
          Container(
            width: 80.w,
            height: 2.w,
            color: Color(0xfff4e0bd),
          ),
          Container(
            child: Row(
              children: [
                CustomImage(
                  Assets.authStep2,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('video auth'.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff5d4c30),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _footerView(BuildContext context, AuthModel? data) {
    return Container(
      margin: EdgeInsets.only(top: 30.w),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20.w),
      child: AppButton(
        width: MediaQuery.of(context).size.width - 40.w,
        height: 52.w,
        title: '下一步'.tr,
        titleStyle: const TextStyle(color: Color(0xff5d4c30)),
        backgroundColor: const Color(0xfff4e0bd),
        onPressed: () {
          // if (data != null) {
          // if (data.id == 0) {
          if (frontImage.isEmpty ||
              backImage.isEmpty ||
              _nameController.text.isEmpty ||
              _idController.text.isEmpty) {
            Toast.showInfo("请先完善信息".tr);
            return;
          }
          // }
          Map<String, dynamic> authInfo = {
            "cardImg1": frontImage,
            "cardImg2": backImage,
            "realName": _nameController.text,
            "cardNum": _idController.text
          };
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AuthVideoPage(authInfo: authInfo)),
          );
          // }
        },
        radius: 8.w,
      ),
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Text(
              '实名认证'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Color(0xffffffff),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 14.w), width: 48.w, height: 48.w)
          ],
        ),
      ),
    );
  }
}
