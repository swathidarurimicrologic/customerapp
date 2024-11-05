import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_card.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class BecomeMemberWidget extends StatefulWidget {
  const BecomeMemberWidget({super.key});

  @override
  State<BecomeMemberWidget> createState() => _BecomeMemberWidgetState();
}

class _BecomeMemberWidgetState extends State<BecomeMemberWidget> {
  late List<dynamic> items;
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    items = homeController.items;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.hideAppBar.value
        ? Scaffold(body: _bodyWidget())
        : Scaffold(
            appBar: CommonAppBar(
                titleWidget: homeController.alreadyMember
                    ? const Text(CoreAppConstants.changeMembershipLbl)
                    : const Text(CoreAppConstants.becomeMemberLbl),
                iconData: Icons.arrow_back_ios,
                onAppBarMenuPressed: () {
                  homeController.hideAppBar(true);
                  Get.back();
                }),
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
                child: _bodyWidget())));
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              homeController.isFromLocationsTab(true);
              Get.toNamed(Routes.SEARCH_LOCATION);
            },
            child: CommonTextField(
              controller: homeController.searchLocationController,
              hintText: CoreAppConstants.searchHintLbl,
              prefixIconData:
                  const Icon(Icons.search, color: AppColors.greyColor),
              isEnabled: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          (homeController.alreadyMember && items[0]['status'] == 'Active')
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Active Membership',
                          style: Get.textTheme.headlineMedium!
                              .copyWith(color: Get.theme.colorScheme.primary)),
                    ),
                    BuyWashCard(
                      onTap: () {},
                      titleText: items[0]['title'],
                      subTitleText: items[0]['subtitle'],
                      description: items[0]['description'],
                      amount: homeController
                          .convertToSuperScript(items[0]['amount']),
                      washRecommeded: items[0]['washrecommeded'],
                      washDenomination: 'Monthly + Tax',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Other',
                          style: Get.textTheme.headlineMedium!
                              .copyWith(color: Get.theme.colorScheme.primary)),
                    ),
                  ],
                )
              : const IgnorePointer(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return (!homeController.alreadyMember ||
                        (items[index]['status'] == 'InActive'))
                    ? BuyWashCard(
                        onTap: () {
                          Get.toNamed(Routes.BUY_WASH_CHECKOUT);
                        },
                        titleText: items[index]['title'],
                        subTitleText: items[index]['subtitle'],
                        description: items[index]['description'],
                        amount: homeController
                            .convertToSuperScript(items[index]['amount']),
                        washRecommeded: items[index]['washrecommeded'],
                        washDenomination: 'Monthly + Tax',
                      )
                    : const IgnorePointer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
