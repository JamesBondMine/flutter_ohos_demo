import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:appbyflutter/core/network/api_response.dart';
import 'package:appbyflutter/core/network/user_api.dart';
import 'package:appbyflutter/models/user_model.dart';

const String _kStorageKeyIsLoggedIn = 'is_logged_in';
const String _kStorageKeyToken = 'auth_token';
const String _kStorageKeyTokenType = 'auth_token_type';
const String _kStorageKeyUser = 'auth_user';

/// 全局登录状态：是否已登录（即时通讯 APP 根据此决定进入登录页或首页）
/// 登录成功后调用 setLoggedIn(true)，登出或 token 失效时 setLoggedIn(false)
class AuthController extends GetxController {
  AuthController() {
    _loadFromStorage();
  }

  final Rx<bool> isLoggedIn = false.obs;
  final RxString token = ''.obs;
  final RxString tokenType = ''.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  static final GetStorage _storage = GetStorage();

  void _loadFromStorage() {
    final stored = _storage.read<bool>(_kStorageKeyIsLoggedIn);
    if (stored == true) isLoggedIn.value = true;
    token.value = _storage.read<String>(_kStorageKeyToken) ?? '';
    tokenType.value = _storage.read<String>(_kStorageKeyTokenType) ?? '';
    final userJson = _storage.read<String>(_kStorageKeyUser);
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final map = jsonDecode(userJson) as Map<String, dynamic>;
        currentUser.value = User.fromJson(map);
      } catch (_) {
        currentUser.value = null;
      }
    }
    // 实际项目中可在此校验 token 是否过期，过期则置为 false
  }

  void _saveToStorage() {
    _storage.write(_kStorageKeyIsLoggedIn, isLoggedIn.value);
    _storage.write(_kStorageKeyToken, token.value);
    _storage.write(_kStorageKeyTokenType, tokenType.value);
    final user = currentUser.value;
    if (user != null) {
      _storage.write(_kStorageKeyUser, jsonEncode(user.toJson()));
    }
  }

  /// 设置登录状态（登录成功 true，登出或失效 false）
  void setLoggedIn(bool value) {
    isLoggedIn.value = value;
    _saveToStorage();
  }

  /// 登出
  void logout() {
    setLoggedIn(false);
  }

  /// 示例：账号密码登录（用于联调 API，不依赖界面输入）
  /// 实际业务中可将 body 改为由页面输入拼装
  Future<ApiResponse<dynamic>> passwordLoginTest() async {
    final resp = await UserApi.passwordLogin(const {
      'usernameOrEmail': 'testuser',
      'password': '123456',
    });
    if (resp.isSuccess) {
      // 解析 data 中的 token 和 user
      final data = resp.data;
      if (data is Map<String, dynamic>) {
        token.value = data['token'] as String? ?? '';
        tokenType.value = data['tokenType'] as String? ?? '';
        final userMap = data['user'] as Map<String, dynamic>?;
        if (userMap != null) {
          currentUser.value = User.fromJson(userMap);
        }
      }
      setLoggedIn(true);
      _saveToStorage();
    }
    return resp;
  }

  /// 示例：获取用户列表（用于联调 API）
  Future<ApiResponse<UserListResult>> fetchUsersTest() {
    return UserApi.getUsers({
      'status': 'ACTIVE',
      'page': '0',
      'size': '10',
      'sortBy': 'createdAt',
      'sortDir': 'desc',
    });
  }
}
