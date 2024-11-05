import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_card.dart';
import 'package:customer_app/pages/home/views/locations/contact_widget.dart';
import 'package:customer_app/pages/home/views/locations/nearby_locations_widget.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class LocationDetailWidget extends StatefulWidget {
  const LocationDetailWidget({super.key});

  @override
  _LocationDetailWidgetState createState() => _LocationDetailWidgetState();
}

class _LocationDetailWidgetState extends State<LocationDetailWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          titleWidget: const Text(CoreAppConstants.locationsLbl),
          iconData: Icons.arrow_back_sharp,
          onAppBarMenuPressed: () {
            // Get.back();
            Get.back();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: CommonButton(
          onTap: () =>
              homeController.navigateTo(37.43296265331129, -122.08832357078792),
          isEnabled: true,
          text: CoreAppConstants.getDirectionsLbl,
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
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: Platform.isIOS
                  ? Get.mediaQuery.size.height - 230
                  : Get.mediaQuery.size.height - 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NearbyLocationsWidget(
                    fromFavTab: true,
                    onWidgetSelected: () {
                      Get.toNamed(Routes.LOCATION_DETAIL);
                    },
                    locationPath: homeController.selectedLocation,
                    titleText: homeController.selectedLocation.locationName,
                    address: homeController.selectedLocation.address,
                    isFavorite: homeController.getIsFavorite(
                        homeController.selectedLocation.isFavorite),
                    subtitleText: homeController.selectedLocation.distance,
                    filterTags:
                        homeController.getFilterTags('Exterior, Interior'),
                    status: 'Open, Closes 8:00 PM',
                  ),
                  ContactWidget(),
                  nestedScrollView()
                  // Obx(() => nestedScrollView())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  nestedScrollView() {
    return Expanded(
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverAppBar(
            //   title: const Text(
            //     "WhatsApp type sliver appbar",
            //   ),
            //   centerTitle: true,
            //   pinned: true,
            //   floating: true,
            //   bottom: TabBar(
            //       indicatorColor: Colors.black,
            //       labelPadding: const EdgeInsets.only(
            //         bottom: 16,
            //       ),
            //       controller: _tabController,
            //       tabs: [
            //         const Text("TAB A"),
            //         const Text("TAB B"),
            //       ]),
            // ),
          ];
        },
        body: Column(
          children: [
            TabBar(
                indicatorColor: Colors.black,
                labelPadding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                controller: _tabController,
                tabs: const [
                  Text(CoreAppConstants.unlimitedLbl),
                  Text(CoreAppConstants.singleWashLbl),
                ]),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [TabA(), TabA()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// ignore: must_be_immutable
class TabA extends StatelessWidget {
  TabA({super.key});

  var homeController = Get.find<HomeController>();

  List items = [
    {
      'title': 'Item 1',
      'subtitle': 'Platinum Plus',
      'description': 'Lorem Ipsum',
      'amount': '29',
      'washrecommeded': 'OUR BEST WASH'
    },
    {
      'title': 'Item 2',
      'subtitle': 'Platinum',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'isbestseller': true,
      'washrecommeded': 'OUR BEST WASH'
    },
    {
      'title': 'Item 3',
      'subtitle': 'Ultimate Plus',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'washrecommeded': ''
    },
    {
      'title': 'Item 4',
      'subtitle': 'Platinum',
      'description': 'Lorem Ipsum',
      'amount': '49.99',
      'washrecommeded': ''
    },
    {
      'title': 'Item 5',
      'subtitle': 'Platinum Plus',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'washrecommeded': ''
    },
    {
      'title': 'Item 6',
      'subtitle': 'Platinum Plus',
      'description': 'Lorem Ipsum',
      'amount': '29',
      'washrecommeded': 'OUR BEST WASH'
    },
    {
      'title': 'Item 7',
      'subtitle': 'Platinum',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'isbestseller': true,
      'washrecommeded': 'OUR BEST WASH'
    },
    {
      'title': 'Item 8',
      'subtitle': 'Ultimate Plus',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'washrecommeded': ''
    },
    {
      'title': 'Item 9',
      'subtitle': 'Platinum',
      'description': 'Lorem Ipsum',
      'amount': '49.99',
      'washrecommeded': ''
    },
    {
      'title': 'Item 10',
      'subtitle': 'Platinum Plus',
      'description': 'Lorem Ipsum',
      'amount': '29.99',
      'washrecommeded': ''
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        separatorBuilder: (context, child) => const Divider(
          height: 1,
        ),
        padding: const EdgeInsets.all(0.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return BuyWashCard(
            onTap: () {},
            titleText: items[index]['title'],
            subTitleText: items[index]['subtitle'],
            description: items[index]['description'],
            amount: homeController.convertToSuperScript(items[index]['amount']),
            washRecommeded: items[index]['washrecommeded'],
            washDenomination: 'Monthly + Tax',
          );
        },
      ),
    );
  }
}
