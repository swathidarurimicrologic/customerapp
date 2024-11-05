import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_list_tile.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/pages/already_member/controllers/already_member_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UpdateMembershipWidget extends GetView<AlreadyMemberController> {
  const UpdateMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.membershipCancelled.value
        ? Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: CommonAppBar(
              titleWidget: const Text(CoreAppConstants.membershipDetailsLbl),
              iconData: Icons.arrow_back_sharp,
              onAppBarMenuPressed: () =>
                  Get.back(), //TODO: change this to Get.back
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
                  height: Get.mediaQuery.size.height,
                  width: double.infinity,
                  child: cancelMembershipWidget()),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: CommonAppBar(
              titleWidget: const Text(CoreAppConstants.membershipDetailsLbl),
              iconData: Icons.arrow_back_sharp,
              onAppBarMenuPressed: () =>
                  Get.back(), //TODO: change this to Get.back
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                    onTap: () {
                      Get.toNamed(Routes.BUY_WASH,
                          arguments: {'status': 'update'});
                    },
                    isEnabled: true,
                    text: CoreAppConstants.changeMembershipLbl,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      controller.showCancelMembershipAlert();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(CoreAppConstants.cancelMembershipLbl,
                            style: Get.textTheme.bodyLarge!.copyWith(
                                color: Get.theme.colorScheme.primary))),
                  ),
                ],
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
                      ? Get.mediaQuery.size.height - 270
                      : Get.mediaQuery.size.height - 220,
                  width: double.infinity,
                  child: cancelMembershipWidget()),
            ),
          ));
  }

  Widget _paymentMethodWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(CoreAppConstants.selectPaymentMethodLbl),
          const SizedBox(height: 5),
          CommonTextField(
            onTap: () => _selectCardOptions(),
            controller: controller.paymentController,
            hintText: CoreAppConstants.selectCardLbl,
            prefixIconData: const Icon(Icons.credit_card),
            suffixIconData: Icon(Icons.arrow_forward_ios,
                color: Get.theme.colorScheme.primary),
            onSuffixIconTap: null,
            canRequestFocus: false,
          ),
        ],
      ),
    );
  }

  _selectCardOptions() {
    return CommonBottomSheet.showBottomSheet(
        isDismissible: true,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        widgetBody: Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          height: Get.mediaQuery.size.height * 0.45,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Text(CoreAppConstants.selectPaymentMethodLbl,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineMedium!
                      .copyWith(color: AppColors.darkGreyColor)),
              const SizedBox(height: 15),
              GetBuilder<AlreadyMemberController>(
                  builder: (controller) => Column(
                        children: List.generate(
                          controller.savedPaymentDetails.length,
                          (index) => Card(
                            color: Get.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    color: AppColors.disableColor)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: RadioListTile(
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                shape: const CircleBorder(),
                                title: Text(
                                  CoreAppConstants.endingInLbl +
                                      controller.fetchLast4CharsOfCard(
                                          controller.savedPaymentDetails[index]
                                              ['card_number']),
                                  style: Get.textTheme.bodySmall,
                                ),
                                value: controller.savedPaymentDetails[index]
                                    ["id"],
                                onChanged: (value) {
                                  controller.updateCheckboxValues(
                                      index, value!);
                                },
                                groupValue: controller.currentGroupId,
                              ),
                            ),
                          ),
                        ),
                      )),
              InkWell(
                onTap: () async {
                  Get.back();
                  var result = await Get.toNamed(Routes.ADD_NEW_CARD);
                  print(result);
                  controller.formatCardDetails(result);
                },
                child: Card(
                    color: Get.theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Get.theme.colorScheme.primary)),
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading:
                          Icon(Icons.add, color: Get.theme.colorScheme.primary),
                      title: Text(
                        CoreAppConstants.addNewPaymentLbl,
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Get.theme.colorScheme.primary),
                      ),
                    )),
              ),
              const SizedBox(height: 15),
              CommonButton(
                onTap: () {
                  Get.back();
                  if (controller.selectedCardValue.isNotEmpty) {
                    controller.paymentController.text =
                        controller.selectedCardValue;
                    controller.prevGroupId = controller.currentGroupId;

                    if (controller.paymentController.text.isNotEmpty &&
                        controller.memberPassController.text.isNotEmpty) {
                      controller.isContinueBtnEnabled(true);
                    }
                  }
                },
                isEnabled: true,
                text: CoreAppConstants.selectLbl,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.back();
                  if (controller.currentGroupId != -1) {
                    if (controller.paymentController.text.isEmpty) {
                      controller.currentGroupId = -1;
                    } else {
                      controller.currentGroupId = controller.prevGroupId;
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(CoreAppConstants.cancelLbl,
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: Get.theme.colorScheme.primary)),
                ),
              )
            ],
          ),
        ));
  }

  cancelMembershipWidget() {
    return Column(
      children: [
        Container(
          color: Get.theme.colorScheme.primary,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
            controller.appStorage.getUserData()['name'],
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.whiteColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _paymentMethodWidget(),
              _qrCodeWidget()
            ],
          ),
        ),
      ],
    );
  }

  _qrCodeWidget() {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(controller.selectedMembershipList['title'].toString()),
            const SizedBox(height: 10),
            Chip(
              backgroundColor: controller.membershipCancelled.value
                  ? Get.theme.colorScheme.error
                  : Get.theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // shadowColor: Colors.transparent,
              side: BorderSide.none,
              label: Text(
                  style: Get.theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.whiteColor),
                  "Renews on ${controller.getDateOnlyFormat(controller.selectedMembershipList['expiry_date'])}"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              height: 150,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: '43770929851162',
              ),
            ),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                    text: 'Member Pass Number: ',
                    style: Get.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.normal)),
                TextSpan(
                    text: controller.selectedMembershipList['member_pass'],
                    style: Get.textTheme.bodyMedium),
              ],
            )),
            const SizedBox(height: 10),
            controller.membershipCancelled.value
                ? const IgnorePointer()
                : const Divider(height: 1),
            controller.membershipCancelled.value
                ? const IgnorePointer()
                : _editNameOrPhoneWidget()
          ],
        ),
      ),
    );
  }

  _editNameOrPhoneWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: CommonOutlineButton(
        onTap: () => Get.toNamed(Routes.EDIT_NAME),
        isEnabled: true,
        text: CoreAppConstants.editNameOrPhoneLbl,
      ),
    );
  }

  _alreadyLinkedWidget(int index) {
    var filteredList = controller.filterActiveCancelMembershipList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: CommonListTile(
        titleText: filteredList[index]['title'].toString(),
        subTitle: Text(filteredList[index]['status'],
            style: Get.theme.textTheme.titleMedium!.copyWith(
                color: filteredList[index]['status'] == 'Canceled'
                    ? AppColors.errorColor
                    : AppColors.darkGreyColor)),
        trailingText: filteredList[index]['status'] == 'Canceled'
            ? CoreAppConstants.viewLbl
            : CoreAppConstants.manageLbl,
        iconData: CoreAppConstants.rotateSquareImgPath,
        onTap: () => {},
      ),
    );
  }
}
