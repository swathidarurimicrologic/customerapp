import 'dart:io';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/core/components/common_drawer.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/pages/home/views/account/account_widget.dart';
import 'package:customer_app/pages/home/views/buy/buy_wash_menu_widget.dart';
import 'package:customer_app/pages/home/views/locations/locations_widget.dart';
import 'package:customer_app/pages/home/views/menu/menu_widget.dart';
import 'package:customer_app/pages/home/views/my_washes/my_washes.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          appBar: CommonAppBar(
              titleWidget: Text(controller.fetchAppBarTitle()),
              iconData: Icons.menu,
              onAppBarMenuPressed: () {
                // Get.back();
                scaffoldKey.currentState!.openDrawer();
              }),
          drawer: CommonDrawer(controller),
          body: _bottomNavigationWidget(),
        ),
      ),
    );
  }

  Widget _bottomNavigationWidget() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
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
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              MenuWidget(),
              MyWashesWidget(),
              BuyWashMenuWidget(),
              LocationsWidget(),
              AccountWidget()
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: Platform.isIOS
                ? const EdgeInsets.only(top: 10, bottom: 0, right: 10, left: 10)
                : const EdgeInsets.only(
                    top: 10, bottom: 10, right: 10, left: 10),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                top: BorderSide(
                  color: AppColors.disableColor,
                  width: 1.0,
                ),
              ),
            ),
            child: SizedBox(
              height: 66,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                          AssetImage("${AppFlavor.defaultAssetPath}home.png")),
                      // backgroundColor: Colors.black,
                      label: CoreAppConstants.homeLbl,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(
                          "${AppFlavor.defaultAssetPath}washes.png")),
                      // backgroundColor: Colors.black,
                      label: CoreAppConstants.washesLbl,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(
                          "${AppFlavor.defaultAssetPath}sparkle.png")),
                      label: CoreAppConstants.buyLbl,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(
                          "${AppFlavor.defaultAssetPath}location_pin_bottom.png")),
                      // backgroundColor: Colors.black,
                      label: CoreAppConstants.locationsLbl,
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(
                          "${AppFlavor.defaultAssetPath}user_circle.png")),
                      // backgroundColor: Colors.black,
                      label: CoreAppConstants.accountLbl,
                    ),
                  ],
                  currentIndex: controller.selectedIndex.value,
                  selectedItemColor: AppColors.whiteColor,
                  unselectedItemColor: AppColors.disableColor,
                  onTap: controller.onItemTapped,
                  // elevation: 0.3,
                  iconSize: 15,
                ),
              ),
            ),
          ),
        ));
  }
}
