import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isEnabled;
  final ButtonStyle? btnStyle;
  const CommonButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isEnabled = false,
      this.btnStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: btnStyle,
      onPressed: isEnabled ? onTap : null,
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
