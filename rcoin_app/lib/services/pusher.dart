import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/service_online/models/message.dart';
import 'package:otc_app/models/publish_order.dart';
import 'package:otc_app/models/system_message.dart';
import 'package:otc_app/network/exception_handler.dart';
import 'package:otc_app/network/response/dialogue_message_list_fon.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class Pusher {
  static Pusher? _instance;

  PusherChannel? privateChannel;

  static Pusher getInstance() {
    _instance ??= Pusher();
    return _instance!;
  }

  PusherChannelsFlutter get pusher => PusherChannelsFlutter.getInstance();

  Rx<String> state = ''.obs;
  DateTime? stateChangeTime;

  void onEvent(PusherEvent event) {
    logger.d('pusher events:$event');

    if (event.channelName == 'private-${UserService.to.user.value.id}') {
      if (event.eventName == 'msg') {
        var data = event.data;
        final rawMsg = DialogueMessageListFon.fromJson(jsonDecode(data));
        final message = rawMsg.toMessage();
        AppService.bus.fire(ChatMsgEvent(message));

        if (AppService.to.appIsBackground ||
            Get.currentRoute != Routes.CHAT_PAGE) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: message.id,
              channelKey: 'basic_channel',
              title: message.senderNickname,
              body: message.summary(),
              // summary: message.summary(),
              payload: {
                'dialogueId': (message.dialogueId ?? 0).toString(),
                'senderUid': message.senderUid.toString(),
              },
            ),
          );
        }
      } else if (event.eventName == 'systemMsg') {
        var message = SystemMessage.fromRawJson(event.data);

        AppService.bus.fire(TradeEvent(message.tradeId!));
        Get.locale!.languageCode == 'zh';
        if(Get.locale!.languageCode == 'zh'){
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: message.id!,
              channelKey: 'order_channel',
              title: message.title,
              body: message.content,
              // summary: message.summary(),
              payload: {
                'trade_id': message.tradeId!.toString(),
              },
            ),
          );
        }
        if(Get.locale!.languageCode == 'en'){
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: message.id!,
              channelKey: 'order_channel',
              title: message.titleEn,
              body: message.contentEn,
              // summary: message.summary(),
              payload: {
                'trade_id': message.tradeId!.toString(),
              },
            ),
          );
        }
        if(Get.locale!.languageCode == 'hi'){
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: message.id!,
              channelKey: 'order_channel',
              title: message.titleHi,
              body: message.contentHi,
              // summary: message.summary(),
              payload: {
                'trade_id': message.tradeId!.toString(),
              },
            ),
          );
        }


        var notifySounds = {
          'PLACE': Assets.alertSoundNotifyConfirm,
          'TAKE': Assets.alertSoundNotifyPay,
          'PAY': Assets.alertSoundNotifyConfirmReceipt,
          'RECEIPT': Assets.alertSoundNotifyComplete,
          'CANCEL': Assets.alertSoundNotificationCancel,
          'UNABLE': Assets.alertSoundUnablePayment,
        };
        var sound = notifySounds[message.type];
        if (sound != null) {
          //AppService.to.play(sound);
        }
      } else if (event.eventName == 'newOrder') {
        var order = PublishOrder.fromJson(json.decode(event.data));
        AppService.bus.fire(NewOrderEvent(order: order));
      }
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName member: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName member: $member");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    state.value = currentState;
    stateChangeTime = DateTime.now();
    print("Pusher connection: $currentState");
  }

  void onError(String message, int? code, dynamic error) {
    print("Pusher onError: $message error:$error");
  }

  init() async {
    try {
      await pusher.init(
        apiKey: Config.pusherConfig.apiKey,
        host: Config.pusherConfig.host,
        wsPort: Config.pusherConfig.wsPort,
        wssPort: Config.pusherConfig.wssPort,
        useTLS: Config.pusherConfig.useTLS,
        cluster: Config.pusherConfig.cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "http://10.226.7.84:9998/pusher/auth",
        onAuthorizer: (String channelName, String socketId, _) async {
          final res = await Dio(BaseOptions(
            baseUrl: Config.host,
            headers: {
              'x-token': UserService.to.token.token,
            },
          )).post("/message/pusherAuth",
              data: "socket_id=$socketId&channel_name=$channelName");

          if (res.data is Map) {
            return res.data;
          } else {
            return null;
          }
        },
      );
      if (UserService.to.isLogin) {
        connect();
      }
      // await pusher.signin();
    } catch (e) {
      print("ERROR: $e");
    }

    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (UserService.to.isLogin) {
        checkConnection();
      }
    });
  }

  connect() async {
    await pusher.connect();
    try {
      privateChannel = await pusher.subscribe(
          channelName: 'private-${UserService.to.user.value.id}');
      await pusher.subscribe(channelName: 'presence-public');
    } catch (e) {
    }
  }

  disconnect() async {
    await privateChannel?.unsubscribe();
    await pusher.disconnect();
  }

  checkConnection() async {
    if (state.value != "CONNECTED" &&
        (stateChangeTime == null ||
            DateTime.now().difference(stateChangeTime!) >
                const Duration(minutes: 1))) {
      await disconnect();
      connect();
    }
  }
}
