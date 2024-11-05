import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final dynamic nameSuffixIcon = const Icon(null).obs;
  final dynamic lastNameSuffixIcon = const Icon(null).obs;
  final dynamic addressSuffixIcon = const Icon(null).obs;

  final dynamic emailSuffixIcon = const Icon(null).obs;
  RxBool isUpdateBtnEnabled = false.obs;

  showOnValidName(dynamic formKey, dynamic suffixIcon, String? value) {
    isButtonEnabled(formKey);
    if (value!.trim().isNotEmpty) {
      suffixIcon(const Icon(Icons.check_circle, color: AppColors.greenColor));
    } else {
      suffixIcon(const Icon(null));
    }
    return suffixIcon.value;
  }

  dynamic isButtonEnabled(formKey) {
    if ((firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty ||
            emailController.text.isEmpty ||
            addressController.text.isEmpty) ||
        (formKey.currentState != null && !formKey.currentState!.validate())) {
      isUpdateBtnEnabled(false);
    } else {
      isUpdateBtnEnabled(true);
    }
    return null;
  }

  showOnValidInput(formKey) {
    isButtonEnabled(formKey);
    if (emailController.text.trim().isNotEmpty) {
      if (_validateEmail(emailController.text) == null) {
        emailSuffixIcon(
            const Icon(Icons.check_circle, color: AppColors.greenColor));
      } else {
        emailSuffixIcon(const Icon(Icons.error, color: AppColors.errorColor));
      }
      return emailSuffixIcon.value;
    } else if (emailController.text.isEmpty) {
      emailSuffixIcon(const Icon(null));
    }
  }

  String? _validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return ((value!.isNotEmpty && !regex.hasMatch(value)) || value.isEmpty)
        ? 'Enter a valid email address'
        : null;
  }

  onEmailFieldValidate(String value) {
    if (_validateEmail(value) != null) {
      return CoreAppConstants.errorEmailInValid;
    }
    return null;
  }
}
