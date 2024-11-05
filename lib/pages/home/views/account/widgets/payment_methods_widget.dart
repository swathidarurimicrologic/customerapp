import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/payment_method_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class PaymentMethodsWidget extends GetView<PaymentMethodController> {
  const PaymentMethodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        titleWidget: const Text(CoreAppConstants.paymentMethodsLbl),
        iconData: Icons.arrow_back_sharp,
        onAppBarMenuPressed: () => Get.back(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: CommonButton(
          onTap: () {
            Get.toNamed(Routes.ADD_NEW_CARD);
          },
          isEnabled: true,
          text: CoreAppConstants.addNewCardLbl,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: Platform.isIOS
            ? Get.mediaQuery.size.height - 230
            : Get.mediaQuery.size.height - 160,
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
        child: controller.savedPaymentDetails.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppFlavor.defaultAssetPath +
                        CoreAppConstants.noCreditCardIcon,
                    width: 100,
                    height: 100,
                  ),
                  const Flexible(
                    child: Text(CoreAppConstants.noCreditCardFound),
                  )
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.savedPaymentDetails.length,
                itemBuilder: (context, index) {
                  return _cardInfoWidget(index);
                },
              ),
      ),
    );
  }

  Widget _cardInfoWidget(int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.ADD_NEW_CARD,
            arguments: {'card_details': controller.savedPaymentDetails[index]});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Card(
          color: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(CoreAppConstants.paymentLbl),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                              controller.savedPaymentDetails[index]['status']),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Get.theme.colorScheme.primary,
                        )
                      ],
                    ),
                  ],
                ),
                // ignore: prefer_interpolation_to_compose_strings
                Text("Ending in " +
                    controller.fetchLast4CharsOfCard(
                        controller.savedPaymentDetails[index]['card_number']))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
