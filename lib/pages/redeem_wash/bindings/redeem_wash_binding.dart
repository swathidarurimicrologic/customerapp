import 'package:customer_app/pages/home/controllers/buy_wash_checkout_controller.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/redeem_wash/controllers/redeem_wash_controller.dart';
import 'package:get/get.dart';

class RedeemWashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedeemWashController>(
      () => RedeemWashController(),
    );
    Get.lazyPut<BuyWashCheckOutController>(
      () => BuyWashCheckOutController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
