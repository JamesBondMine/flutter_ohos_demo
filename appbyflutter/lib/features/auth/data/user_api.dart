import 'package:appbyflutter/core/config/app_config.dart';
import 'package:appbyflutter/core/network/api_response.dart';
import 'package:appbyflutter/features/auth/data/models/user_model.dart';

/// 用户相关接口（示例：用户列表）
class UserApi {
  UserApi._();

  static const String _pathUsers = '/api/auth/users';

  /// 获取用户列表（分页）
  /// 对应接口: GET /api/auth/users?status=ACTIVE&page=0&size=10&sortBy=createdAt&sortDir=desc
  static Future<ApiResponse<UserListResult>> getUsers({
    String status = 'ACTIVE',
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  }) async {
    return AppConfig.httpClient.get<UserListResult>(
      _pathUsers,
      queryParameters: {
        'status': status,
        'page': page.toString(),
        'size': size.toString(),
        'sortBy': sortBy,
        'sortDir': sortDir,
      },
      fromJsonData: (d) => UserListResult.fromJson(d as Map<String, dynamic>),
    );
  }
}
