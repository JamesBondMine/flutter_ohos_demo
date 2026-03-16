import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/controllers/auth_controller.dart';

/// 我的页面（Tab 3）：展示当前登录用户的部分信息
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Obx(() {
      final user = auth.currentUser.value;

      if (user == null) {
        return const Center(
          child: Text('未登录'),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(
                    (user.nickname?.isNotEmpty == true
                            ? user.nickname!
                            : user.username)
                        .characters
                        .take(1)
                        .toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nickname?.isNotEmpty == true
                          ? user.nickname!
                          : user.username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '账号：${user.username}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('邮箱', user.email ?? '-'),
                    const SizedBox(height: 8),
                    _infoRow('手机号', user.phone ?? '-'),
                    const SizedBox(height: 8),
                    _infoRow('状态', user.status ?? '-'),
                    const SizedBox(height: 8),
                    _infoRow('用户类型', user.userType ?? '-'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}


