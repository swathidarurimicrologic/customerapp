import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class CommonBottomSheet {
  static showBottomSheet(
      {widgetBody, isDismissible, backgroundColor = AppColors.whiteColor}) {
    Future.delayed(Duration.zero, () async {
      await Get.bottomSheet(
          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          //   child: widgetBody,
          // ),
          widgetBody,
          backgroundColor: backgroundColor,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            side: BorderSide(style: BorderStyle.solid),
          ),
          enableDrag: false,
          isDismissible:
              isDismissible ?? false //default value is true. try false//
          );
    });
  }
}
