import 'package:get/get.dart';

import '../controllers/income_record_page_controller.dart';

class IncomeRecordPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeRecordPageController>(
      () => IncomeRecordPageController(),
    );
  }
}
