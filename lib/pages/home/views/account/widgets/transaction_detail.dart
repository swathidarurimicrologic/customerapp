import 'dart:io';

import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/pages/home/controllers/transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailWidget extends GetView<TransactionsController> {
  const TransactionDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBar(
            titleWidget: const Text(CoreAppConstants.orderDetailsLbl),
            iconData: Icons.arrow_back_sharp,
            onAppBarMenuPressed: () {
              Get.back();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                child: CommonButton(
                  onTap: () {},
                  isEnabled: true,
                  text: CoreAppConstants.emailReceiptLbl,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    child: Text(CoreAppConstants.printLbl,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Get.theme.colorScheme.primary))),
              ),
            ],
          ),
        ),
        body: widgetBody());
  }

  widgetBody() {
    var selectedCard = controller.isCurrentMonthWash
        ? controller.currentMonthWashList[
            controller.selectedCurrentMonthWashIndex.value]
        : controller
            .prevMonthWashList[controller.selectedPrevMonthWashIndex.value];
    return Container(
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
      padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
      height: Platform.isIOS
          ? Get.mediaQuery.size.height - 270
          : Get.mediaQuery.size.height - 200,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          _transactionInfoWidget(selectedCard),
          const SizedBox(height: 10),
          _cardInfoWidget(selectedCard),
          const SizedBox(height: 10),
          _paymentInfoWidget(selectedCard),
        ],
      ),
    );
  }

  _transactionInfoWidget(selectedCard) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.disableColor)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(CoreAppConstants.transactionIdLbl),
                Text(selectedCard['payment_info'][0]['transaction_id']
                    .toString()),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(CoreAppConstants.purchaseDateLbl),
                Text(controller.getDateOnlyFormat(
                    selectedCard['purchase_date'].toString())),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(CoreAppConstants.expiryDateLbl),
                Text(controller
                    .getDateOnlyFormat(selectedCard['expiry_date'].toString())),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  _paymentInfoWidget(selectedCard) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.disableColor)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(CoreAppConstants.serviceLbl),
                Text(
                    "\$${double.parse(selectedCard['amount'].toString()).toStringAsFixed(2)}"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(CoreAppConstants.taxLbl),
                Text(
                    "\$${double.parse(selectedCard['tax'].toString().toString()).toStringAsFixed(2)}"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Divider(
            height: 1,
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  _cardInfoWidget(selectedCard) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.disableColor)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(CoreAppConstants.paymentLbl),
            // ignore: prefer_interpolation_to_compose_strings
            Text("Ending in " +
                controller.fetchLast4CharsOfCard(
                    selectedCard['payment_info'][0]['card_number'].toString())),
          ],
        ),
      ),
    );
  }
}
