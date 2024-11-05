import 'dart:io';

import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/rounded_common_checkbox.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/pages/create_account/controllers/create_account_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CreateAccount extends GetView<CreateAccountController> {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.createAccountLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Obx(
          () => CommonButton(
            onTap: () => controller.isCreateAccntBtnEnabled.value
                ? controller.onCreateAccntBtnClick()
                : null,
            isEnabled: controller.isCreateAccntBtnEnabled.value,
            text: CoreAppConstants.createAccountLbl,
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
              : Get.mediaQuery.size.height - 160,
          width: double.infinity,
          child: ListView(
            children: [
              //logo
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      _nameWidget(),
                      const SizedBox(height: 15),
                      _lastNameWidget(),
                      const SizedBox(height: 15),
                      _emailWidget(),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              _offersAndPromotionsUI(),
              const SizedBox(
                height: 10,
              ),
              _termsAndPrivacyUI()
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.nameLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        Obx(
          () => CommonTextField(
            controller: controller.nameController,
            hintText: CoreAppConstants.nameLbl,
            prefixIconData: null,
            suffixIconData: controller.nameSuffixIcon.value,
            onSuffixIconTap: null,
            onChangedInput: (value) {
              controller.showOnValidName(controller.nameSuffixIcon, value);
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
              controller.showOnValidName(controller.lastNameSuffixIcon, value);
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
              controller.showOnValidInput();
            },
            errorText: CoreAppConstants.errorEmailTextLbl,
            onFieldValidate: (value) => controller.onEmailFieldValidate(value),
          ),
        ),
      ],
    );
  }

  _offersAndPromotionsUI() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedCommonCheckbox(
            text: CoreAppConstants.emailOffersPromotionsLbl,
            checkedValue: controller.isEmailOffersChecked.value,
            onCheckboxValueChanged: (newValue) {
              controller.isEmailOffersChecked(newValue!);
            },
          ),
          RoundedCommonCheckbox(
            text: CoreAppConstants.smsOffersPromotionsLbl,
            checkedValue: controller.isSmsOffersChecked.value,
            onCheckboxValueChanged: (newValue) {
              controller.isSmsOffersChecked(newValue!);
            },
          ),
        ],
      ),
    );
  }

  _termsAndPrivacyUI() {
    return Container(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(CoreAppConstants.termsAndConditionLbl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.TERMS_AND_CONDITIONS),
                child: const Text(
                  CoreAppConstants.termsAndCondition2Lbl,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Text(
                ' & ',
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.PRIVACY_POLICY),
                child: const Text(
                  CoreAppConstants.privacyPolicyLbl,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
