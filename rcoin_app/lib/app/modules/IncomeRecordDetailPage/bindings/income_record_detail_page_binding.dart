import 'package:get/get.dart';

import '../controllers/income_record_detail_page_controller.dart';

class IncomeRecordDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeRecordDetailPageController>(
      () => IncomeRecordDetailPageController(),
    );
  }
}
