import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonCheckbox extends StatelessWidget {
  final ValueChanged onCheckboxValueChanged;
  final String text;
  final bool checkedValue;
  const CommonCheckbox(
      {super.key,
      required this.onCheckboxValueChanged,
      required this.text,
      required this.checkedValue});

  @override
  Widget build(BuildContext context) {
    final checkboxTheme = Theme.of(context).checkboxTheme.copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        );
    return Theme(
      data: Theme.of(context).copyWith(checkboxTheme: checkboxTheme),
      child: ListTileTheme(
        horizontalTitleGap: 0,
        child: CheckboxListTile(
          dense: true,
          title: Text(text, style: Get.textTheme.bodyLarge),
          value: checkedValue,
          onChanged: onCheckboxValueChanged,
          activeColor: Get.theme.colorScheme.primary,
          side: WidgetStateBorderSide.resolveWith(
            (states) =>
                const BorderSide(width: 1.0, color: AppColors.checkboxColor),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
      ),
    );
  }
}
