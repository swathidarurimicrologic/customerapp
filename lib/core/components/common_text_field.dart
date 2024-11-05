import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final bool canRequestFocus;
  final String hintText;
  final bool? obscureText;
  final AutovalidateMode autovalidateMode;
  final Icon? prefixIconData;
  final Widget? suffixIconData;
  final GestureTapCallback? onSuffixIconTap;
  final TextInputType? keyboardType;
  final dynamic inputFormatters;
  final dynamic inputKey;
  final dynamic onSubmitted;
  final dynamic onChangedInput;
  final dynamic onSavedInput;
  final dynamic onFieldSubmitted;
  final String? errorText;
  final bool isValidated;
  final bool isEnabled;
  final FormFieldValidator<dynamic>? onFieldValidate;
  final GestureTapCallback? onTap;
  const CommonTextField(
      {super.key,
      this.inputKey,
      this.onTap,
      this.autoFocus = false,
      this.canRequestFocus = true,
      required this.controller,
      required this.hintText,
      this.isEnabled = true,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.prefixIconData,
      this.suffixIconData,
      this.onSuffixIconTap,
      this.onFieldSubmitted,
      this.keyboardType,
      this.inputFormatters,
      this.onSubmitted,
      this.onChangedInput,
      this.onSavedInput,
      this.errorText,
      this.onFieldValidate,
      this.isValidated = false});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: widget.inputKey,
        onTap: widget.onTap,
        autofocus: widget.autoFocus,
        canRequestFocus: widget.canRequestFocus,
        autocorrect: false,
        controller: widget.controller,
        obscureText: widget.obscureText!,
        style: const TextStyle(color: AppColors.darkGreyColor),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        autovalidateMode: widget.autovalidateMode,
        onEditingComplete: widget.onSubmitted,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChangedInput,
        onSaved: widget.onSavedInput,
        decoration: InputDecoration(
          isDense: true,
          enabled: widget.isEnabled,
          prefixIcon:
              (widget.prefixIconData != null) ? widget.prefixIconData : null,
          suffixIcon: ((widget.suffixIconData != null))
              ? InkWell(
                  onTap: widget.onSuffixIconTap, child: widget.suffixIconData)
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.errorColor,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade300,
          hintText: widget.hintText,
          errorMaxLines: 1,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        ),
        validator: widget.onFieldValidate);
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? CoreAppConstants.errorEmailInValid
        : null;
  }
}
