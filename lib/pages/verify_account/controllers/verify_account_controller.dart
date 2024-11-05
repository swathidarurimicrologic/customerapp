import 'dart:async';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum VERIFY { SMS, EMAIL }

class VerifyAccountController extends GetxController {
  AppStorage appStorage = Get.find<AppStorage>();
  String maskedPhoneNumber = '';
  RxBool isVerifyAccountEnabled = false.obs;
  RxBool isSendCodeEnabled = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  RxInt secondsRemaining = 60.obs;
  String appBarLbl = CoreAppConstants.verifyAccountLbl;
  String headerLbl = CoreAppConstants.completePwdResetLbl;
  bool isFromCreateUserFlow = false;
  late String phoneNumber;
  bool isUpdate = false;
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();

    phoneNumber = (Get.arguments != null && Get.arguments['contact'] != null)
        ? Get.arguments['contact']
        : null;
    isUpdate = (Get.arguments != null && Get.arguments['update'] != null)
        ? Get.arguments['update']
        : null;
    obscurePhoneNumber(phoneNumber);
  }

  String obscurePhoneNumber(String phoneNumber) {
    // if (phoneNumber.length == 10) {
    // Replace characters from index 5 to 8 with asterisks
    String obscuredPart =
        phoneNumber.substring(5, 9).replaceAll(RegExp(r'.'), '*');
    maskedPhoneNumber =
        phoneNumber.substring(0, 5) + obscuredPart + phoneNumber.substring(10);
    // Concatenate the parts
    return maskedPhoneNumber;
    // }
    //  else {
    //   maskedPhoneNumber = phoneNumber;
    //   return maskedPhoneNumber; // Handle invalid phone numbers
    // }
  }

  validateCode(value) {
    print("Inside validate code    ********** ");
    print(value);

    return (value!.isNotEmpty && value == '123456') ? null : "";
  }

  enableVerifyButton(value) {
    if (value.length == 6) {
      isVerifyAccountEnabled(true);
    } else {
      isVerifyAccountEnabled(false);
    }
  }

  verifyCode() {
    if (formKey.currentState!.validate()) {
      print(appStorage.getUserName());
      if ((appStorage.getUserName() != phoneNumber)) {
        Get.offAndToNamed(Routes.CREATE_ACCOUNT);
      } else {
        if (appStorage.getLocationPermissonGranted() != null) {
          // appStorage.storeUserData(userData)
          homeController.alreadyMember = true;
          Get.offAllNamed(Routes.HOME);
        } else {
          print(appStorage.getUserData().toString());
          homeController.alreadyMember = true;

          Get.offAllNamed(Routes.MAIN_SCREEN);
        }
      }
    } else {
      CommonAlertDialog().errorAlert(
          title: CoreAppConstants.invalidPasscodeLbl,
          content: CoreAppConstants.invalidPasscodeDetailLbl,
          buttonText: CoreAppConstants.closeBtn,
          onPressed: () {
            Get.back();
          });
    }
  }

  showSendCodeDialog() {
    isSendCodeEnabled(false);
    showTimer();
    CommonAlertDialog().successAlert(
        title: CoreAppConstants.newCodeLbl,
        content: CoreAppConstants.newCodeDetailLbl,
        buttonText: CoreAppConstants.doneLbl,
        onPressed: () {
          Get.back();
        });
  }

  void showTimer() {
    secondsRemaining(60);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining--;
      } else {
        isSendCodeEnabled(true);
      }
    });
  }

  checkIfIsUpdate() {
    if (isUpdate) {
      CommonAlertDialog().successAlert(
          title: CoreAppConstants.changesUpdatedLbl,
          content: CoreAppConstants.phoneNumberUpdatedInfo,
          buttonText: CoreAppConstants.doneLbl,
          onPressed: () {
            verifyCode();
          });
    } else {
      verifyCode();
    }
  }
}
