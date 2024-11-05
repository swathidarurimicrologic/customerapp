import 'dart:io';

import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/components/rounded_common_checkbox.dart';
import 'package:customer_app/pages/home/controllers/add_new_card_controller.dart';
import 'package:customer_app/pages/home/views/buy/card_utils.dart';
import 'package:customer_app/pages/home/views/buy/input_formatters.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddCreditCardInfoWidget extends GetView<AddNewCardController> {
  const AddCreditCardInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.creditCardDetailsLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: controller.isEditCard
          ? Container(
              height: 120,
              alignment: Alignment.bottomCenter,
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: CommonButton(
                      onTap: () {
                        _showConfirmChangesAlert();
                      },
                      isEnabled: true,
                      text: CoreAppConstants.saveChangesLbl,
                    ),
                  ),
                  CommonOutlineButton(
                    isError: true,
                    onTap: () {
                      _showDeleteCardAlert();
                    },
                    isEnabled: true,
                    text: CoreAppConstants.deleteCardLbl,
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Obx(
                () => CommonButton(
                  onTap: () => controller.isAddCardEnabled.value
                      ? controller.onAddCardClicked()
                      : null,
                  isEnabled: controller.isAddCardEnabled.value,
                  text: CoreAppConstants.addCardLbl,
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
          height: controller.isEditCard
              ? Platform.isIOS
                  ? Get.mediaQuery.size.height - 280
                  : Get.mediaQuery.size.height - 210
              : Platform.isIOS
                  ? Get.mediaQuery.size.height - 210
                  : Get.mediaQuery.size.height - 160,
          width: double.infinity,
          child: ListView(
            children: [
              //logo
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: controller.addCreditCardInfoFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      _cardHolderNameWidget(),
                      const SizedBox(height: 15),
                      _cardNumberWidget(),
                      const SizedBox(height: 15),
                      _expiryDateWidget(),
                      const SizedBox(height: 15),
                      _cvvWidget()
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Obx(
                () => RoundedCommonCheckbox(
                  text: CoreAppConstants.setAsDefaultLbl,
                  checkedValue: controller.isDefaultSelected.value,
                  onCheckboxValueChanged: (newValue) {
                    controller.isDefaultSelected(newValue!);
                  },
                ),
              ),
              const SizedBox(height: 10),
              _termsAndPrivacyUI()
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardHolderNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.cardHolderNameLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        CommonTextField(
          controller: controller.cardNameController,
          hintText: CoreAppConstants.nameOncardHintLbl,
          suffixIconData: null,
          errorText: CoreAppConstants.errorEmailTextLbl,
          onFieldValidate: (value) {
            var result;
            if (value == null || value.isEmpty) {
              result = 'Card Holder Name is empty';
            }
            return result;
          },
        ),
      ],
    );
  }

  Widget _cardNumberWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.cardNumberLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        CommonTextField(
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberInputFormatter()
            ],
            controller: controller.cardNumberController,
            hintText: CoreAppConstants.cardNumberHintLbl,
            onSuffixIconTap: null,
            errorText: CoreAppConstants.errorCardNumberLbl,
            onFieldValidate: (value) {
              var result = CardUtils.validateCardNum(value);
              return result;
            }),
      ],
    );
  }

  Widget _expiryDateWidget() {
    //username
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.expDateLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        CommonTextField(
          controller: controller.cardExpiryController,
          hintText: CoreAppConstants.expiryDateHintLbl,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
            CardMonthInputFormatter()
          ],
          prefixIconData: null,
          suffixIconData: null,
          onSuffixIconTap: null,
          errorText: CoreAppConstants.errorEmailTextLbl,
          onFieldValidate: (value) {
            var result = CardUtils.validateDate(value);
            return result;
          },
        ),
      ],
    );
  }

  Widget _cvvWidget() {
    //username
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.cvvLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        CommonTextField(
          controller: controller.cvvController,
          hintText: CoreAppConstants.cvvHintLbl,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          prefixIconData: null,
          suffixIconData: null,
          onSuffixIconTap: null,
          errorText: CoreAppConstants.errorEmailTextLbl,
          onFieldValidate: (value) {
            var result = CardUtils.validateCVV(value);
            controller.isButtonEnabled();
            return result;
          },
        ),
      ],
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

  _showConfirmChangesAlert() {
    CommonAlertDialog().positiveNegativeAlert(
        title: CoreAppConstants.confirmChangesLbl,
        content: CoreAppConstants.confirmChangesInfoLbl,
        positiveButtonText: CoreAppConstants.continueBtn,
        negativeButtonText: CoreAppConstants.cancelLbl,
        onPositiveBtnPressed: () {
          Get.back();
          _showSuccessAlert();
        },
        onNegativeBtnPressed: () {
          Get.back();
        });
  }

  _showSuccessAlert() {
    CommonAlertDialog().successAlert(
        title: CoreAppConstants.changesUpdatedLbl,
        content: CoreAppConstants.changesSavedInfoLbl,
        buttonText: CoreAppConstants.continueBtn,
        onPressed: () {
          Get.back();
          Get.back();
        });
  }

  _showDeleteCardAlert() {
    CommonAlertDialog().warningAlert(
        title: CoreAppConstants.deleteCardLbl,
        content: CoreAppConstants.deleteCardInfoLbl,
        positiveButtonText: CoreAppConstants.deleteLbl,
        negativeButtonText: CoreAppConstants.cancelLbl,
        onPositiveBtnPressed: () {
          Get.back();
          Get.back();
        },
        onNegativeBtnPressed: () {
          Get.back();
        });
  }
}
