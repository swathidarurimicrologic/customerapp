import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class CommonErrorButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isEnabled;
  // final Color buttonColor;
  final TextStyle btnTextStyle;
  const CommonErrorButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isEnabled = false,
      // this.buttonColor = Get.buttonTheme!.buttonColor,
      this.btnTextStyle =
          const TextStyle(color: AppColors.whiteColor, fontSize: 16)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      style: Get.theme.elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStatePropertyAll(
              Get.theme.colorScheme.error.withOpacity(0.8))),
      child: SizedBox(
        height: 50,
        // decoration: BoxDecoration(
        //     // color: buttonColor,
        //     borderRadius: BorderRadius.circular(25.0),
        //     border: isEnabled
        //         ? Border.all(color: AppColors.primaryColor)
        //         : Border.all(color: AppColors.disableButtonColor)),
        child: Center(
          child: Text(
            text,
            // style: btnTextStyle,
          ),
        ),
      ),
    );
  }
}
