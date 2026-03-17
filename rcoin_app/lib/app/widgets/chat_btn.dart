import 'package:flutter/material.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/services/chat_service.dart';

class ChatBtn extends StatelessWidget {
  const ChatBtn({super.key, this.tradeDetail});

  final TradeDetail? tradeDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TradeDetail detail = controller.state!;
        // int receiveId = detail.userId == UserService.to.user.value.id
        //     ? detail.orderUserId!
        //     : detail.userId!;
        ChatService.to.goChat(-1, params: tradeDetail);
        // Get.toNamed(Routes.SERVICE_ONLINE);
        // Get.find<OrderDetailController>().cancelOrder();
      },
      child: Container(
        width: 42.w,
        height: 42.w,
        margin: const EdgeInsets.only(right: 10),
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Color(0xffF6F6F6)),
        child: Center(
          child: CustomImage(
            Assets.newimagesHomeService,
            color: Colors.black,
            onTap: () {
              ChatService.to.goChatWithService();
            },
          ),
        ),
      ),
    );
  }
}
