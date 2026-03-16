import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/core/auth/auth_controller.dart';

/// 即时通讯首页（占位，后续接入会话列表等）
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('即时通讯首页（占位）'),
      ),
    );
  }
}
