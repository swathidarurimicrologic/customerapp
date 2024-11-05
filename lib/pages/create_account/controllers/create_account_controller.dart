import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/login/controllers/login_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppStorage appStorage = Get.find<AppStorage>();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isEmailPromotionsChecked = false.obs;
  RxBool isSmsPromotionsChecked = false.obs;
  RxBool isCreateAccntBtnEnabled = false.obs;
  final RxBool isPassword = true.obs;
  final RxBool isValidPwd = false.obs;
  final RxBool isEmailOffersChecked = false.obs;
  final RxBool isSmsOffersChecked = false.obs;

  final dynamic nameSuffixIcon = const Icon(null).obs;
  final dynamic lastNameSuffixIcon = const Icon(null).obs;
  final dynamic phoneNumberSuffixIcon = const Icon(null).obs;
  final dynamic emailSuffixIcon = const Icon(null).obs;
  final loginController = Get.find<LoginController>();
  final homeController = Get.find<HomeController>();

  onCreateAccntBtnClick() async {
    await appStorage.storeUserData({
      "name": nameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "contact": loginController.phoneNumberController.text,
      "isEmailSubscribed": isEmailPromotionsChecked.value,
      "isTextSubscribed": isSmsOffersChecked.value,
      "token": ''
    });
    await appStorage.storeUserName(loginController.phoneNumberController.text);
    if (appStorage.getLocationPermissonGranted() != null) {
      homeController.alreadyMember = true;
      Get.toNamed(Routes.HOME);
    } else {
      homeController.alreadyMember = true;
      Get.toNamed(Routes.MAIN_SCREEN);
    }
    // Get.toNamed(Routxes.VERIFICATION_METHOD);
  }

  showOnValidPassword(String? value) {
    if (value!.isNotEmpty) {}
  }

  showOnValidName(dynamic suffixIcon, String? value) {
    isButtonEnabled();
    if (value!.trim().isNotEmpty) {
      suffixIcon(const Icon(Icons.check_circle, color: AppColors.greenColor));
    } else {
      suffixIcon(const Icon(null));
    }
    return suffixIcon.value;
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

  String? _validatePhoneNumber(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);
    return ((value!.isNotEmpty && !regex.hasMatch(value)) || value.isEmpty)
        ? CoreAppConstants.invalidPhoneNumberLbl
        : null;
  }

  dynamic isButtonEnabled() {
    if ((nameController.text.isEmpty ||
            lastNameController.text.isEmpty ||
            emailController.text.isEmpty) ||
        (formKey.currentState != null && !formKey.currentState!.validate())) {
      isCreateAccntBtnEnabled(false);
    } else {
      isCreateAccntBtnEnabled(true);
    }
    return null;
  }

  void togglePasswordView() {
    isPassword(!isPassword.value);
  }

  onPhoneNumberFieldValidate(String value) {
    String phoneNumber = value.replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");

    phoneNumber = phoneNumber.trim();
    if (_validatePhoneNumber(phoneNumber) != null) {
      return CoreAppConstants.invalidPhoneNumberLbl;
    }
    return null;
  }

  void onEmailOffersRadioSelected(value) {
    print("valuee**************" + value);
    isEmailOffersChecked(value);
  }

  void onSmsOffersRadioSelected(value) {
    isSmsOffersChecked(value);
  }

  showOnValidInput() {
    isButtonEnabled();
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

  onEmailFieldValidate(String value) {
    if (_validateEmail(value) != null) {
      return CoreAppConstants.errorEmailInValid;
    }
    return null;
  }
}
