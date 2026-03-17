import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Shower {
  Future showScreenViewCustom(BuildContext context, double height, Widget child,
      {double radius = 12.0,
      bool autoDismiss = false,
      bool nobarrierColor = false,
      bool isScrollControlled = true}) async {
    return await showModalBottomSheet<Null>(
        isScrollControlled: isScrollControlled,
        context: context,
        backgroundColor: Color(0xffffffff),
        enableDrag: true,
        barrierColor:
            nobarrierColor ? Colors.black.withOpacity(0) : Colors.black54,
        constraints: BoxConstraints(maxHeight: height),
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        elevation: 21,
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.decelerate,
            child: Column(
              children: [Expanded(child: child)],
            ),
          );
        });
  }
}
