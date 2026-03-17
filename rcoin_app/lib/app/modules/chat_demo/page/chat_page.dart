import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/modules/service_online/views/service_online_view.dart';
import 'package:otc_app/app/widgets/input_decoration.dart';
import 'package:otc_app/common/tools/wechat_picker.dart';
import 'package:otc_app/services/chat_service.dart';
import 'package:otc_app/services/pusher.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../service_online/models/message.dart';
import '../controllers/chat_page_controller.dart';
import '../helper/chat_data_helper.dart';
import '../model/chat_model.dart';
import '../widget/chat_unread_tip_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController scrollController = ScrollController();

  late ListObserverController observerController;

  late ChatScrollObserver chatObserver;

  List<Message> messages = [];

  ValueNotifier<int> unreadMsgCount = ValueNotifier<int>(0);

  bool needIncrementUnreadMsgCount = false;

  bool editViewReadOnly = false;

  TextEditingController editViewController = TextEditingController();

  BuildContext? pageOverlayContext;

  final LayerLink layerLink = LayerLink();

  bool isShowClassicHeaderAndFooter = false;

  ChatPageController get controller => Get.find<ChatPageController>();

  StreamSubscription<ChatMsgEvent>? sub;

  int page = 1;

  bool noMore = false;

  Timer? timer;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();

    sub = AppService.bus.on<ChatMsgEvent>().listen((event) {
      if (event.message.dialogueId == controller.groupId) {
        _addMessage(event.message);
      }
    });

    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (Pusher.getInstance().state.value == 'CONNECTED') {
        return;
      }
      final (list, _) = await controller.fetchHistory(1,
          pageSize: 50, minId: messages.isNotEmpty ? messages.last.id : 0);
      for (final item in list) {
        _addMessage(item);
      }
    });

    loadData();
    scrollController.addListener(scrollControllerListener);

    observerController = ListObserverController(controller: scrollController)
      ..cacheJumpIndexOffset = false;

    chatObserver = ChatScrollObserver(observerController)
      ..fixedPositionOffset = 5
      ..toRebuildScrollViewCallback = () {
        setState(() {});
      }
      ..onHandlePositionResultCallback = (result) {
        if (!needIncrementUnreadMsgCount) return;
        switch (result.type) {
          case ChatScrollObserverHandlePositionType.keepPosition:
            updateUnreadMsgCount(changeCount: result.changeCount);
            break;
          case ChatScrollObserverHandlePositionType.none:
            updateUnreadMsgCount(isReset: true);
            break;
        }
      };

    Future.delayed(const Duration(seconds: 1), addUnreadTipView);
  }

  @override
  void dispose() {
    observerController.controller?.dispose();
    editViewController.dispose();
    sub?.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: Config.kTheme!.bgMain,
        body: Column(
          children: [
            _headerView(context, controller.group.groupName),
            Expanded(child: _buildBody())
          ],
        ),
      ),
    );
  }

  PreferredSize _headerView(BuildContext context, String title) {
    return PreferredSize(
      preferredSize: Size(Get.width, MediaQuery.of(context).padding.top + 48),
      child: Container(
        height: MediaQuery.of(context).padding.top + 48,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                width: 52.w,
                height: 48.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Config.kTheme!.text1,
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Config.kTheme!.text1,
                  ),
                ),
                Text("当前通话已被加密".tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Config.kTheme!.text2,
                    )),
              ],
            )),
            Container(
              margin: EdgeInsets.only(left: 14.w),
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageOverlay() {
    return Overlay(initialEntries: [
      OverlayEntry(
        builder: (context) {
          pageOverlayContext = context;
          return Container();
        },
      )
    ]);
  }

  Widget _buildBody() {
    // return Container();
    Widget resultWidget = Column(
      children: [
        Expanded(child: _buildListView()),
        CompositedTransformTarget(
          link: layerLink,
          child: Container(),
        ),
        _buildEditView(),
        // const SafeArea(top: false, child: SizedBox.shrink()),
      ],
    );
    resultWidget = Stack(children: [
      resultWidget,
      _buildPageOverlay(),
    ]);
    return resultWidget;
  }

  Widget _buildEditView() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 30),
      decoration: BoxDecoration(
        color: Config.kTheme!.bgbtn,
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 10.w.hb,
              Expanded(
                child: TextField(
                  style:
                      TextStyle(fontSize: 14.sp, color: Config.kTheme!.text1),
                  maxLines: null,
                  controller: controller.textEditingController,
                  onTap: () {
                    controller.showGallerySelect.value = false;
                    controller.updateSendTypeRefresh();
                  },
                  onChanged: (value) {
                    controller.updateSendTypeRefresh();
                  },
                  decoration: outlineInputDecoration.copyWith(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                    hintText: 'Type message here...',
                    hintStyle:
                        TextStyle(color: Config.kTheme!.text2, fontSize: 13),
                    fillColor: Config.kTheme!.text2.withOpacity(0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              10.w.hb,
              _operateBtnView()
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
                            Message? message =
                                await controller.sendEntity(element);
                            if (message != null) {
                              _addMessage(message);
                            }
                          });
                        },
                      ),
                      Text(
                        '相册'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.text1,
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _operateBtnView() {
    return GetBuilder<ChatPageController>(
        id: controller.sendTypeRefreshId,
        builder: (con) {
          if (controller.textEditingController.text.isNotEmpty) {
            return CustomImage(
              Assets.chatSend,
              color: Config.kTheme!.text1,
              width: 20.w,
              onTap: () async {
                Message? message = await controller.sendTextMessage();
                if (message != null) {
                  _addMessage(message);
                }
                controller.updateSendTypeRefresh();
              },
            );
          }
          return CustomImage(
            Assets.chatMore,
            color: Config.kTheme!.text1,
            width: 30.w,
            onTap: () {
              controller.showGallerySelect.toggle();
              hideKeyboard(context);
              controller.updateSendTypeRefresh();
            },
          );
        });
  }

  Widget _buildUnreadTipView() {
    return ValueListenableBuilder<int>(
      builder: (context, value, child) {
        return ChatUnreadTipView(
          unreadMsgCount: unreadMsgCount.value,
          onTap: () {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            updateUnreadMsgCount(isReset: true);
          },
        );
      },
      valueListenable: unreadMsgCount,
    );
  }

  loadData() async {
    final res = await controller.fetchHistory(page);
    messages.addAll(res.$1);
    if (messages.length >= res.$2 || res.$1.isEmpty) {
      noMore = true;
    } else {
      page++;
    }
    setState(() {});
  }

  Widget _buildListView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Widget resultWidget = EasyRefresh.builder(
          footer: BuilderFooter(
            builder: (BuildContext context, IndicatorState state) =>
                Container(),
            clamping: false,
            triggerOffset: 0,
          ),
          onLoad: noMore
              ? null
              : () async {
                  loadData();
                },
          childBuilder: (context, physics) {
            var scrollViewPhysics =
                physics.applyTo(ChatObserverClampingScrollPhysics(
              observer: chatObserver,
            ));
            Widget resultWidget = ListView.builder(
              physics: scrollViewPhysics,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 15,
              ),
              shrinkWrap: chatObserver.isShrinkWrap,
              reverse: true,
              controller: scrollController,
              itemBuilder: ((context, index) {
                return MessageWidget(message: messages[index]);
              }),
              itemCount: messages.length,
            );

            debugPrint('isShrinkWrap:${chatObserver.isShrinkWrap}');
            if (chatObserver.isShrinkWrap) {
              resultWidget = SingleChildScrollView(
                reverse: true,
                physics: scrollViewPhysics,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: constraints.maxHeight + 0.001,
                  child: resultWidget,
                ),
              );
            }
            return resultWidget;
          },
        );

        resultWidget = ListViewObserver(
          controller: observerController,
          child: resultWidget,
        );
        resultWidget = Align(
          alignment: Alignment.topCenter,
          child: resultWidget,
        );
        return resultWidget;
      },
    );
  }

  addUnreadTipView() {
    Overlay.of(pageOverlayContext!).insert(OverlayEntry(
      builder: (BuildContext context) => UnconstrainedBox(
        child: CompositedTransformFollower(
          link: layerLink,
          followerAnchor: Alignment.bottomRight,
          targetAnchor: Alignment.topRight,
          offset: const Offset(-20, 0),
          child: Material(
            type: MaterialType.transparency,
            // color: Colors.green,
            child: _buildUnreadTipView(),
          ),
        ),
      ),
    ));
  }

  List<ChatModel> createChatModels({int num = 3}) {
    return Iterable<int>.generate(num)
        .map((e) => ChatDataHelper.createChatModel())
        .toList();
  }

  _addMessage(Message message) {
    final index = messages.indexWhere((element) => element.id == message.id);
    if (index != -1) {
      return;
    }
    ChatService.to.updateGroupLastMsg(message);

    chatObserver.standby(changeCount: 1);
    setState(() {
      needIncrementUnreadMsgCount = true;
      messages.insert(0, message);
    });
  }

  updateUnreadMsgCount({
    bool isReset = false,
    int changeCount = 1,
  }) {
    needIncrementUnreadMsgCount = false;
    if (isReset) {
      unreadMsgCount.value = 0;
    } else {
      unreadMsgCount.value += changeCount;
    }
  }

  scrollControllerListener() {
    if (scrollController.offset < 50) {
      updateUnreadMsgCount(isReset: true);
    }
  }
}
