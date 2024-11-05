import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/transactions_controller.dart';
import 'package:customer_app/pages/home/views/account/widgets/transactions_card.dart';
import 'package:customer_app/routes/app_pages.dart';

import 'package:get/get.dart';

class TransactionsWidget extends GetView<TransactionsController> {
  const TransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          titleWidget: const Text(CoreAppConstants.transactionsLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () {
            Get.back();
          }),
      body: _tabBarWidget(),
    );
  }

  Widget _tabBarWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: AppColors.disableColor,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            unselectedLabelColor: AppColors.blackColor,
            labelColor: Get.theme.colorScheme.primary,
            tabs: const [
              Tab(
                text: CoreAppConstants.thisMonthLbl,
              ),
              Tab(
                text: CoreAppConstants.previousLbl,
              ),
            ],
            controller: controller.tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                controller.currentMonthWashList.isNotEmpty
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.currentMonthWashList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TransactionsCard(
                              onTap: () {
                                controller.calculateTotalAmount(
                                    controller.currentMonthWashList[index]
                                        ['amount'],
                                    controller.currentMonthWashList[index]
                                        ['tax']);
                                controller.isCurrentMonthWash = true;
                                controller.selectedCurrentMonthWashIndex(index);
                                Get.toNamed(Routes.TRANSACTION_DETAIL);
                              },
                              title: controller.currentMonthWashList[index]
                                      ['title']
                                  .toString(),
                              subtitle: controller
                                  .getFormatedDate(
                                      controller.currentMonthWashList[index]
                                          ['purchase_date'])
                                  .toString(),
                              trailing: controller.currentMonthWashList[index]
                                      ['amount']
                                  .toString(),
                              leading: const Icon(Icons.local_car_wash),
                            ),
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
                controller.prevMonthWashList.isNotEmpty
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.prevMonthWashList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TransactionsCard(
                              onTap: () {
                                controller.calculateTotalAmount(
                                    controller.prevMonthWashList[index]
                                        ['amount'],
                                    controller.prevMonthWashList[index]['tax']);
                                controller.isCurrentMonthWash = false;

                                controller.selectedPrevMonthWashIndex(index);
                                Get.toNamed(Routes.TRANSACTION_DETAIL);
                              },
                              title: controller.prevMonthWashList[index]
                                      ['title']
                                  .toString(),
                              subtitle: controller
                                  .getFormatedDate(
                                      controller.prevMonthWashList[index]
                                          ['purchase_date'])
                                  .toString(),
                              trailing: controller.prevMonthWashList[index]
                                      ['amount']
                                  .toString(),
                              leading: const Icon(Icons.local_car_wash),
                            ),
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
      ),
    );
  }
}
