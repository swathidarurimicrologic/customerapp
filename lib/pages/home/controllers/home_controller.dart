import 'dart:async';
import 'dart:convert';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/search_location/providers/search_location_model.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final searchLocationController = TextEditingController();
  RxInt locationIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedCardIndex = 0.obs;

  Rx locationFavoriteColor = Get.theme.colorScheme.primary.obs;

  final appStorage = Get.find<AppStorage>();
  final Location location = Location();
  late bool serviceEnabled;
  RxBool showAppBar = false.obs;
  RxBool isFromMenubar = false.obs;
  String? currentNavPage;

  late bool result;
  bool alreadyMember = false;
  late RxList<SearchLocationModel> searchData =
      List<SearchLocationModel>.empty(growable: true).obs;

  RxInt selectedFilterIndex = 0.obs;
  RxBool isFromLocationsTab = false.obs;
  RxBool hideAppBar = false.obs;
  RxBool hideAccountAppBar = true.obs;

  late LocationDetail selectedLocation;
  RxInt selectedBuyWash = 0.obs;

  List<dynamic> items2 = [
    {
      'title': 'Ultimate Full Service',
      'subtitle': 'Platinum Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19',
      'tax': '0.24',
      'washrecommeded': 'OUR BEST WASH',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
      ]
    },
    {
      'title': 'Platinum Full Service',
      'subtitle': 'Platinum',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19.99',
      'tax': '0.24',
      'isbestseller': true,
      'washrecommeded': '',
      'key_points': ['Tire Shine', 'Wheel Polish', 'Underbody Rinse']
    },
    {
      'title': 'Gold',
      'subtitle': 'Ultimate Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '19.99',
      'tax': '0.59',
      'washrecommeded': '',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    },
    {
      'title': 'Gold',
      'subtitle': 'Platinum',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29.99',
      'tax': '0.24',
      'washrecommeded': '',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
      ]
    },
    {
      'title': 'Silver',
      'subtitle': 'Platinum Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29.99',
      'tax': '0.59',
      'washrecommeded': '',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    }
  ];

  List<dynamic> items = [
    {
      'title': 'Ultimate Full Service',
      'subtitle': 'Platinum Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29',
      'tax': '0.24',
      'washrecommeded': 'OUR BEST WASH',
      'status': 'Active',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    },
    {
      'title': 'Platinum Full Service',
      'subtitle': 'Platinum',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29.99',
      'tax': '0.24',
      'isbestseller': true,
      'washrecommeded': 'OUR BEST WASH',
      'status': 'InActive',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    },
    {
      'title': 'Gold',
      'subtitle': 'Ultimate Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29.99',
      'tax': '0.59',
      'washrecommeded': '',
      'status': 'InActive',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    },
    {
      'title': 'Gold',
      'subtitle': 'Platinum',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '49.99',
      'tax': '0.24',
      'washrecommeded': '',
      'status': 'InActive',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    },
    {
      'title': 'Silver',
      'subtitle': 'Platinum Plus',
      'description':
          'Our best wash yet! Includes Hot Shine & Platinum Repel Shield for 360 protection & mirror-like finish.',
      'amount': '29.99',
      'tax': '0.59',
      'washrecommeded': '',
      'status': 'Canceled',
      'key_points': [
        'Underbody Defense',
        'Hotshine Caurnoba wax',
        'Platinum Repel Shield',
        'Tire Shine',
        'Wheel Polish',
        'Underbody Rinse'
      ]
    }
  ];

  List<Map<String, dynamic>> filterList = [
    {'title': 'Interior Services', 'isChecked': false},
    {'title': 'Coming Soon', 'isChecked': false},
    {'title': 'Open Now', 'isChecked': false},
    {'title': 'Free Vacuums', 'isChecked': false}
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['show_app_bar'] != null &&
          Get.arguments['show_app_bar']) {
        hideAppBar(false);
        showAppBar(true);
      }
      if (Get.arguments['selected_index'] != null) {
        selectedIndex(Get.arguments['selected_index']);
      }
    }

    if (appStorage.getUserData() != null &&
        appStorage.getUserData()['name'] != null) {
      print(appStorage.getUserData()['name']);
      if (Get.arguments != null &&
          Get.arguments['guest'] != null &&
          Get.arguments['guest']) {
        alreadyMember = false;
      } else {
        alreadyMember = true;
      }
    }
    // filterList[0]['isChecked']!;
    print(appStorage.getLocationPermissionName());
    if (appStorage.getLocationPermissonGranted() == null ||
        (appStorage.getLocationPermissionName() ==
            "LocationPermission.denied")) {
      result = await _handlePermission();
      if (!result) {
        _mandateEnablingLocation();
      }
    }
  }

  fetchLocationName() {
    if (appStorage.getLocationPermissonGranted() != null &&
        appStorage.getLocationPermissonGranted()) {
      return true;
    } else if (appStorage.getLocationPermissonGranted() != null &&
        !appStorage.getLocationPermissonGranted()) {
      return false;
    }
    return false;
  }

  String appbarTitle = '';

  set currentPage(String currentPage) {
    currentNavPage = currentPage;
  }

  fetchAppBarTitle() {
    switch (selectedIndex.value) {
      case 0:
        appbarTitle = CoreAppConstants.micrologicLbl;
        update();
        return appbarTitle;
      case 1:
        appbarTitle = CoreAppConstants.myWashesLbl;
        update();
        return appbarTitle;
      case 2:
        appbarTitle = (selectedBuyWash.value == 1)
            ? alreadyMember
                ? CoreAppConstants.changeMembershipLbl
                : CoreAppConstants.becomeMemberLbl
            : CoreAppConstants.buyWashLbl;
        update();
        return appbarTitle;
      case 3:
        appbarTitle = CoreAppConstants.locationsLbl;
        update();
        return appbarTitle;
      case 4:
        appbarTitle = CoreAppConstants.accountLbl;
        update();
        return appbarTitle;
      default:
        appbarTitle = CoreAppConstants.micrologicLbl;
        update();
        return appbarTitle;
    }
  }

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('lib/data/locations.json');
    // final List data = await json.decode(response);
    List<SearchLocationModel> data =
        SearchLocationListModel.fromJson(json.decode(response))
            .searchLocationList;
    print(data.first.name);
    return data;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    isFromMenubar(false);
    showAppBar(false);
    hideAppBar(true);
    hideAccountAppBar(true);
    if (selectedIndex.value == 2) {
      showBottomSheet();
    }
  }

  showBottomSheet() {
    Future.delayed(
      const Duration(seconds: 0),
      () {
        CommonBottomSheet.showBottomSheet(
            isDismissible: true,
            widgetBody: Container(
              color: Get.theme.colorScheme.primary,
              height: Get.mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                        color: AppColors.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    // color: AppColors.whiteColor,
                    child: Column(
                      children: [
                        CommonButton(
                          onTap: () {
                            appbarTitle = CoreAppConstants.buyWashLbl;
                            Get.back();
                            selectedBuyWash(1);
                          },
                          isEnabled: true,
                          text: alreadyMember
                              ? CoreAppConstants.changeMembershipLbl
                              : CoreAppConstants.becomeMemberLbl,
                        ),
                        const SizedBox(height: 15),
                        CommonButton(
                          // buttonColor: AppColors.primaryColor,
                          onTap: () {
                            Get.back();
                            selectedBuyWash(2);
                          },
                          isEnabled: true,
                          text: CoreAppConstants.buyWashLbl,
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Get.back();
                            // Get.back();
                            Get.offAllNamed(Routes.HOME);
                            selectedBuyWash(0);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(CoreAppConstants.closeBtn,
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                      color: Get.theme.colorScheme.primary))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    PermissionStatus permission;

    // Test if location services are enabled.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == PermissionStatus.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }
    return true;
  }

  void _mandateEnablingLocation() {
    CommonBottomSheet.showBottomSheet(
        widgetBody: Container(
      padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
      height: Get.mediaQuery.size.height * 0.45,
      child: ListView(
        children: [
          Center(
              child: Image.asset(AppFlavor.defaultAssetPath +
                  CoreAppConstants.locationArrowImage)),
          Text(CoreAppConstants.titleLocationEnableLbl,
              textAlign: TextAlign.center,
              style: Get.textTheme.headlineLarge!
                  .copyWith(color: AppColors.darkGreyColor)),
          const SizedBox(height: 15),
          Text(CoreAppConstants.subTitleLocationEnableLbl,
              textAlign: TextAlign.center, style: Get.textTheme.bodyMedium),
          const SizedBox(height: 15),
          Text(CoreAppConstants.detailLocationEnableLbl,
              textAlign: TextAlign.center, style: Get.textTheme.bodyMedium),
          const SizedBox(height: 15),
          CommonButton(
            onTap: () => _openAppSettings(),
            isEnabled: true,
            text: CoreAppConstants.goToSettingsBtn,
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              alignment: Alignment.center,
              child: const Text(CoreAppConstants.closeBtn,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.normal)),
            ),
          )
        ],
      ),
    ));
  }

  void _openAppSettings() async {
    Get.back();
    final opened = await location.changeSettings();
    String displayValue;
    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }
  }

  premiumMemberShipStatus() {}

  List<String> convertToSuperScript(String amount) {
    var amountArray = amount.split(".");

    return amountArray;
  }

  getIsFavorite(bool isFavorite) {
    if (isFavorite) {
      locationFavoriteColor(Get.theme.colorScheme.primary);
      return true;
    } else {
      locationFavoriteColor(AppColors.disableColor);
      return false;
    }
  }

  searchLocation({required dynamic data}) {
    print(data);
    if (searchLocationController.text.isNotEmpty) {
      searchData(data
          .where((x) => (x.name
                  .toString()
                  .toLowerCase()
                  .contains(searchLocationController.text.toLowerCase()) ||
              x.abbreviation
                  .toString()
                  .toLowerCase()
                  .contains(searchLocationController.text.toLowerCase())))
          .toList());
      print(searchData);
    } else {
      searchData.clear();
    }
  }

  getFilterTags(String s) {
    List split = s.split(',');
    return split;
  }

  Future<void> launchCall({required String phoneNumber}) async {
    final Uri urlParsed = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch call to: $phoneNumber';
    }
  }

  void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  void applyFilters() {
    var locationDetails = searchData[locationIndex.value].locationDetails;
    var filteredItem =
        filterList[selectedFilterIndex.value]['title'].toString().split(" ");
    var firstValue = filteredItem.isNotEmpty
        ? filteredItem.first
        : filterList[selectedFilterIndex.value]['title'].toString();
    if (locationDetails.isNotEmpty) {
      locationDetails.where((x) => ("Interior" == (firstValue))).toList();
      print(locationDetails);
    }
  }

  bool getSelectedItems(int index) {
    print(filterList[index]);
    var checked = filterList[index]['isChecked'];
    update();
    return checked;
  }

  void updateCheckBoxValues(int index, bool value) {
    selectedFilterIndex(index);
    filterList[index]['isChecked'] = value;
    print(filterList[index]['isChecked']);
    update();
  }

  fetchNearbyLocationWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
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
        // onTap: () => Get.toNamed(Routes.TERMS_AND_CONDITIONS),
        leading: Image.asset(
            AppFlavor.defaultAssetPath + CoreAppConstants.locationPinImgPath),
        title: Text(
            fetchLocationName()
                ? 'Western Ave.'
                : CoreAppConstants.locationNotFoundLbl,
            style: Get.textTheme.bodyMedium),
        subtitle: Text(
          fetchLocationName()
              ? '4 miles away'
              : CoreAppConstants.noLocationsLbl,
          style: Get.textTheme.bodySmall,
        ),
        trailing: InkWell(
          onTap: () {
            isFromLocationsTab(true);
            showAppBar(false);
            Get.toNamed(Routes.SEARCH_LOCATION);
          },
          child: Text(
            fetchLocationName()
                ? CoreAppConstants.changeLbl
                : CoreAppConstants.setLocationLbl,
            style: Get.textTheme.bodyMedium!
                .copyWith(color: Get.theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
