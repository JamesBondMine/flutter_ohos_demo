import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/dialog.dart';
import 'package:otc_app/common/tools/compress_file.dart';
import 'package:otc_app/models/paging_index.dart';
import 'package:otc_app/models/trade_detail.dart';
import 'package:otc_app/network/request/chat_message_request.dart';
import 'package:otc_app/network/request/message_history_request.dart';
import 'package:otc_app/network/response/dialogue_list_fon.dart';
import 'package:otc_app/network/response/dialogue_message_list_fon.dart';
import 'package:otc_app/network/response/upload_response.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../service_online/models/contact.dart';
import '../../service_online/models/message.dart';

class ChatPageController extends GetxController {
  RxBool showGallerySelect = false.obs;
  late TextEditingController textEditingController;

  var centerKey = GlobalKey();
  var scroller = ScrollController();
  double extentAfter = 0;

  final int groupId = Get.arguments['group_id'];
  final int userId = Get.arguments['user_id'];
  final dynamic params = Get.arguments['params'];

  RxBool firstShow = false.obs;

  ChatDialogue group = Get.arguments['group'];

  //等待加入消息列表的消息
  List<Message> pendingMessage = [];

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    if (params != null && params is TradeDetail) {
      Get.dialog(const ConfirmDialog(title: '是否发送订单信息?')).then((value) {
        if (value != null && value!) {
          sendOrderMessage(params).then((message) {
            AppService.bus.fire(ChatMsgEvent(message!));
          });
        }
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
    scroller.dispose();
  }

  String sendTypeRefreshId = "sendTypeRefreshId";
  updateSendTypeRefresh() {
    update([sendTypeRefreshId]);
  }

  Future<Message?> sendEntity(AssetEntity entity) async {
    if (entity.type == AssetType.video) {
      return await sendVideoMessage(entity);
    } else if (entity.type == AssetType.image) {
      return await sendPictureMessage(entity);
    } else {
      Toast.showError('暂不支持该消息类型');
      return null;
    }
  }

  Future<Message?> sendVideoMessage(AssetEntity entity) async {
    final uploadRes =
        await NetRepository.uploadClient.upload((await entity.file)!);
    if (uploadRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return null;
    }
    var imageUrl = (uploadRes.data as UploadResponse).url!;

    final uploadThumbRes = await NetRepository.uploadClient
        .upload(await saveImage((await entity.thumbnailData)!));
    if (uploadThumbRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return null;
    }
    var thumbUrl = (uploadThumbRes.data as UploadResponse).url!;

    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: imageUrl,
      thumb: thumbUrl,
      videoDuration: entity.duration,
      // receiveId: -1,
      dialogueId: groupId,
      type: MessageType.video.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return null;
    }
    return (Message(
      id: res.data.id,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: userId,
      dialogueId: groupId,
      messageType: MessageType.video,
      content: imageUrl,
      duration: Duration(seconds: entity.duration),
      thumbnail: thumbUrl,
      createdAt: DateTime.now(),
    ));
  }

  Future<Message?> sendPictureMessage(AssetEntity entity) async {
    var file = await entity.file;
    // var file = await compressFile((await entity.file)!);
    final uploadRes = await NetRepository.uploadClient.upload(file!);
    if (uploadRes.code != 0) {
      Toast.showError(uploadRes.msg);
      return null;
    }
    var imageUrl = (uploadRes.data as UploadResponse).url!;
    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: imageUrl,
      // receiveId: -1,
      dialogueId: groupId,
      type: MessageType.picture.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return null;
    }
    return (Message(
      id: res.data.id,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: userId,
      dialogueId: groupId,
      messageType: MessageType.picture,
      content: imageUrl,
      createdAt: DateTime.now(),
    ));
  }

  Future<Message?> sendTextMessage() async {
    final content = textEditingController.text.trim();
    if (content.isEmpty) {
      return null;
    }
    textEditingController.clear();
    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: content,
      // receiveId: -1,
      dialogueId: groupId,
      type: MessageType.text.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return null;
    }
    return (Message(
      id: res.data.id,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: userId,
      dialogueId: groupId,
      messageType: MessageType.text,
      content: content,
      createdAt: DateTime.now(),
    ));
  }

  Future<Message?> sendOrderMessage(TradeDetail order) async {
    final content = json.encode(order.toJson());

    final res = await NetRepository.client.sendMessage(ChatMessageRequest(
      content: content,
      dialogueId: groupId,
      type: MessageType.order.value,
    ));
    if (res.code != 0) {
      Toast.showError(res.msg);
      return null;
    }
    return (Message(
      id: res.data.id,
      senderAvatar: UserService.to.user.value.headerImg!,
      senderNickname: UserService.to.user.value.nickName!,
      senderUid: UserService.to.user.value.id!,
      toUid: userId,
      dialogueId: groupId,
      messageType: MessageType.order,
      content: content,
      createdAt: DateTime.now(),
    ));
  }

  Future<(List<Message>, int)> fetchHistory(
    int page, {
    int pageSize = 10,
    int minId = 0,
  }) async {
    final res = await NetRepository.client.messageList(MessageHistoryRequest(
      id: groupId,
      pageSize: pageSize,
      page: page,
      minId: minId,
    ));
    if (res.code == 0) {
      var data = res.data as PagingIndex<DialogueMessageListFon>;
      var list = (data).list as List<DialogueMessageListFon>;
      return (list.map((e) => e.toMessage()).toList(), data.total);
    }

    return (<Message>[], 0);
  }
}
