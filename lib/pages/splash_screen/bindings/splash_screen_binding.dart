import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/pages/splash_screen/controllers/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
    Get.lazyPut<AppStorage>(
      () => AppStorage(),
    );
  }
}
