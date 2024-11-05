import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedCommonCheckbox extends StatelessWidget {
  final ValueChanged onCheckboxValueChanged;
  final String text;
  final bool checkedValue;
  const RoundedCommonCheckbox(
      {super.key,
      required this.onCheckboxValueChanged,
      required this.text,
      required this.checkedValue});

  @override
  Widget build(BuildContext context) {
    final checkboxTheme = Theme.of(context).checkboxTheme.copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        );
    return Theme(
      data: Theme.of(context).copyWith(checkboxTheme: checkboxTheme),
      child: ListTileTheme(
        horizontalTitleGap: 0,
        child: CheckboxListTile(
          dense: true,
          title: Text(text,
              style: const TextStyle(
                  color: AppColors.darkGreyColor, fontWeight: FontWeight.bold)),
          value: checkedValue,
          onChanged: onCheckboxValueChanged,
          activeColor: AppColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
      ),
    );
  }
}
