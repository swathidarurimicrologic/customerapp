import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_text_field.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_card.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class BuyWashWidget extends StatefulWidget {
  const BuyWashWidget({super.key});

  @override
  State<BuyWashWidget> createState() => _BuyWashWidgetState();
}

class _BuyWashWidgetState extends State<BuyWashWidget> {
  late List<dynamic> items;
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    items = homeController.items2;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !homeController.hideAppBar.value
          ? Scaffold(
              appBar: CommonAppBar(
                  titleWidget: const Text(CoreAppConstants.buyWashLbl),
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
                  child: _bodyWidget()))
          : Scaffold(body: _bodyWidget()),
    );
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return BuyWashCard(
                  onTap: () {
                    Get.toNamed(Routes.BUY_WASH_CHECKOUT);
                  },
                  titleText: items[index]['title'],
                  subTitleText: items[index]['subtitle'],
                  description: items[index]['description'],
                  amount: homeController
                      .convertToSuperScript(items[index]['amount']),
                  washRecommeded: items[index]['washrecommeded'],
                  washDenomination: 'Single Wash',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
