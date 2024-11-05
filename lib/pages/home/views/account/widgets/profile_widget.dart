import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/home/controllers/account_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileWidget extends GetView<AccountController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.profileLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Obx(
          () => CommonButton(
            onTap: () {
              _showAlert();
            },
            isEnabled: controller.isUpdateBtnEnabled.value ? true : false,
            text: CoreAppConstants.updateChangesLbl,
          ),
        ),
      ),
      body: SafeArea(
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
              ? Get.mediaQuery.size.height - 230
              : Get.mediaQuery.size.height - 180,
          width: double.infinity,
          child: ListView(
            children: [
              //logo
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      _firstNameWidget(),
                      const SizedBox(height: 15),
                      _lastNameWidget(),
                      const SizedBox(height: 15),
                      _emailWidget(),
                      const SizedBox(height: 15),
                      _addressWidget(),
                      const SizedBox(height: 25),
                      CommonOutlineButton(
                          isError: true,
                          onTap: () {
                            _showPositiveNegativeAlert();
                          },
                          text: CoreAppConstants.deleteAccountLbl)
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAlert() {
    CommonAlertDialog().successAlert(
        title: CoreAppConstants.changesUpdatedLbl,
        content: CoreAppConstants.changesUpdatedInfoLbl,
        buttonText: CoreAppConstants.continueBtn,
        onPressed: () {
          Get.back();
          Get.back();
        });
  }

  _showPositiveNegativeAlert() {
    CommonAlertDialog().warningAlert(
        title: CoreAppConstants.deleteAccountLbl,
        content: CoreAppConstants.deleteAccountInfoLbl,
        positiveButtonText: CoreAppConstants.deleteAccountLbl,
        negativeButtonText: CoreAppConstants.cancelLbl,
        onPositiveBtnPressed: () {
          Get.back();
          Get.back();
        },
        onNegativeBtnPressed: () {
          Get.back();
        });
  }

  Widget _firstNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.firstNameLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        Obx(
          () => CommonTextField(
            controller: controller.firstNameController,
            hintText: CoreAppConstants.firstNameLbl,
            prefixIconData: null,
            suffixIconData: controller.nameSuffixIcon.value,
            onSuffixIconTap: null,
            onChangedInput: (value) {
              controller.showOnValidName(
                  formKey, controller.nameSuffixIcon, value);
            },
            errorText: CoreAppConstants.errorEmailTextLbl,
          ),
        ),
      ],
    );
  }

  Widget _lastNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.lastNameLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        Obx(
          () => CommonTextField(
            controller: controller.lastNameController,
            hintText: CoreAppConstants.lastNameLbl,
            prefixIconData: null,
            suffixIconData: controller.lastNameSuffixIcon.value,
            onSuffixIconTap: null,
            onChangedInput: (value) {
              controller.showOnValidName(
                  formKey, controller.lastNameSuffixIcon, value);
            },
            errorText: CoreAppConstants.errorEmailTextLbl,
          ),
        ),
      ],
    );
  }

  Widget _emailWidget() {
    //username
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.emailAddressLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        Obx(
          () => CommonTextField(
            controller: controller.emailController,
            hintText: CoreAppConstants.emailAddressLbl,
            prefixIconData: null,
            suffixIconData: controller.emailSuffixIcon.value,
            onSuffixIconTap: null,
            onChangedInput: (value) {
              controller.showOnValidInput(formKey);
            },
            errorText: CoreAppConstants.errorEmailTextLbl,
            onFieldValidate: (value) => controller.onEmailFieldValidate(value),
          ),
        ),
      ],
    );
  }

  Widget _addressWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.addressLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        Obx(
          () => CommonTextField(
            controller: controller.addressController,
            hintText: CoreAppConstants.addressLbl,
            prefixIconData: null,
            suffixIconData: controller.addressSuffixIcon.value,
            onSuffixIconTap: null,
            onChangedInput: (value) {
              controller.showOnValidName(
                  formKey, controller.addressSuffixIcon, value);
            },
            errorText: CoreAppConstants.errorEmailTextLbl,
          ),
        ),
      ],
    );
  }
}
