import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/google_auth_controller.dart';

class GoogleAuthView extends GetView<GoogleAuthController> {
  const GoogleAuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoogleAuthView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GoogleAuthView is working',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
