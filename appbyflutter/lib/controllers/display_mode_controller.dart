import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:appbyflutter/core/theme/display_mode.dart';

const String _kStorageKeyDisplayMode = 'display_mode';
const String _kStorageKeyHasChosenDisplayMode = 'has_chosen_display_mode';

/// 全局显示模式控制器：普通模式 / 长辈模式（字体大小）
/// 使用 Get.put(DisplayModeController()) 注入，页面内通过 Get.find<DisplayModeController>() 或 GetX 依赖使用
class DisplayModeController extends GetxController {
  DisplayModeController() {
    _loadFromStorage();
  }

  final Rx<DisplayMode> mode = DisplayMode.normal.obs;

  /// 是否已做过「普通/长辈模式」选择（首次启动未选则为 false）
  final Rx<bool> hasChosenDisplayMode = false.obs;

  static final GetStorage _storage = GetStorage();

  /// 当前文字缩放系数，供主题使用
  double get textScaleFactor => mode.value.textScaleFactor;

  void _loadFromStorage() {
    final stored = _storage.read<String>(_kStorageKeyDisplayMode);
    if (stored != null) {
      final index =
          DisplayMode.values.indexWhere((e) => e.name == stored);
      if (index >= 0) mode.value = DisplayMode.values[index];
    }
    final hasChosen = _storage.read<bool>(_kStorageKeyHasChosenDisplayMode);
    if (hasChosen == true) hasChosenDisplayMode.value = true;
  }

  void _saveToStorage() {
    _storage.write(_kStorageKeyDisplayMode, mode.value.name);
  }

  /// 在「模式选择页」选择并确认，之后视为已选过模式
  void selectAndConfirm(DisplayMode value) {
    mode.value = value;
    _saveToStorage();
    hasChosenDisplayMode.value = true;
    _storage.write(_kStorageKeyHasChosenDisplayMode, true);
  }

  /// 切换显示模式（普通 ↔ 长辈），仅设置页等已选过模式后使用
  void toggleMode() {
    mode.value = mode.value == DisplayMode.normal
        ? DisplayMode.elder
        : DisplayMode.normal;
    _saveToStorage();
  }

  /// 设置为指定模式
  void setMode(DisplayMode value) {
    mode.value = value;
    _saveToStorage();
  }

  bool get isElderMode => mode.value == DisplayMode.elder;
  bool get isNormalMode => mode.value == DisplayMode.normal;
}
