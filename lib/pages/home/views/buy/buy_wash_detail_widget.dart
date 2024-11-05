import 'dart:math';

import 'package:customer_app/core/app_configuration/app_colors.dart';
import 'package:customer_app/core/app_configuration/app_strings.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/pages/home/controllers/buy_wash_checkout_controller.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_card_detail.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuyWashDetailWidget extends StatefulWidget {
  const BuyWashDetailWidget({super.key});

  @override
  State<BuyWashDetailWidget> createState() => _BuyWashDetailWidgetState();
}

class _BuyWashDetailWidgetState extends State<BuyWashDetailWidget> {
  late List<dynamic> items;
  var homeController = Get.find<HomeController>();
  var checkoutController = Get.find<BuyWashCheckOutController>();
  final _carouselController = PageController(viewportFraction: 0.6);

  @override
  void initState() {
    super.initState();

    if (homeController.alreadyMember) {
      items =
          homeController.items.where((i) => (i['status'] != 'Active')).toList();
    } else {
      items = homeController.items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          titleWidget: Text(checkoutController.isUpdateMembership
              ? CoreAppConstants.updateMembershipLbl
              : CoreAppConstants.becomeMemberLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () {
            // Get.back();
            Get.back();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: CommonButton(
          isEnabled: true,
          onTap: () => Get.toNamed(Routes.BUY_WASH_CHECKOUT),
          text: CoreAppConstants.checkoutLbl,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 160,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            homeController.fetchNearbyLocationWidget(),
            carousalWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SmoothPageIndicator(
                controller: _carouselController,
                count: items.length,
                effect: SwapEffect(
                  dotColor: AppColors.disableColor,
                  activeDotColor: Get.theme.colorScheme.primary,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  carousalWidget() {
    // return CustomScrollView(
    //   slivers: [
    //     SliverFillRemaining(
    //       hasScrollBody: false,
    //       child:
    //     ),
    //   ],
    // );
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 36),
          ExpandablePageView.builder(
            controller: _carouselController,
            // allows our shadow to be displayed outside of widget bounds
            clipBehavior: Clip.none,
            itemCount: items.length,
            onPageChanged: (index) {
              homeController.selectedCardIndex(index);
              print(_carouselController.page);
            },
            itemBuilder: (_, index) {
              if (!_carouselController.position.haveDimensions) {
                return const SizedBox();
              }

              return AnimatedBuilder(
                animation: _carouselController,
                builder: (_, __) => Transform.scale(
                  scale: max(
                    0.8,
                    (1 - (_carouselController.page! - index).abs() / 2),
                  ),
                  child: BuyWashCardDetail(
                      onTap: () {},
                      currentIndex: index,
                      titleText: items[index]['title'],
                      subTitleText: items[index]['subtitle'],
                      description: items[index]['description'],
                      amount: homeController
                          .convertToSuperScript(items[index]['amount']),
                      washRecommeded: items[index]['washrecommeded'],
                      keyPoints: items[index]['key_points']),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
