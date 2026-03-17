import 'package:get/get.dart';
import 'package:scan/scan.dart';

class ScanPageController extends GetxController {
  final ScanController scanController = ScanController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scanController.pause();
  }

}
