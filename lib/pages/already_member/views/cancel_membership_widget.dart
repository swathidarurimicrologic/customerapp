import 'dart:io';

import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/pages/already_member/controllers/already_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CancelMembershipWidget extends GetView<AlreadyMemberController> {
  const CancelMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.cancelMembershipLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: CommonButton(
          onTap: () {
            controller.showCancelAlert(
                CoreAppConstants.cancellationSuccessLbl,
                CoreAppConstants.cancellationSuccessInfoLbl,
                CoreAppConstants.doneLbl);
          },
          isEnabled: true,
          text: CoreAppConstants.cancelMembershipLbl,
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
                ? MediaQuery.of(context).size.height - 230
                : MediaQuery.of(context).size.height - 160,
            width: double.infinity,
            child: cancelMembershipWidget()),
      ),
    );
  }

  cancelMembershipWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Get.theme.colorScheme.primary,
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: CoreAppConstants.membershipActiveLbl,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.whiteColor,
                      )),
                  TextSpan(
                      text: controller.getDateOnlyFormat(
                          controller.selectedMembershipList['expiry_date']),
                      style: Get.textTheme.bodyMedium!
                          .copyWith(color: AppColors.whiteColor)),
                ],
              )),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            CoreAppConstants.letusKnowInfoLbl,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.cancellationReasonList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Divider(
                  height: 0.5,
                ),
                Obx(
                  () => ListTile(
                    onTap: () {
                      controller.selectedIndex(index);
                    },
                    title: Text(
                      controller.cancellationReasonList[index],
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: ((controller.selectedIndex.value == index) &&
                                  controller.selectedIndex.value != 100)
                              ? AppColors.primaryColor
                              : AppColors.darkGreyColor),
                    ),
                  ),
                ),
                (index == controller.cancellationReasonList.length - 1)
                    ? const Divider(
                        height: 0.5,
                      )
                    : const IgnorePointer()
              ],
            );
          },
        ),
      ],
    );
  }
}
