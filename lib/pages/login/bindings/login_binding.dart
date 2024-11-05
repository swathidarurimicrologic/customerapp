import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/login/controllers/login_controller.dart';
import 'package:customer_app/pages/login/providers/login_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppStorage());
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<LoginService>(() => LoginService());
  }
}
