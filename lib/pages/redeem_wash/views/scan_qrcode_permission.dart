import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/redeem_wash/controllers/redeem_wash_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class ScanQRCodePermission extends GetView<RedeemWashController> {
  const ScanQRCodePermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: CommonButton(
          onTap: () => Get.toNamed(Routes.SCAN_CODE),
          isEnabled: true,
          text: CoreAppConstants.continueBtn,
        ),
      ),
      appBar: CommonAppBar(
          titleWidget: const Text(CoreAppConstants.plsScanCodeLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () {
            Get.back();
          }),
      body: SizedBox(
        width: Get.mediaQuery.size.width,
        height: Platform.isIOS
            ? Get.mediaQuery.size.height - 230
            : Get.mediaQuery.size.height - 170,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    AppFlavor.assetPath + CoreAppConstants.backgroundImg),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppFlavor.defaultAssetPath + CoreAppConstants.scanIcon,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Text(CoreAppConstants.scanQRCodeLbl,
                  style: Get.textTheme.headlineMedium!
                      .copyWith(color: Get.theme.colorScheme.secondary)),
              Text(CoreAppConstants.continueTappingCamera,
                  style: Get.textTheme.headlineSmall)
            ],
          ),
        ),
      ),
    );
  }
}
