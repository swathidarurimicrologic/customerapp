import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_error_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:get/get.dart';

class CommonAlertDialog {
  void successAlert(
      {String? title,
      String? content,
      String? buttonText,
      VoidCallback? onPressed}) {
    final style = Get.theme.textTheme.titleLarge;
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppFlavor.defaultAssetPath +
                CoreAppConstants.statusSuccessPath),
            const SizedBox(height: 10),
            Text(title!, style: style, textAlign: TextAlign.center),
          ],
        ),
        content: Text(
          content!,
          style: Get.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        actions: [
          CommonButton(
            onTap: onPressed,
            text: buttonText!,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  void errorAlert(
      {String? title,
      String? content,
      String? buttonText,
      VoidCallback? onPressed}) {
    final style = Get.theme.textTheme.titleLarge;
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Column(
          children: [
            Image.asset(
                AppFlavor.defaultAssetPath + CoreAppConstants.statusErrorPath),
            const SizedBox(height: 10),
            Text(title!, style: style),
          ],
        ),
        content: Text(
          content!,
          textAlign: TextAlign.center,
          style: Get.textTheme.titleMedium,
        ),
        actions: [
          Container(
            height: 50,
            alignment: Alignment.center,
            child: CommonErrorButton(
              onTap: onPressed,
              text: buttonText!,
              isEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

  void positiveNegativeAlert(
      {String? title,
      String? content,
      String? positiveButtonText,
      String? negativeButtonText,
      VoidCallback? onPositiveBtnPressed,
      VoidCallback? onNegativeBtnPressed}) {
    final style = Get.theme.textTheme.titleLarge;
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppFlavor.defaultAssetPath +
                    CoreAppConstants.statusSuccessPath),
                const SizedBox(height: 10),
                Text(title!, style: style, textAlign: TextAlign.center),
              ],
            ),
            content: Text(
              content!,
              style: Get.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              CommonButton(
                onTap: onPositiveBtnPressed,
                text: positiveButtonText!,
                isEnabled: true,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: onNegativeBtnPressed,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(negativeButtonText!,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Get.theme.colorScheme.primary))),
              )
            ]));
  }

  void warningAlert(
      {String? title,
      String? content,
      String? positiveButtonText,
      String? negativeButtonText,
      VoidCallback? onPositiveBtnPressed,
      VoidCallback? onNegativeBtnPressed}) {
    final style = Get.theme.textTheme.titleLarge;
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppFlavor.defaultAssetPath + CoreAppConstants.warningIcon,
                  width: 75,
                  height: 75,
                ),
                const SizedBox(height: 10),
                Text(title!, style: style, textAlign: TextAlign.center),
              ],
            ),
            content: Text(
              content!,
              style: Get.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              CommonErrorButton(
                onTap: onPositiveBtnPressed,
                text: positiveButtonText!,
                isEnabled: true,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: onNegativeBtnPressed,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(negativeButtonText!,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Get.theme.colorScheme.primary))),
              )
            ]));
  }
}
