import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app/routes/app_pages.dart';
import 'package:otc_app/service.dart';

class AuthGuard extends GetMiddleware {
//   Get the auth service
  UserService get authService => Get.find<UserService>();

//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Navigate to login if client is not authenticated other wise continue
    if (!authService.isLogin) {
      return const RouteSettings(name: Routes.SIGN);
    }

    return null;
  }
}
