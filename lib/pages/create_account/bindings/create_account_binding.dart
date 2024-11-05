import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/pages/create_account/controllers/create_account_controller.dart';
import 'package:get/get.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(),
    );

    Get.lazyPut<AppStorage>(
      () => AppStorage(),
    );
  }
}
