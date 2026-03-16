/// 用户信息（与接口 /api/auth/users 返回单条一致）
class User {
  User({
    required this.id,
    required this.username,
    this.email,
    this.nickname,
    this.avatarUrl,
    this.phone,
    this.status,
    this.userType,
    this.isGuest = false,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String username;
  final String? email;
  final String? nickname;
  final String? avatarUrl;
  final String? phone;
  final String? status;
  final String? userType;
  final bool isGuest;
  final String? createdAt;
  final String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      userType: json['userType'] as String?,
      isGuest: json['isGuest'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'nickname': nickname,
        'avatarUrl': avatarUrl,
        'phone': phone,
        'status': status,
        'userType': userType,
        'isGuest': isGuest,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

/// 用户列表接口 data 结构（users + 分页信息）
class UserListResult {
  UserListResult({
    required this.users,
    required this.totalElements,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    this.hasNext = false,
    this.hasPrevious = false,
  });

  final List<User> users;
  final int totalElements;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final bool hasNext;
  final bool hasPrevious;

  factory UserListResult.fromJson(Map<String, dynamic> json) {
    final list = json['users'] as List<dynamic>?;
    return UserListResult(
      users: list != null
          ? list.map((e) => User.fromJson(e as Map<String, dynamic>)).toList()
          : [],
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 10,
      hasNext: json['hasNext'] as bool? ?? false,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
    );
  }
}
