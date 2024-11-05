import 'package:get/get.dart';

class RedeemWashController extends GetxController {
  var result;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      print(arguments['nav_screen']);
      if (arguments['nav_screen'] != null) {
        print(arguments['nav_screen']);
      }
    }
    super.onInit();
  }
}
