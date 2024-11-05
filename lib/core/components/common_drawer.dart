// ignore_for_file: non_constant_identifier_names

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

Drawer CommonDrawer(homeController) {
  return Drawer(
      width: double.infinity,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: ListView(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  title: Text(
                    CoreAppConstants.homeLbl,
                    style: Get.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close)),
                ),
                Container(
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
                  child: ListTile(
                    onTap: () {
                      homeController.hideAppBar(false);
                      Get.offAndToNamed(Routes.BECOME_MEMBER);
                    },
                    leading: Image.asset(AppFlavor.defaultAssetPath +
                        CoreAppConstants.rotateSquareImgPath),
                    title: Text(
                      CoreAppConstants.unlimitedWashLbl,
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.disableColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      homeController.hideAppBar(false);

                      Get.offAndToNamed(Routes.BUY_WASH,
                          arguments: {'show_app_bar': true});
                    },
                    leading: Image.asset(AppFlavor.defaultAssetPath +
                        CoreAppConstants.buyWashImgPath),
                    title: Text(CoreAppConstants.buyWashLbl,
                        style: Get.textTheme.titleMedium),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.disableColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      homeController.hideAccountAppBar(false);
                      Get.offAndToNamed(Routes.ACCOUNT);
                    },
                    leading: Image.asset(AppFlavor.defaultAssetPath +
                        CoreAppConstants.userSquareImgPath),
                    title: Text(CoreAppConstants.accountLbl,
                        style: Get.textTheme.titleMedium),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.disableColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      homeController.isFromMenubar(true);
                      Get.offAndToNamed(Routes.LOCATIONS);
                    },
                    leading: Image.asset(AppFlavor.defaultAssetPath +
                        CoreAppConstants.locationPinImgPath),
                    title: Text(CoreAppConstants.locationsLbl,
                        style: Get.textTheme.titleMedium),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldBackgroundColor,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.disableColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      homeController.hideAppBar(false);
                      Get.offAndToNamed(Routes.LEGAL);
                    },
                    leading: Image.asset(AppFlavor.defaultAssetPath +
                        CoreAppConstants.legalImgPath),
                    title: Text(
                      CoreAppConstants.legalLbl,
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            )),

            // const SizedBox(height: 13.5),
            // Padding(
            //   padding: const EdgeInsets.only(left: 24, bottom: 26),
            //   child: Text(
            //     (AppLocalizationKeys.footerInfoMessage).tr,
            //     style: Get.theme.textTheme.headline5!.copyWith(
            //         fontWeight: FontWeight.w300,
            //         color: AppColors.grey,
            //         fontSize: 15),
            //   ),
            // ),
          ],
        ),
      ));
}
