import 'package:get/get.dart';

import 'package:otc_app/app/modules/trade/controllers/buy_orders_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/order_filter_controller.dart';
import 'package:otc_app/app/modules/trade/controllers/sale_orders_controller.dart';

import '../controllers/trade_controller.dart';

class TradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleOrdersController>(
      () => SaleOrdersController(),
    );
    Get.lazyPut<BuyOrdersController>(
      () => BuyOrdersController(),
    );
    Get.lazyPut<TradeController>(
      () => TradeController(),
    );
    Get.lazyPut<OrderFilterController>(
          () => OrderFilterController(),
    );
  }
}
