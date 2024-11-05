import 'dart:io';

import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/components/common_alert_dialog.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/buy_wash_checkout_controller.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_card_detail.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanCheckoutWidget extends StatefulWidget {
  const ScanCheckoutWidget({super.key});

  @override
  State<ScanCheckoutWidget> createState() => _ScanCheckoutWidgetState();
}

class _ScanCheckoutWidgetState extends State<ScanCheckoutWidget> {
  late List<dynamic> items;
  var controller = Get.find<BuyWashCheckOutController>();
  var homeController = Get.find<HomeController>();
  var selectedCard;
  late List amount;
  late double redeemValue;

  @override
  void initState() {
    super.initState();
    items = homeController.items;
    if (homeController.items.isNotEmpty) {
      selectedCard =
          homeController.items[homeController.selectedCardIndex.value];
      if (selectedCard != null) {
        amount = selectedCard['amount'].toString().split(".");
      }
      controller.calculateTotalAmount(
          selectedCard['amount'], selectedCard['tax']);
      redeemValue = controller.fetchRedeemValue();
    }

    for (var i = 0; i < controller.savedPaymentDetails.length; i++) {
      if (controller.savedPaymentDetails[i]['is_default']) {
        controller.updateCheckboxValues(
            i, controller.savedPaymentDetails[i]['id']);
        controller.formatCardDetails(
            controller.savedPaymentDetails[i]['card_number']);
        controller.currentGroupId = controller.savedPaymentDetails[i]['id'];
        controller.prevGroupId = controller.currentGroupId;
        controller.isPayBtnEnabled(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(
            titleWidget: const Text(CoreAppConstants.checkoutLbl),
            iconData: Icons.arrow_back_sharp,
            onAppBarMenuPressed: () {
              // Get.back();
              Get.back();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => CommonButton(
                  isEnabled: (controller.isPayBtnEnabled.value ||
                          controller.finalAmount == 0.0)
                      ? true
                      : false,
                  onTap: () {
                    if (homeController.currentNavPage == 'my_wash') {
                      _myWashOptions();
                    } else {
                      _washOptions();
                    }
                  },
                  text: CoreAppConstants.payLbl,
                ),
              ),
              const SizedBox(height: 10),
              (homeController.currentNavPage == 'my_wash')
                  ? const IgnorePointer()
                  : InkWell(
                      onTap: () async {
                        var result = await Get.toNamed(Routes.REDEEM_CODE);
                        if (result != null && result.toString().isNotEmpty) {
                          controller.redeemCodeController.text = result;
                          controller.calculateTotalAmount(
                              selectedCard['amount'], selectedCard['tax']);
                          redeemValue = controller.fetchRedeemValue();

                          setState(() {});
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(CoreAppConstants.redeemCodeLbl,
                              style: Get.textTheme.bodyLarge!.copyWith(
                                  color: Get.theme.colorScheme.primary))),
                    ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
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
              ? Get.mediaQuery.size.height - 250
              : Get.mediaQuery.size.height - 200,
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                  color: Get.theme.colorScheme.primary,
                  padding: const EdgeInsets.all(4),
                  width: double.infinity,
                  child: Text(
                    'Western Av. \n Lane3 - Express',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium!
                        .copyWith(color: AppColors.whiteColor),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(CoreAppConstants.selectPaymentLbl),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CommonTextField(
                        onTap: () => _selectCardOptions(),
                        controller: controller.paymentController,
                        hintText: CoreAppConstants.selectCardLbl,
                        prefixIconData: const Icon(Icons.credit_card,
                            color: AppColors.blackColor),
                        suffixIconData: const Icon(Icons.arrow_forward_ios),
                        onSuffixIconTap: null,
                        canRequestFocus: false,
                        errorText: CoreAppConstants.errorEmailTextLbl,
                      ),
                    ),
                    _serviceWidget(),
                    _promoCodeWidget(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _serviceWidget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.disableColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedCard['title'],
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineLarge!.copyWith(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       (amount.length == 2)
              //           ? RichText(
              //               text: TextSpan(
              //                 children: [
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(0.0, -10.0),
              //                       child: Text(
              //                         '\$',
              //                         style: Get.textTheme.titleMedium!
              //                             .copyWith(
              //                                 color: AppColors.blackColor),
              //                       ),
              //                     ),
              //                   ),
              //                   TextSpan(
              //                       text: amount.first,
              //                       style: Get.textTheme.headlineLarge!
              //                           .copyWith(color: AppColors.blackColor)),
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(0.0, -10.0),
              //                       child: Text(
              //                         amount.last,
              //                         style: Get.textTheme.titleMedium!
              //                             .copyWith(
              //                                 color: AppColors.blackColor),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           : (amount.isNotEmpty && amount.length == 1)
              //               ? RichText(
              //                   text: TextSpan(
              //                   children: [
              //                     WidgetSpan(
              //                       child: Transform.translate(
              //                         offset: const Offset(0.0, -10.0),
              //                         child: Text(
              //                           '\$',
              //                           style: Get.textTheme.titleMedium!
              //                               .copyWith(
              //                                   color: AppColors.blackColor),
              //                         ),
              //                       ),
              //                     ),
              //                     TextSpan(
              //                         text: amount.first,
              //                         style: Get.textTheme.headlineLarge!
              //                             .copyWith(
              //                                 color: AppColors.blackColor)),
              //                   ],
              //                 ))
              //               : const IgnorePointer(),
              //     ],
              //   ),
              // ),
              _keyPointsWidget(),
              const SizedBox(height: 10),
              CommonOutlineButton(
                  onTap: () {
                    Get.toNamed(Routes.UNLIMITED_TERMS);
                  },
                  text: CoreAppConstants.viewUnlimitedTCLbl)
            ],
          ),
        ),
      ),
    );
  }

  _selectPaymentWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.disableColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(CoreAppConstants.promocodeLbl),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                onTap: () async {
                  print('On tap');
                  var result = await Get.toNamed(Routes.REDEEM_CODE);
                  if (result != null && result.toString().isNotEmpty) {
                    controller.redeemCodeController.text = result;
                    redeemValue = controller.fetchRedeemValue();
                    controller.calculateTotalAmount(
                        selectedCard['amount'], selectedCard['tax']);
                    setState(() {});
                  }
                },
                controller: controller.redeemCodeController,
                hintText: CoreAppConstants.promocodeHintLbl,
                suffixIconData: controller.redeemCodeController.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            controller.redeemCodeController.text = '';
                            redeemValue = controller.fetchRedeemValue();
                            controller.calculateTotalAmount(
                                selectedCard['amount'], selectedCard['tax']);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 0,
                            backgroundColor: Get.theme.colorScheme.primary,
                            child: Icon(
                              Icons.close,
                              size: 15,
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      )
                    : const Icon(Icons.arrow_forward_ios),
                onSuffixIconTap: null,
                canRequestFocus: false,
                errorText: CoreAppConstants.errorEmailTextLbl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _promoCodeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.disableColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(CoreAppConstants.promocodeLbl),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                onTap: () async {
                  print('On tap');
                  var result = await Get.toNamed(Routes.REDEEM_CODE);
                  if (result != null && result.toString().isNotEmpty) {
                    controller.redeemCodeController.text = result;
                    redeemValue = controller.fetchRedeemValue();
                    controller.calculateTotalAmount(
                        selectedCard['amount'], selectedCard['tax']);
                    setState(() {});
                  }
                },
                controller: controller.redeemCodeController,
                hintText: CoreAppConstants.promocodeHintLbl,
                suffixIconData: controller.redeemCodeController.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            controller.redeemCodeController.text = '';
                            redeemValue = controller.fetchRedeemValue();
                            controller.calculateTotalAmount(
                                selectedCard['amount'], selectedCard['tax']);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 0,
                            backgroundColor: Get.theme.colorScheme.primary,
                            child: Icon(
                              Icons.close,
                              size: 15,
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      )
                    : const Icon(Icons.arrow_forward_ios),
                onSuffixIconTap: null,
                canRequestFocus: false,
                // isEnabled: false,
                errorText: CoreAppConstants.errorEmailTextLbl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkoutWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.disableColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(CoreAppConstants.serviceLbl),
                        Text(
                            "\$${double.parse(selectedCard['amount'].toString()).toStringAsFixed(2)}"),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(CoreAppConstants.taxLbl),
                        Text(double.parse(
                                selectedCard['tax'].toString().toString())
                            .toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(
                height: 1,
              ),
              const SizedBox(height: 5),
              controller.redeemCodeController.text.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ignore: prefer_interpolation_to_compose_strings
                              Text(
                                "Code ${controller.fetchRedeemCodeLast4Chars()}",
                                style: Get.textTheme.titleMedium!.copyWith(
                                    color: Get.theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text("-$redeemValue",
                                  style: Get.textTheme.titleMedium!.copyWith(
                                      color: Get.theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 1,
                        ),
                      ],
                    )
                  : const IgnorePointer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(CoreAppConstants.totalLbl),
                    Text("\$${controller.finalAmount.toStringAsFixed(2)}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _washOptions() {
    if (controller.isUpdateMembership) {
      CommonAlertDialog().successAlert(
          title: CoreAppConstants.getReadyWashLbl,
          content: CoreAppConstants.washStartInsLbl,
          buttonText: CoreAppConstants.doneLbl,
          onPressed: () {
            CommonAlertDialog().positiveNegativeAlert(
                title: CoreAppConstants.washSavedSuccessLbl,
                content: CoreAppConstants.washSavedLbl,
                positiveButtonText: CoreAppConstants.gotoWashesLbl,
                negativeButtonText: CoreAppConstants.closeBtn,
                onPositiveBtnPressed: () {
                  Get.offAllNamed(Routes.HOME,
                      arguments: {'selected_index': 1});
                },
                onNegativeBtnPressed: () {
                  Get.offAllNamed(Routes.HOME);
                });
          });
    } else {
      CommonAlertDialog().successAlert(
          title: CoreAppConstants.getReadyWashLbl,
          content: CoreAppConstants.washStartInsLbl,
          buttonText: CoreAppConstants.doneLbl,
          onPressed: () {
            CommonAlertDialog().positiveNegativeAlert(
                title: CoreAppConstants.washSavedSuccessLbl,
                content: CoreAppConstants.washSavedLbl,
                positiveButtonText: CoreAppConstants.gotoWashesLbl,
                negativeButtonText: CoreAppConstants.closeBtn,
                onPositiveBtnPressed: () {
                  Get.offAllNamed(Routes.HOME,
                      arguments: {'selected_index': 1});
                },
                onNegativeBtnPressed: () {
                  Get.offAllNamed(Routes.HOME);
                });
          });
    }
    // CommonBottomSheet.showBottomSheet(
    //     isDismissible: true,
    //     widgetBody: Container(
    //       alignment: Alignment.center,
    //       padding:
    //           const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
    //       height: Get.mediaQuery.size.height * 0.3,
    //       child: ListView(
    //         children: [
    //           Center(
    //               child: Image.asset(AppFlavor.defaultAssetPath +
    //                   CoreAppConstants.statusSuccessPath)),
    //           const SizedBox(height: 20),
    //           Text(CoreAppConstants.getReadyWashLbl,
    //               textAlign: TextAlign.center,
    //               style: Get.textTheme.headlineMedium!
    //                   .copyWith(color: AppColors.darkGreyColor)),
    //           const SizedBox(height: 15),
    //           CommonButton(
    //             onTap: () {
    //               Get.back();

    //             },
    //             isEnabled: true,
    //             text: CoreAppConstants.washNowLbl,
    //           ),
    //           const SizedBox(height: 15),
    //           InkWell(
    //             onTap: () {
    //               Get.back();
    //               CommonAlertDialog().positiveNegativeAlert(
    //                   title: CoreAppConstants.washSavedSuccessLbl,
    //                   content: CoreAppConstants.washSavedLbl,
    //                   positiveButtonText: CoreAppConstants.gotoWashesLbl,
    //                   negativeButtonText: CoreAppConstants.closeBtn,
    //                   onPositiveBtnPressed: () {
    //                     Get.back();
    //                     Get.offAllNamed(Routes.HOME);
    //                   },
    //                   onNegativeBtnPressed: () {
    //                     Get.back();
    //                     Get.offAllNamed(Routes.HOME);
    //                   });
    //             },
    //             child: Container(
    //               alignment: Alignment.center,
    //               child: Text(CoreAppConstants.cancelLbl,
    //                   style: Get.textTheme.bodyMedium!
    //                       .copyWith(color: Get.theme.colorScheme.primary)),
    //             ),
    //           )
    //         ],
    //       ),
    //     ));
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
              GetBuilder<BuyWashCheckOutController>(
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
                                          controller
                                              .savedPaymentDetails[index]),
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
                  // Get.back();
                  var result = await Get.toNamed(Routes.ADD_NEW_CARD);
                  print(result);
                  // controller.formatCardDetails(result);
                  controller.isPayBtnEnabled(true);
                  setState(() {});
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
                    controller.isPayBtnEnabled(true);
                    controller.paymentController.text =
                        controller.selectedCardValue;
                    controller.prevGroupId = controller.currentGroupId;
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

  _keyPointsWidget() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: selectedCard['key_points'].length,
        itemBuilder: (context, index) {
          return Row(children: [
            MyBullet(),
            Text(
              selectedCard['key_points'][index],
              style: Get.textTheme.bodySmall,
            )
          ]);
        },
      ),
    );
  }

  void _myWashOptions() {
    CommonBottomSheet.showBottomSheet(
        isDismissible: true,
        widgetBody: Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          height: Get.mediaQuery.size.height * 0.35,
          child: ListView(
            children: [
              Center(
                  child: Image.asset(AppFlavor.defaultAssetPath +
                      CoreAppConstants.statusSuccessPath)),
              Text(CoreAppConstants.getReadyWashLbl,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineMedium!
                      .copyWith(color: AppColors.darkGreyColor)),
              const SizedBox(height: 15),
              Text(CoreAppConstants.washStartInsLbl,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleMedium),
              const SizedBox(height: 15),
              CommonButton(
                onTap: () {
                  Get.back();
                  Get.offAllNamed(Routes.HOME);
                },
                isEnabled: true,
                text: CoreAppConstants.doneLbl,
              ),
            ],
          ),
        ));
  }
}
