import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/controllers/auth_controller.dart';
import 'package:appbyflutter/pages/friends/friends_page.dart';
import 'package:appbyflutter/pages/message/message_page.dart';
import 'package:appbyflutter/pages/profile/profile_page.dart';

/// 即时通讯首页：底部三 Tab（消息 / 好友 / 我的）
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = const [
    MessagePage(),
    FriendsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleForIndex(_currentIndex)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: '好友',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '我的',
          ),
        ],
      ),
    );
  }

  String _titleForIndex(int index) {
    switch (index) {
      case 0:
        return '消息';
      case 1:
        return '好友';
      case 2:
      default:
        return '我的';
    }
  }
}

