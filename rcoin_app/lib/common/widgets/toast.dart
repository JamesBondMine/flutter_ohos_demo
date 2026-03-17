import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'app_progress_indicator.dart';

class Toast {
  static NavigatorObserver toastNavigatorObserver() =>
      BotToastNavigatorObserver();

  static Widget init(BuildContext context, Widget child) {
    return BotToastInit().call(context, child);
  }

  static void show(Widget icon, String message) {
    BotToast.cleanAll();
    BotToast.showCustomText(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double borderRadius = constraints.maxHeight / 2;
            return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff232323),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon,
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          message,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  static void showMessage(String message) {
    BotToast.cleanAll();
    BotToast.showCustomText(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double borderRadius = constraints.maxHeight / 2;
            return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  color: Color.fromARGB(255, 43, 43, 43),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          message,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  static void showError(String message) {
    show(
        Transform.rotate(
          angle: pi / 4,
          child: const Icon(
            Icons.add_circle_outlined,
            color: Colors.white,
          ),
        ),
        message);
  }

  static void showInfo(String message, {bool icon = false}) {
    if (!icon) {
      showMessage(message);
      return;
    }
    show(const Icon(Icons.info, color: Colors.white), message);
  }

  static void showSuccess(String message) {
    show(
        const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
        ),
        message);
  }

  static void showLoading({String? message, bool clickClose = true}) {
    const size = 60.0;

    BotToast.showCustomLoading(
        clickClose: clickClose,
        backgroundColor: Colors.transparent,
        toastBuilder: (cancelFunc) {
          final indicator = AppProgressIndicator(
            size: 40,
            color1: Colors.white.withOpacity(0),
            color2: Colors.white,
          );
          if (message == null) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: indicator,
            );
          }
          return Container(
            constraints: const BoxConstraints(minWidth: size, minHeight: size),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                indicator,
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading() {
    BotToast.closeAllLoading();
  }
}
