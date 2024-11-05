import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/pages/home/controllers/account_controller.dart';
import 'package:customer_app/pages/home/controllers/add_new_card_controller.dart';
import 'package:customer_app/pages/home/controllers/buy_wash_checkout_controller.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/controllers/my_washes_controller.dart';
import 'package:customer_app/pages/home/controllers/payment_method_controller.dart';
import 'package:customer_app/pages/home/controllers/transactions_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AddNewCardController>(
      () => AddNewCardController(),
    );
    Get.lazyPut<BuyWashCheckOutController>(
      () => BuyWashCheckOutController(),
    );
    Get.lazyPut<MyWashesController>(
      () => MyWashesController(),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<TransactionsController>(
      () => TransactionsController(),
    );
    Get.lazyPut<PaymentMethodController>(
      () => PaymentMethodController(),
    );
    Get.lazyPut<AppStorage>(
      () => AppStorage(),
    );
  }
}
