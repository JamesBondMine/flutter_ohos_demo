import 'dart:async';

// import 'package:crisp_chat_sdk/crisp_chat_sdk.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/service_online/models/message.dart';
import 'package:otc_app/network/request/paging_request.dart';
import 'package:otc_app/network/response/dialogue_list_fon.dart';
import 'package:otc_app/network/response/dialogue_message_list_fon.dart';

class ChatDialogue {
  final int groupId;
  final String groupName;
  final String groupAvatar;
  final Rx<Message?> lastMsg;
  final RxInt unreadCount;

  ChatDialogue({
    required this.groupId,
    required this.groupName,
    required this.groupAvatar,
    required this.unreadCount,
    Message? msg,
  }) : lastMsg = Rx<Message?>(msg);

  @override
  String toString() {
    return 'ChatDialogue{groupId: $groupId, groupName: $groupName, groupAvatar: $groupAvatar, lastMsg: ${lastMsg.toJson()}, unreadCount: $unreadCount}';
  }
}

class ChatService extends GetxService {
  static ChatService get to => Get.find<ChatService>();

  RxList<ChatDialogue> groups = RxList<ChatDialogue>([]);

  int get unread => groups.fold(
      0, (previousValue, element) => previousValue + element.unreadCount.value);

  StreamSubscription<ChatMsgEvent>? sub;
  Timer? timer;

  goChat(int receiveId, {dynamic params}) async {
    final res = await NetRepository.client.getDialogue(receiveId);
    if (res.code != 0) {
      Toast.showError(res.msg);
      return;
    }


    var group = res.data as DialogueListFon;
    Get.toNamed(Routes.CHAT_PAGE, arguments: {
      'group_id': group.id,
      'user_id': receiveId,
      'group': group.toChatDialogue(),
      'params': params,
    });
  }

  goChatWithService() async {
    goChat(-1);
    // final sdk = CrispChatSdk();
    // await sdk.configure(websiteId: "4f718011-b1e7-4367-925d-d27b8cd78781");
    // // await sdk.resetChatSession();
    // await sdk.setTokenID(tokenID: UserService.to.user.value.id!.toString());
    // await sdk.setUserNickname(nickname: UserService.to.user.value.username!);
    // await sdk.setUserAvatar(avatar: UserService.to.user.value.headerImg ?? '');
    // await sdk.setUserPhone(phone: UserService.to.user.value.phone ?? '');
    // await sdk.setUserEmail(email: UserService.to.user.value.email ?? '');
    // await CrispChatSdk().openChat();
  }

  @override
  void onInit() {
    super.onInit();
    sub = AppService.bus.on<ChatMsgEvent>().listen((event) {
      updateGroupLastMsg(event.message);
    });
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (UserService.to.isLogin) {
        // fetchGroups();
      }
    });
  }

  @override
  void onReady() {
    if (UserService.to.isLogin) {
      // fetchGroups();
    }
    super.onReady();
  }

  @override
  void onClose() {
    sub?.cancel();
    timer?.cancel();
    super.onClose();
  }

  DateTime parseDatetime(String? dateTimeString) {
    return dateTimeString == null
        ? DateTime.now()
        : DateTime.parse(dateTimeString);
  }

  fetchGroups() async {
    final res = await NetRepository.client
        .dialogueList(const PagingRequest(page: 1, pageSize: 1000));
    List<DialogueListFon> list =
        List.from(res.data.list as List<DialogueListFon>);

    groups.value = list.map((e) => e.toChatDialogue()).toList();
  }

  updateGroupLastMsg(Message msg) {
    var group = groups.where((g) => g.groupId == msg.dialogueId).firstOrNull;
    if (group == null) {
      // fetchGroups();
    }
    group?.lastMsg(msg);
  }

  clearGroupUnread(int groupId) {
    groups.where((g) => g.groupId == groupId).firstOrNull?.unreadCount(0);
  }
}
