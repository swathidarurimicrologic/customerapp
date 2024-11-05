import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/verify_account/controllers/verify_account_controller.dart';
import 'package:get/get.dart';

class VerifyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyAccountController>(
      () => VerifyAccountController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
