import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/models/paging_index.dart';
import 'package:otc_app/network/request/chat_message_request.dart';
import 'package:otc_app/network/request/message_history_request.dart';
import 'package:otc_app/network/response/dialogue_message_list_fon.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../models/contact.dart';
import '../models/message.dart';



class ServiceOnlineController extends GetxController {
  RxBool showGallerySelect = false.obs;
  late TextEditingController textEditingController;

  var centerKey = GlobalKey();
  var scroller = ScrollController();
  double extentAfter = 0;

  Map<String, Contact> users = {
    '0': Contact(uid: '-1', name: 'service', avatar: Assets.imagesService)
  };

  RxList<Message> oldData = RxList<Message>([]);

  RxList<Message> newData = RxList<Message>([]);

  StreamSubscription<ChatMsgEvent>? sub;

  Contact? getContact(String userId) {
    if (userId == UserService.to.user.value.id.toString()) {
      return Contact(
        uid: userId,
        name: UserService.to.user.value.nickName!,
        avatar: UserService.to.user.value.headerImg!,
      );
    }
    return users[userId];
  }

  RxBool firstShow = false.obs;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();

    sub = AppService.bus.on<ChatMsgEvent>().listen((event) {
      newData.add(event.message);
    });

    fetchHistory().then((value) async {
      newData.addAll(value);
      // await Future.delayed(const Duration(milliseconds: 100));
      // scroller.jumpTo(scroller.position.maxScrollExtent);
      // await Future.delayed(const Duration(milliseconds: 300));
      // firstShow.value = true;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
    scroller.dispose();
    sub?.cancel();
  }

  sendEntity(AssetEntity entity) {
    if (entity.type == AssetType.video) {
      sendVideoMessage(entity);
    } else if (entity.type == AssetType.image) {
      sendPictureMessage(entity);
    } else {
      Toast.showError('暂不支持该消息类型');
    }
  }

  sendVideoMessage(AssetEntity entity) async {
    final uploadRes =
        await NetRepository.uploadClient.upload((await entity.file)!);
    if (uploadRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return;
    }
    var imageUrl = (uploadRes.data as UploadResponse).url!;

    final uploadThumbRes = await NetRepository.uploadClient
        .upload(await saveImage((await entity.thumbnailData)!));
    if (uploadThumbRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return;
    }
    var thumbUrl = (uploadThumbRes.data as UploadResponse).url!;

    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: imageUrl,
      thumb: thumbUrl,
      videoDuration: entity.duration,
      receiveId: -1,
      type: MessageType.video.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    newData.add(Message(
      id: 1,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: -1,
      messageType: MessageType.video,
      content: imageUrl,
      duration: Duration(seconds: entity.duration),
      thumbnail: thumbUrl,
      createdAt: DateTime.now(),
    ));
    scrollToBottom();
  }

  sendPictureMessage(AssetEntity entity) async {
    final uploadRes =
        await NetRepository.uploadClient.upload((await entity.file)!);
    if (uploadRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return;
    }
    var imageUrl = (uploadRes.data as UploadResponse).url!;
    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: imageUrl,
      receiveId: -1,
      type: MessageType.picture.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    newData.add(Message(
      id: 1,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: -1,
      messageType: MessageType.picture,
      content: imageUrl,
      createdAt: DateTime.now(),
    ));
    scrollToBottom();
  }

  sendTextMessage() async {
    final content = textEditingController.text.trim();
    if (content.isEmpty) {
      return;
    }
    textEditingController.clear();
    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: content,
      receiveId: -1,
      type: MessageType.text.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }
    newData.add(Message(
      id: 1,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: -1,
      messageType: MessageType.text,
      content: content,
      createdAt: DateTime.now(),
    ));
    scrollToBottom();
  }

  scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scroller.jumpTo(scroller.position.maxScrollExtent);
    });
  }

  int page = 1;

  Future<List<Message>> fetchHistory() async {
    final res = await NetRepository.client.messageList(MessageHistoryRequest(
      targetId: -1,
      pageSize: 30,
      page: page,
      id: 0,
    ));
    if (res.code == 0) {
      var list = (res.data as PagingIndex<DialogueMessageListFon>).list
          as List<DialogueMessageListFon>;
      return list.map((e) => e.toMessage()).toList().reversed.toList();
    }

    return [];
  }
}
