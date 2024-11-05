import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/my_washes_controller.dart';
import 'package:customer_app/pages/home/views/my_washes/my_wash_card.dart';
import 'package:customer_app/routes/app_pages.dart';

import 'package:get/get.dart';

class MyWashesWidget extends GetView<MyWashesController> {
  const MyWashesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !controller.homeController.alreadyMember
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    AppFlavor.defaultAssetPath + CoreAppConstants.washIcon,
                    width: 60,
                    height: 60),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(CoreAppConstants.accessAccountPurchaseLbl,
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: CommonButton(
                    onTap: () {
                      controller.homeController.hideAppBar(false);
                      Get.toNamed(Routes.LOGIN);
                    },
                    isEnabled: true,
                    text: CoreAppConstants.loginSignupLbl,
                  ),
                ),
              ],
            )
          : _tabBarWidget(),
    );
  }

  Widget _tabBarWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          unselectedLabelColor: AppColors.blackColor,
          labelColor: Get.theme.colorScheme.primary,
          tabs: const [
            Tab(
              text: CoreAppConstants.activeLbl,
            ),
            Tab(
              text: CoreAppConstants.redeemedLbl,
            ),
          ],
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              controller.myWashList.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.activeWashList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyWashCard(
                              onTap: () {
                                controller.calculateTotalAmount(
                                    controller.activeWashList[index]['amount'],
                                    controller.activeWashList[index]['tax']);
                                controller.selectedActiveWashIndex(index);
                                controller.isRedeemWash = false;
                                Get.toNamed(Routes.MY_WASH_DETAIL);
                              },
                              title: controller.activeWashList[index]['title']
                                  .toString(),
                              subtitle: controller
                                  .getFormatedDate(controller
                                      .activeWashList[index]['purchase_date'])
                                  .toString(),
                              trailing: controller.activeWashList[index]
                                      ['status']
                                  .toString(),
                              leading: const Icon(Icons.local_car_wash),
                              isActive: true),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            AppFlavor.defaultAssetPath +
                                CoreAppConstants.washIcon,
                            width: 100,
                            height: 100),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: CommonButton(
                            // buttonColor: controller.isCreateAccntBtnEnabled.value
                            //     ? AppColors.primaryColor
                            //     : AppColors.disableButtonColor,
                            onTap: () {
                              controller.homeController.hideAppBar(false);
                              Get.toNamed(Routes.BECOME_MEMBER);
                            },
                            isEnabled: true,
                            text: CoreAppConstants.buyAnUnlimtedLbl,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            controller.homeController.hideAppBar(false);
                            Get.toNamed(Routes.BUY_WASH);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(CoreAppConstants.buyAWashLbl,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                      color: Get.theme.colorScheme.primary))),
                        ),
                      ],
                    ),
              controller.myWashList.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.redeemWashList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MyWashCard(
                              onTap: () {
                                controller.calculateTotalAmount(
                                    controller.redeemWashList[index]['amount'],
                                    controller.redeemWashList[index]['tax']);
                                controller.selectedRedeemWashIndex(index);
                                controller.isRedeemWash = true;
                                Get.toNamed(Routes.MY_WASH_DETAIL);
                              },
                              title: controller.redeemWashList[index]['title']
                                  .toString(),
                              subtitle: controller
                                  .getFormatedDate(controller
                                      .redeemWashList[index]['purchase_date'])
                                  .toString(),
                              trailing: controller.redeemWashList[index]
                                      ['status']
                                  .toString(),
                              leading: const Icon(Icons.local_car_wash),
                              isActive: false),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            AppFlavor.defaultAssetPath +
                                CoreAppConstants.washIcon,
                            width: 100,
                            height: 100),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: CommonButton(
                            // buttonColor: controller.isCreateAccntBtnEnabled.value
                            //     ? AppColors.primaryColor
                            //     : AppColors.disableButtonColor,
                            onTap: () {
                              controller.homeController.hideAppBar(false);
                              Get.toNamed(Routes.BECOME_MEMBER);
                            },
                            isEnabled: true,
                            text: CoreAppConstants.buyAnUnlimtedLbl,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            controller.homeController.hideAppBar(false);
                            Get.toNamed(Routes.BUY_WASH);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(CoreAppConstants.buyAWashLbl,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                      color: Get.theme.colorScheme.primary))),
                        ),
                      ],
                    ),
            ],
          ),
        )
      ],
    );
  }
}
