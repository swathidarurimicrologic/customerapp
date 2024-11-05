import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class CommonOutlineButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isEnabled;
  final bool isError;
  const CommonOutlineButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isEnabled = true,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isEnabled ? onTap : null,
      style: ButtonStyle(
          textStyle: isError
              ? WidgetStateProperty.all(TextStyle(
                  fontSize: 16,
                  foreground: Paint()..color = AppColors.errorColor))
              : WidgetStateProperty.all(TextStyle(
                  fontSize: 16,
                  foreground: Paint()..color = Get.theme.colorScheme.primary)),
          side: WidgetStateProperty.all(BorderSide(
              color: isError
                  ? AppColors.errorColor
                  : Get.theme.colorScheme.primary,
              width: 1.0,
              style: BorderStyle.solid))),
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
