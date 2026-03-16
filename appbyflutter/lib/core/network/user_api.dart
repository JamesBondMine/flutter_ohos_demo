import 'package:appbyflutter/core/config/app_config.dart';
import 'package:appbyflutter/core/network/api_response.dart';
import 'package:appbyflutter/models/user_model.dart';

/// 用户相关接口（示例：登录、用户列表）
class UserApi {
  UserApi._();

  static const String _pathUsers = '/api/auth/users';
  static const String _pathLogin = '/api/auth/login';
  static const String _pathSendSmsCode = '/api/auth/send-sms-code';

  /// 账号密码登录
  /// [body] 由上层（如 Controller）传入 Map，例如：
  /// { 'usernameOrEmail': 'xxx', 'password': 'yyy' }
  static Future<ApiResponse<dynamic>> passwordLogin(
      Map<String, dynamic> body) async {
    return AppConfig.httpClient.post<dynamic>(
      _pathLogin,
      body: body,
    );
  }

  /// 发送手机验证码
  /// [phone] 手机号
  static Future<ApiResponse<dynamic>> sendSmsCode(String phone) async {
    return AppConfig.httpClient.post<dynamic>(
      _pathSendSmsCode,
      body: {'phone': phone},
    );
  }

  /// 获取用户列表（分页）
  /// [query] 由上层传入，例如：
  /// {
  ///   'status': 'ACTIVE',
  ///   'page': '0',
  ///   'size': '10',
  ///   'sortBy': 'createdAt',
  ///   'sortDir': 'desc',
  /// }
  static Future<ApiResponse<UserListResult>> getUsers(
      Map<String, String> query) async {
    return AppConfig.httpClient.get<UserListResult>(
      _pathUsers,
      queryParameters: query,
      fromJsonData: (d) => UserListResult.fromJson(d as Map<String, dynamic>),
    );
  }
}
