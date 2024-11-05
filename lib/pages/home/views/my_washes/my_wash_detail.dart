import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/components/common_outline_button.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/controllers/my_washes_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class MyWashDetailWidget extends GetView<MyWashesController> {
  final homeController = Get.find<HomeController>();
  MyWashDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.washDetailLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(), //TODO: change this to Get.back
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: CommonButton(
          onTap: () {
            homeController.currentNavPage = 'my_wash';
            controller.isRedeemWash ? null : Get.toNamed(Routes.SCAN_CODE);
          },
          isEnabled: controller.isRedeemWash ? false : true,
          text: CoreAppConstants.redeemWashLbl,
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
        // color: AppColors.scaffoldBackgroundColor,
        height: Platform.isIOS
            ? MediaQuery.of(context).size.height - 230
            : MediaQuery.of(context).size.height - 180,
        child: Column(
          children: [
            _barCodeWidget(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Card(
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.disableColor)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      _washInfoWidget(),
                      _qrCodeWidget(),
                      _viewOrderDetailsWidget()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _barCodeWidget() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          height: 150,
          child: BarcodeWidget(
            barcode: Barcode.code128(),
            data: '43770929851162',
          ),
        ),
        controller.isRedeemWash
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                top: 0.0,
                child: Chip(
                  backgroundColor: AppColors.greyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // shadowColor: Colors.transparent,
                  side: BorderSide.none,
                  //CircleAvatar
                  label: Text(
                    'Redeemed',
                    style: Get.textTheme.bodySmall!
                        .copyWith(color: AppColors.whiteColor),
                  ), //Text
                ),
              )
            : const IgnorePointer(),
      ],
    );
  }

  _qrCodeWidget() {
    return Column(
      children: [
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
                text: 'Your redeem code: ', style: Get.textTheme.bodyMedium),
            TextSpan(
                text: 'REDEEEM55',
                style: Get.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ))
      ],
    );
  }

  _viewOrderDetailsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: CommonOutlineButton(
        // buttonColor: controller.isSendCodeEnabled.value
        //     ? AppColors.whiteColor
        //     : AppColors.disableButtonColor,
        onTap: () => _showBottomsheet(),
        isEnabled: true,
        text: CoreAppConstants.viewOrderDetailsLbl,
      ),
    );
  }

  _washInfoWidget() {
    var selectedCard = controller.isRedeemWash
        ? controller.redeemWashList[controller.selectedRedeemWashIndex.value]
        : controller.activeWashList[controller.selectedActiveWashIndex.value];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text(selectedCard['title']),
        Chip(
          backgroundColor: controller.isRedeemWash
              ? AppColors.greyColor
              : Get.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // shadowColor: Colors.transparent,
          side: BorderSide.none,
          //CircleAvatar
          label: Text(
            '${selectedCard['number_washes']} Wash Available',
            style: Get.theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.whiteColor),
          ), //Text
        ),
      ]),
    );
  }

  _showBottomsheet() {
    var selectedCard = controller.isRedeemWash
        ? controller.redeemWashList[controller.selectedRedeemWashIndex.value]
        : controller.activeWashList[controller.selectedActiveWashIndex.value];
    CommonBottomSheet.showBottomSheet(
        isDismissible: true,
        widgetBody: Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          height: Get.mediaQuery.size.height * 0.45,
          child: ListView(
            children: [
              Center(
                  child: Text(CoreAppConstants.orderDetailsLbl,
                      style: Get.theme.textTheme.headlineMedium)),
              const SizedBox(height: 10),
              Card(
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
                          Text(controller.getDateOnlyFormat(
                              selectedCard['expiry_date'].toString())),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Card(
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
                          Text(selectedCard['amount'].toString()),
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
                          Text(selectedCard['tax'].toString()),
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
                          Text(controller.finalAmount.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CommonButton(
                onTap: () {
                  Get.back();
                },
                isEnabled: true,
                text: CoreAppConstants.doneLbl,
              ),
            ],
          ),
        ));
  }
}
