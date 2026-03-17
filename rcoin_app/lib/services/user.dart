import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/mine/controllers/mine_controller.dart';
import 'package:otc_app/common/tools/compress_file.dart';
import 'package:otc_app/network/api.dart';
import 'package:otc_app/services/pusher.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import '../common/tools/wechat_picker.dart';
import '../models.dart';
import '../network/request/update_user_info_request.dart';
import '../network/response/upload_response.dart';

const _kAppToken = 'k_app_token';
const _kUser = 'k_user';
const _kNoticeAlert = 'k_notice_alert';

enum UserType {
  normal(0),
  acceptance(1),
  merchant(2);

  final int value;

  const UserType(this.value);

  factory UserType.fromValue(int value) {
    return UserType.values
        .firstWhere((element) => element.value == value, orElse: () => normal);
  }
}

/// 用户相关的全局处理
class UserService extends GetxService {
  static UserService get to => Get.put(UserService());
  final box = Hive.box('app');

  /// 用户是否登录
  bool get isLogin => _isLogin();

  bool _isLogin() {
    return token.token.isNotEmpty &&
        token.expiresAt > (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  /// 身份鉴权
  var token = const AppToken();

  /// 用户信息
  var user = const User().obs;

  int noticeAlert = 0;

  @override
  void onInit() {
    noticeAlert = box.get(_kNoticeAlert, defaultValue: 0) as int;
    final tokenStr = box.get(_kAppToken, defaultValue: '') as String;
    if (tokenStr.isNotEmpty) {
      // 获取本地鉴权信息
      token = AppToken.fromJson(jsonDecode(tokenStr));
      // 获取用户信息
      final userStr = box.get(_kUser, defaultValue: '') as String;
      if (userStr.isNotEmpty) {
        user.value = User.fromJson(jsonDecode(userStr));
      }
    }

    // 此方法会频繁掉用  导致大量请求用户信息  导致闪退
    // if (isLogin) {
    //   reFetchUser();
    // }

    AppService.bus.on<AppNeedToLogin>().listen((event) {
      if (isLogin) {
        logout();
      }
    });
    super.onInit();
  }

  login(AppToken _token, User _user) {
    token = _token;
    user.value = _user;
    box.put(_kAppToken, jsonEncode(_token.toJson()));
    box.put(_kUser, jsonEncode(_user.toJson()));
  }

  logout() async {
    removeUser();
    Pusher.getInstance().disconnect();
    await Get.offAllNamed(Routes.SIGN);
  }

  removeUser() {
    // 清除现有信息
    token = const AppToken();
    user.value = const User();

    // 清除本地
    box.clear();
    box.put("guid", true);
  }

  // reFetchUser() async {
  //   final res = await NetRepository.client.userInfo();

  //   if (res.code != 0) {
  //     logger.e('获取用户信息错误', res.msg);
  //     return;
  //   }
  //   User info = (res.data) as User;
  //   if (user.value.id == info.id && user.value.userType != info.userType) {
  //     AppService.bus.fire(AuthSuccessEvent(
  //         userId: info.id!, userType: UserType.fromValue(info.userType!)));
  //   }
  //   updateUserInfo(info);
  // }

  Future<User> reFetchUser() async {
    User info = await Api.loadUserInfo();
    if (user.value.id == info.id && user.value.userType != info.userType) {
      AppService.bus.fire(AuthSuccessEvent(
          userId: info.id!, userType: UserType.fromValue(info.userType!)));
    }
    updateUserInfo(info);
    return info;
  }

  updateUserInfo(User info) {
    user.value = info;
    box.put(_kUser, jsonEncode(info));
  }

  setNoticeAlert() {
    box.put(_kNoticeAlert, DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  uploadAvatar(BuildContext context) async {
    try {
      Toast.showLoading();
      List<AssetEntity>? entities =
          await pickAssetEntity(context: context, maxAssetsCount: 1);
      if (entities == null) {
        Toast.hideLoading();
        return;
      }
      var file = (await (entities.first).file)!;
      file = await compressFile(file);

      final res = await NetRepository.uploadClient.upload(file);
      if (res.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg);
        return;
      }
      final url = (res.data as UploadResponse).url;
      final updateRes =
          await NetRepository.client.updateUserInfo(UpdateUserInfoRequest(
        headerImg: url,
      ));
      if (updateRes.code != 0) {
        Toast.hideLoading();
        Toast.showError(res.msg);
        return;
      }
      final user = UserService.to.user.value.copyWith(
        headerImg: url,
      );
      UserService.to.updateUserInfo(user);
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        MineController.to.updateUserHeadRefresh();
        Toast.hideLoading();
        Toast.showSuccess("succcess!");
      });
    } catch (e) {
      Toast.hideLoading();
    }
  }
}
