import 'dart:io';

import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/pages/verify_account/controllers/verify_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyAccount extends GetView<VerifyAccountController> {
  const VerifyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
          titleWidget: Text(controller.appBarLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () {
            Get.back();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Obx(
          () => CommonButton(
            onTap: () => controller.isVerifyAccountEnabled.value
                ? controller.checkIfIsUpdate()
                : null,
            isEnabled: controller.isVerifyAccountEnabled.value,
            text: CoreAppConstants.verifyLbl,
          ),
        ),
      ),
      body: Container(
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
        alignment: Alignment.topLeft,
        height: Platform.isIOS
            ? Get.mediaQuery.size.height - 230
            : Get.mediaQuery.size.height - 160,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.headerLbl,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      style: TextStyle(color: AppColors.darkGreyColor),
                      text: CoreAppConstants.verifyAccountDetailLbl,
                    ),
                    TextSpan(
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                      text: controller.maskedPhoneNumber,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: controller.formKey,
                child: Pinput(
                  length: 6,
                  showCursor: true,
                  pinAnimationType: PinAnimationType.slide,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  errorText: '',
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.disableColor)),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    height: 60,
                    width: 60,
                  ),
                  focusedPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteColor),
                  ),
                  errorPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.errorColor),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteColor),
                  ),
                  validator: (value) => controller.validateCode(value),
                  onCompleted: (pin) {
                    debugPrint('****************************: $pin');
                  },
                  onSubmitted: (pin) {
                    debugPrint('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^: $pin');
                  },
                  errorBuilder: (errorText, pin) {
                    debugPrint('########################: $pin');
                    return const IgnorePointer();
                  },
                  onChanged: (value) {
                    controller.enableVerifyButton(value);
                  },
                ),
              ),
              const SizedBox(height: 10),
              _resendCodeLink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _resendCodeLink() {
    return Obx(
      () => SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonOutlineButton(
            onTap: () => controller.isSendCodeEnabled.value
                ? controller.showSendCodeDialog()
                : false,
            isEnabled: controller.isSendCodeEnabled.value,
            text: controller.isSendCodeEnabled.value
                ? CoreAppConstants.resendCode
                : "${CoreAppConstants.resendCodeTimerLbl} in ${controller.secondsRemaining.value} seconds",
          ),
        ),
      ),
    );
  }
}
