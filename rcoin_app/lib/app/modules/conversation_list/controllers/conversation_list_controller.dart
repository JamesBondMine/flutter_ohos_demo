import 'package:get/get.dart';
import 'package:otc_app/services/chat_service.dart';

class ConversationListController extends GetxController {
  List<ChatDialogue> get groups {
    List<ChatDialogue> list = ChatService.to.groups.toList();
    list.sort((ChatDialogue a, ChatDialogue b) {
      return (a.lastMsg.value?.createdAt ?? DateTime.now())
          .isBefore((b.lastMsg.value?.createdAt ?? DateTime.now()))
          ? 1
          : -1;
    });
    return list;
  }

  DateTime parseDatetime(String? dateTimeString) {
    return dateTimeString == null
        ? DateTime.now()
        : DateTime.parse(dateTimeString);
  }
  @override
  void onInit() {
    super.onInit();
    ChatService.to.fetchGroups();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
