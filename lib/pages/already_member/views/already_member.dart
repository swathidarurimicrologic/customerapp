import 'dart:io';

import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_list_tile.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/already_member/controllers/already_member_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AlreadyMemberWidget extends GetView<AlreadyMemberController> {
  const AlreadyMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: controller.isMembershipLinked
            ? const Text(CoreAppConstants.membershipDetailsLbl)
            : const Text(CoreAppConstants.linkMembershipLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !controller.isMembershipLinked
          ? Obx(
              () => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: CommonButton(
                  onTap: () {
                    _showAlert();
                  },
                  isEnabled: controller.isContinueBtnEnabled.value,
                  text: CoreAppConstants.nextLbl,
                ),
              ),
            )
          : const IgnorePointer(),
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
            height: controller.isMembershipLinked
                ? Get.mediaQuery.size.height - 50
                : Platform.isIOS
                    ? Get.mediaQuery.size.height - 220
                    : Get.mediaQuery.size.height - 160,
            width: double.infinity,
            child: controller.isMembershipLinked
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          controller.filterActiveCancelMembershipList().length,
                      itemBuilder: (context, index) {
                        return _alreadyLinkedWidget(index);
                      },
                    ),
                  )
                : _linkMembershipWidget()),
      ),
    );
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

  Widget _memberPassWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          CoreAppConstants.memberPassLbl,
          style: TextStyle(color: AppColors.darkGreyColor),
        ),
        const SizedBox(height: 5),
        CommonTextField(
          onTap: () async {
            controller.homeController.currentNavPage = 'already_member';
            var result = await Get.toNamed(Routes.SCAN_CODE);
            if (result != null) {
              controller.memberPassController.text = result;
            }
            if (controller.paymentController.text.isNotEmpty &&
                controller.memberPassController.text.isNotEmpty) {
              controller.isContinueBtnEnabled(true);
            }
          },
          canRequestFocus: false,
          controller: controller.memberPassController,
          hintText: CoreAppConstants.digitCode,
          prefixIconData: null,
          suffixIconData: Icon(Icons.camera_enhance_sharp,
              color: Get.theme.colorScheme.primary),
          onSuffixIconTap: null,
          errorText: CoreAppConstants.errorEmailTextLbl,
        ),
      ],
    );
  }

  _memberShipInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.disableColor)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Get.theme.colorScheme.primary),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(CoreAppConstants.whereCanIFindLbl),
                        ),
                      ],
                    ),
                    const Text(CoreAppConstants.whereCanIFindInfoLbl),
                    const SizedBox(height: 10),
                    Card(
                      color: AppColors.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: AppColors.disableColor)),
                      child: Image.asset(AppFlavor.defaultAssetPath +
                          CoreAppConstants.membershipImage),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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

  _showAlert() {
    CommonAlertDialog().successAlert(
        title: CoreAppConstants.membershipLinkedLbl,
        content: CoreAppConstants.membershipLinkedInfoLbl,
        buttonText: CoreAppConstants.doneLbl,
        onPressed: () {
          Get.back();
          Get.offAllNamed(Routes.HOME);
          controller.appStorage
              .storeMembershipDetails(controller.savedPaymentDetails[0]);
        });
  }

  _linkMembershipWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _memberShipInfoWidget(),
          const SizedBox(height: 10),
          _memberPassWidget(),
          const SizedBox(height: 20),
          _paymentMethodWidget()
        ],
      ),
    );
  }

  // premiumMemberWidget() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const SizedBox(height: 20),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Text(CoreAppConstants.myMembershipsLbl,
  //             style: Get.textTheme.titleMedium),
  //       ),
  //       const SizedBox(height: 10),
  //       CommonListTile(
  //         titleText: 'Platinum Full Service',
  //         subTitleText: 'Active',
  //         trailingText: CoreAppConstants.manageLbl,
  //         iconData: CoreAppConstants.rotateSquareImgPath,
  //         onTap: () => {redeemCode()},
  //       ),
  //     ],
  //   );
  // }

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
        onTap: () {
          controller.saveMembershipDetails(filteredList[index]);
          Get.toNamed(Routes.UPDATE_MEMBERSHIP);
        },
      ),
    );
  }
}
