import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final appStorage = Get.find<AppStorage>();
  RxBool isFromAccountTab = false.obs;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      isFromAccountTab(arguments['is_from_account_tab']);
    }
    super.onInit();
  }
}
