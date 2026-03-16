import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:appbyflutter/core/theme/display_mode.dart';
import 'package:appbyflutter/core/theme/display_mode_controller.dart';

/// 普通/长辈模式切换组件，可用于设置页、个人中心
/// 使用：DisplayModeSwitch()
class DisplayModeSwitch extends StatelessWidget {
  const DisplayModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DisplayModeController>();
    return Obx(() => SegmentedButton<DisplayMode>(
        segments: const [
          ButtonSegment(
            value: DisplayMode.normal,
            label: Text('普通模式'),
            icon: Icon(Icons.text_fields),
          ),
          ButtonSegment(
            value: DisplayMode.elder,
            label: Text('长辈模式'),
            icon: Icon(Icons.format_size),
          ),
        ],
        selected: {controller.mode.value},
        onSelectionChanged: (Set<DisplayMode> selected) {
          if (selected.isNotEmpty) controller.setMode(selected.first);
        },
      ));
  }
}
