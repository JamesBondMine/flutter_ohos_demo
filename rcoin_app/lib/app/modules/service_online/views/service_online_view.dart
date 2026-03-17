import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/wechat_picker.dart';
import 'package:otc_app/common/widgets/avatar.dart';
import 'package:otc_app/common/widgets/image_view.dart';
import 'package:otc_app/common/widgets/video_view.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/service_online_controller.dart';
import '../models/message.dart';

class ServiceOnlineView extends GetView<ServiceOnlineController> {
  const ServiceOnlineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.showGallerySelect.value = false;
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AAppBar(
          shadow: true,
          titleWidget: Column(
            children: [
              Text("客服",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff232226),
                  )),
              Text("当前通话已被加密",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff232226),
                  )),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollNotification) {
                  if (notification.metrics is PageMetrics) {
                    return false;
                  }
                  if (notification.metrics is FixedScrollMetrics) {
                    if (notification.metrics.axisDirection ==
                            AxisDirection.left ||
                        notification.metrics.axisDirection ==
                            AxisDirection.right) {
                      return false;
                    }
                  }
                  controller.extentAfter = notification.metrics.extentAfter;
                }
                return false;
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0).r,
                child: CustomScrollView(
                  controller: controller.scroller,
                  center: controller.centerKey,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // SliverPadding(
                    //   padding: EdgeInsets.zero,
                    //   key: controller.centerKey,
                    // ),
                    Obx(() => SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return MessageWidget(
                                  message: controller.oldData[index]);
                            },
                            childCount: controller.oldData.length,
                          ),
                        )),
                    SliverPadding(
                      padding: EdgeInsets.zero,
                      key: controller.centerKey,
                    ),
                    Obx(() => SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return MessageWidget(
                                  message: controller.newData[index]);
                            },
                            childCount: controller.newData.length,
                          ),
                        )),
                  ],
                ),
              ),
            )),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                  color: Colors.black.withOpacity(0.05),
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomImage(
                        Assets.chatMore,
                        width: 20.w,
                        onTap: () {
                          controller.showGallerySelect.toggle();
                          hideKeyboard(context);
                        },
                      ),
                      10.w.hb,
                      Expanded(
                        child: TextField(
                          controller: controller.textEditingController,
                          onTap: () {
                            controller.showGallerySelect.value = false;
                          },
                          decoration: outlineInputDecoration,
                        ),
                      ),
                      10.w.hb,
                      CustomImage(
                        Assets.chatSend,
                        width: 20.w,
                        onTap: controller.sendTextMessage,
                      )
                    ],
                  ),
                  Obx(() => Visibility(
                        visible: controller.showGallerySelect.value,
                        child: Container(
                          padding: EdgeInsets.only(top: 10.w),
                          child: Column(
                            children: [
                              CustomImage(
                                Assets.chatGallary,
                                width: 44.w,
                                onTap: () async {
                                  final entities = await pickAssetEntity(
                                    context: context,
                                    maxAssetsCount: 9,
                                    requestType: RequestType.common,
                                  );
                                  entities?.forEach((element) async {
                                    await controller.sendEntity(element);
                                  });
                                },
                              ),
                              Text(
                                '相册',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Config.kTheme!.text2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isSender = message.senderUid == UserService.to.user.value.id;
    Widget msg = switch (message.messageType) {
      MessageType.text => MsgBubble(
          text: message.content,
          isSender: isSender,
        ),
      MessageType.picture => PictureMessage(imagePath: message.content),
      MessageType.video => VideoMessage(message: message),
      MessageType.order => OrderMsg(
          message: message,
        ),
    };
    Widget avatar = Avatar(
      width: 32.w,
      color: Config.kTheme!.bg1,
      imagePath: message.senderAvatar.isNotEmpty
          ? message.senderAvatar
          : Assets.imagesIconAvatar,
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.w.vb,
          Text(
            ucTimeAgo(message.createdAt),
            style: TextStyle(
              fontSize: 12.sp,
              color: Config.kTheme!.text2,
            ),
          ),
          20.w.vb,
          Row(
            textDirection: isSender ? TextDirection.ltr : TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [msg, 5.w.hb, avatar],
          ),
        ],
      ),
    );
  }
}

class OrderMsg extends StatelessWidget {
  const OrderMsg({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    TradeDetail trade = TradeDetail.fromJson(json.decode(message.content));
    bool isSender = message.senderUid == UserService.to.user.value.id;
    Widget avatar = Avatar(
      width: 32.w,
      color: context.appColors.primary,
      imagePath: message.senderAvatar.isNotEmpty
          ? message.senderAvatar
          : Assets.imagesIconAvatar,
    );
    return MsgBubble(
      isSender: isSender,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: isSender ? const Color(0xff2B2B30) : Colors.white,
          ),
          children: [
            TextSpan(text: '【${trade.isBuyer ? '代收' : '待付'}】'),
            TextSpan(
                text: '${trade.orderSn}',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ))
          ],
        ),
      ),
    );
  }
}

class PictureMessage extends StatelessWidget {
  const PictureMessage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CustomImage(
          imagePath,
          onTap: () {
            Get.to(
              () => HeroPhotoViewRouteWrapper(
                  imageProvider: NetworkImage(imagePath), tag: 'image'),
              transition: Transition.zoom,
            );
          },
        ),
      ),
    );
  }
}

class VideoMessage extends StatelessWidget {
  const VideoMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => VideoPreviewPage(url: message.content),
            transition: Transition.zoom,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              CustomImage(
                message.thumbnail!,
              ),
              const Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MsgBubble extends StatelessWidget {
  const MsgBubble({super.key, this.isSender = false, this.text, this.child});

  final bool isSender;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color:
              isSender ? Config.kTheme!.bg1 : Colors.white.withOpacity(0.12)),
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        // child: CustomPaint(
        //   painter: Bubble(isLeft: !isSender),
        child: Container(
          // color: Colors.red,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
            minHeight: 12.w,
          ),
          margin: const EdgeInsets.fromLTRB(7, 7, 14, 7),
          child: child ??
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Config.kTheme!.text1,
                ),
                textAlign: TextAlign.left,
              ),
        ),
      ),
    );
  }
}

class Bubble extends CustomPainter {
  final bool isLeft;

  Bubble({this.isLeft = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = isLeft ? const Color(0xfff6f1f9) : const Color(0xffC478FF);
    path = Path();

    double radius = 5;
    double offset = 8;
    double nipSize = 5;

    path.addRRect(RRect.fromLTRBR(
        0, 0, size.width - nipSize, size.height, Radius.circular(radius)));

    var path2 = Path();

    if (isLeft) {
      path2.lineTo(-nipSize, nipSize);
      path2.lineTo(0, 2 * nipSize);
      path2.lineTo(0, 0);
      path.addPath(path2, Offset(0, offset));
    } else {
      path2.lineTo(nipSize, nipSize);
      path2.lineTo(0, 2 * nipSize);
      path2.lineTo(0, 0);
      path.addPath(path2, Offset(size.width - nipSize, offset));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
