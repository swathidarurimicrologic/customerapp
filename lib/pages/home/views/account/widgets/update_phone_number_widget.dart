import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/login/controllers/login_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UpdatePhoneNumberWidget extends GetView<LoginController> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  UpdatePhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.phoneNumberLbl),
        iconData: Icons.arrow_back_sharp,

        onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Obx(
          () => CommonButton(
            onTap: () =>
                controller.isLoginBtnEnabled.value ? handleLogin() : null,
            isEnabled: controller.isLoginBtnEnabled.value,
            text: CoreAppConstants.nextLbl,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
                top: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
              ),
            ),
            height: Platform.isIOS
                ? MediaQuery.of(context).size.height - 230
                : Get.mediaQuery.size.height - 160,
            width: double.infinity,
            // color: AppColors.scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //username

                        const Text(
                          CoreAppConstants.updatePhoneNumberText,
                          style: TextStyle(
                              color: AppColors.darkGreyColor, fontSize: 16),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(Routes.CONTACT_DETAILS),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(CoreAppConstants.countryLbl),
                                    const SizedBox(height: 5),
                                    CommonTextField(
                                      isEnabled: false,
                                      keyboardType: TextInputType.number,
                                      controller:
                                          controller.phoneCodeController,
                                      hintText: '',
                                      suffixIconData:
                                          const Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Obx(
                                () => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          CoreAppConstants.phoneNumberLbl),
                                      const SizedBox(height: 5),
                                      CommonTextField(
                                        controller:
                                            controller.phoneNumberController,
                                        keyboardType: TextInputType.phone,
                                        autovalidateMode:
                                            AutovalidateMode.onUnfocus,
                                        inputFormatters: <TextInputFormatter>[
                                          // FilteringTextInputFormatter
                                          //     .digitsOnly,
                                          MaskedInputFormatter('(###) ###-####')
                                          // PhoneInputFormatter()
                                        ],
                                        hintText:
                                            CoreAppConstants.phoneNumberLbl,
                                        prefixIconData: null,
                                        suffixIconData: controller
                                            .phoneNumberSuffixIcon.value,
                                        onSuffixIconTap: null,
                                        onChangedInput: (value) {
                                          showOnValidPhoneNumber();
                                        },
                                        errorText:
                                            CoreAppConstants.errorEmailTextLbl,
                                        onFieldValidate: (value) => controller
                                            .onPhoneNumberFieldValidate(value),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //password
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      Get.toNamed(Routes.VERIFY_ACCOUNT, arguments: {
        'contact': controller.phoneNumberController.text,
        'update': true
      });
    } else {
      CommonAlertDialog().errorAlert(
          title: CoreAppConstants.errorText,
          content: CoreAppConstants.loginErrorText,
          buttonText: CoreAppConstants.closeBtn,
          onPressed: () {
            Get.back(closeOverlays: true);
          });
    }
  }

  dynamic isButtonEnabled() {
    if ((controller.phoneNumberController.text.isEmpty) ||
        (loginFormKey.currentState != null &&
            !loginFormKey.currentState!.validate())) {
      controller.isLoginBtnEnabled(false);
    } else {
      controller.isLoginBtnEnabled(true);
    }
    return null;
  }

  showOnValidPhoneNumber() {
    isButtonEnabled();
    String phoneNumber =
        controller.phoneNumberController.text.toString().replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");

    phoneNumber = phoneNumber.trim();

    print(phoneNumber);
    if (phoneNumber.isNotEmpty) {
      if (controller.validatePhoneNumber(phoneNumber) == null) {
        controller.phoneNumberSuffixIcon(
            const Icon(Icons.check_circle, color: AppColors.greenColor));
      } else {
        controller.phoneNumberSuffixIcon(
            const Icon(Icons.error, color: AppColors.errorColor));
      }
      return controller.phoneNumberSuffixIcon.value;
    } else if (controller.phoneNumberController.text.isEmpty) {
      controller.phoneNumberSuffixIcon(const Icon(null));
    }
  }
}
