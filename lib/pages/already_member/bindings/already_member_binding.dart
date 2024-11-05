import 'package:customer_app/pages/already_member/controllers/already_member_controller.dart';
import 'package:get/get.dart';

class AlreadyMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlreadyMemberController>(
      () => AlreadyMemberController(),
    );
  }
}
