import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otc_app/app.dart';
import 'package:otc_app/app/widgets/bottom_select.dart';
import 'package:otc_app/models/pay_side.dart';
import 'package:otc_app/services/chat_service.dart';

showFloatButton({bool show = true}) {
  _showFloatingButton.value = show;
}

final _showFloatingButton = true.obs;

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  final Size _buttonSize = Size(51.w, 192.w); // 按钮尺寸

  bool _isDragging = false;
  Offset _offset = Offset(310.w, 500.h);
  StreamSubscription<ChatMsgEvent>? sub;

  @override
  void initState() {
    _showFloatingButton.value = UserService.to.isLogin;
    // _offset = Offset(1.sw - _buttonSize, 500.h);
    super.initState();
    sub = AppService.bus.on<ChatMsgEvent>().listen((event) {
      // showBtn();
    });
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  void showBtn() {
    if (!_isDragging && mounted) {
      if (_offset.dx < 0) {
        _offset = Offset(0, _offset.dy);
        setState(() {});
      } else if (_offset.dx > 1.sw - _buttonSize.width) {
        _offset = Offset(1.sw - _buttonSize.width, _offset.dy);
        setState(() {});
      }
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    // var maxTop = Get.window.padding.top / Get.pixelRatio;
    double maxTop = 100;

    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    // 边界检测
    if (newOffsetX < 0) {
      newOffsetX = 0;
    }
    if (newOffsetX > 1.sw - _buttonSize.width) {
      newOffsetX = 1.sw - _buttonSize.width;
    }
    if (newOffsetY < maxTop) {
      newOffsetY = maxTop;
    }
    if (newOffsetY > 1.sh - _buttonSize.height - kBottomNavigationBarHeight) {
      newOffsetY = 1.sh - _buttonSize.height - kBottomNavigationBarHeight;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Obx(() => Visibility(
            visible: _showFloatingButton.value,
            child: Listener(
              onPointerMove: (PointerMoveEvent pointerMoveEvent) {
                _updatePosition(pointerMoveEvent);

                setState(() {
                  _isDragging = true;
                });
              },
              onPointerUp: (PointerUpEvent pointerUpEvent) {
                if (_isDragging) {
                  // if (_offset.dx == 0) {
                  //   _offset = Offset( 0, _offset.dy);
                  // }
                  // if (_offset.dx == 1.sw - _buttonSize.width) {
                  //   _offset = Offset(1.sw - 10, _offset.dy);
                  // }
                  setState(() {
                    _isDragging = false;
                  });
                } else {
                  // ChatService.to.goChat(-1);
                }
              },
              child: Material(
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImage(
                          Assets.homeCharge,
                          onTap: () {
                            Get.toNamed(Routes.RECHARGE);
                          },
                        ),
                        Container(
                          width: 50.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xffEBE0F4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '充值',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    36.w.vb,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImage(
                          Assets.homePublish,
                          onTap: () async {
                            await bottomSelect(title: '发布选择', options: <(String, PaySide)>[
                              ('买入', PaySide.buy),
                              ('卖出', PaySide.sell),
                            ]);
                            // Get.toNamed(Routes.LANGUAGE_SWITCH)
                            // PaySide paySide = PaySide.buy;
                            // Get.toNamed(Routes.POST_ORDER, arguments: {
                            //   'type': paySide,
                            // });
                          },
                        ),
                        Container(
                          width: 50.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xffEBE0F4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '发布',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: context.appColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
