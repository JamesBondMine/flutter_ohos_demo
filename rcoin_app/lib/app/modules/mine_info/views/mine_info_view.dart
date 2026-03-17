import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../controllers/mine_info_controller.dart';

class MineInfoView extends GetView<MineInfoController> {
  const MineInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AAppBar(
        title: '我的'.tr,
        shadow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => _Row(
                title: '昵称'.tr,
                value: UserService.to.user.value.nickName ?? '',
                onTap: () {
                  Get.toNamed(Routes.SET_NICKNAME);
                })),
            const _Uid(),
            6.w.vb,
            _Row(
                title: '语言'.tr,
                value: locales
                        .firstWhereOrNull((element) => element.$1 == Get.locale)
                        ?.$2 ??
                    '',
                onTap: () {
                  Get.toNamed(Routes.LANGUAGE_SWITCH);
                }),
            6.w.vb,
            _Row(
                title: '修改登录密码'.tr,
                value: '',
                onTap: () {
                  Get.toNamed(Routes.UPDATE_PAY_PASSWORD, arguments: {
                    'type': 1,
                  });
                }),
            Obx(() => _Row(
                  title: '邮箱'.tr,
                  value: (UserService.to.user.value.email?.isEmpty ?? true)
                      ? '未设置'.tr
                      : UserService.to.user.value.email!,
                  onTap: (UserService.to.user.value.email?.isEmpty ?? true)
                      ? () {
                          Get.toNamed(Routes.BIND_PHONE_EMAIL, arguments: {
                            "type": 2,
                          });
                        }
                      : null,
                )),
            Obx(
              () => _Row(
                title: '手机号'.tr,
                value: (UserService.to.user.value.phone?.isEmpty ?? true)
                    ? '未设置'.tr
                    : UserService.to.user.value.phone!,
                onTap: (UserService.to.user.value.phone?.isEmpty ?? true)
                    ? () {
                        Get.toNamed(Routes.BIND_PHONE_EMAIL, arguments: {
                          "type": 1,
                        });
                      }
                    : null,
              ),
            ),
            Obx(() => _Row(
                title: (UserService.to.user.value.payPassword?.isEmpty ?? true)
                    ? '资金密码'.tr
                    : '修改资金密码'.tr,
                value: (UserService.to.user.value.payPassword?.isEmpty ?? true)
                    ? '未设置'.tr
                    : '',
                onTap: () {
                  Get.toNamed(Routes.SET_PAY_PASSWORD);
                })),
            // Obx(() => _Row(
            //     title: '身份认证',
            //     value: (UserService.to.user.value.userType ?? 0) > 0 ? '已认证' : '尚未认证',
            //     onTap: (UserService.to.user.value.userType ?? 0) > 0
            //         ? null
            //         : () {
            //             Get.toNamed(Routes.VERIFY_IDENTITY);
            //           })),
            const VersionWidget(),
            _Row(
                title: '退出登录'.tr,
                value: '',
                onTap: () async {
                  bool? confirm = await showAppDialog(
                    ConfirmDialog(title: '确认退出吗?'.tr),
                  );

                  if (confirm ?? false) {
                    UserService.to.logout();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class _Uid extends StatelessWidget {
  const _Uid({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      dense: true,
      leading: Text(
        '邀请码'.tr,
        style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            UserService.to.user.value.inviteCode?.toString() ?? '',
            style: TextStyle(
                fontSize: 14.sp, color: context.appColors.textPlaceholder),
          ),
          2.w.hb,
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(
                  text:
                      UserService.to.user.value.inviteCode?.toString() ?? ''));
              Toast.showSuccess('复制成功'.tr);
            },
            child: Container(
                padding: EdgeInsets.only(right: 5.w),
                child: CustomImage(
                  Assets.imagesCopy,
                  width: 12.w,
                )),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(
      {super.key,
      required this.title,
      required this.value,
      required this.onTap});

  final String title;
  final String value;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      onTap: onTap,
      dense: true,
      leading: Text(
        title,
        style: TextStyle(fontSize: 14.sp, color: context.appColors.text1),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 14.sp, color: context.appColors.textPlaceholder),
          ),
          8.w.hb,
          const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xffAAABB3),
          ),
        ],
      ),
    );
  }
}

class VersionWidget extends HookWidget {
  const VersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final version = useState('');
    useEffect(() {
      PackageInfo.fromPlatform().then((info) {
        version.value = info.version;
      });
    }, []);
    return _Row(title: '当前版本'.tr, value: version.value, onTap: null);
  }
}
