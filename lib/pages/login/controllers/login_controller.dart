import 'dart:convert';

import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/login/providers/countries_model.dart';
import 'package:customer_app/pages/login/providers/login_service.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LoginController extends GetxController {
  LoginService loginService = Get.find<LoginService>();
  AppStorage appStorage = Get.find<AppStorage>();
  late bool result;
  final Location location = Location();
  TextEditingController phoneCodeController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchContactController = TextEditingController();

  final RxBool isPassword = true.obs;
  final RxBool checkedValue = false.obs;
  final RxBool isLoginBtnEnabled = false.obs;
  final dynamic phoneNumberSuffixIcon = const Icon(null).obs;
  RxList countriesList = List<CountriesModel>.empty().obs;
  Rx<CountriesModel> selectedCountry = CountriesModel().obs;
  RxInt locationIndex = 230.obs;

  RxBool isLocationPermissionByPassed = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (phoneCodeController.text.isEmpty) phoneCodeController.text = "+1";
  }

  String? validatePhoneNumber(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);
    return ((value!.isNotEmpty && !regex.hasMatch(value)) || value.isEmpty)
        ? CoreAppConstants.invalidPhoneNumberLbl
        : null;
  }

  onPhoneNumberFieldValidate(String value) {
    String phoneNumber = value.replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");

    phoneNumber = phoneNumber.trim();

    if (validatePhoneNumber(phoneNumber) != null) {
      return CoreAppConstants.invalidPhoneNumberLbl;
    }
    return null;
  }

  Future<List<dynamic>> readJson() async {
    final String response =
        await rootBundle.loadString('lib/data/countries.json');
    List<CountriesModel> data =
        CountriesListModel.fromJson(json.decode(response))
            .countriesList
            .toList();
    print(data.first.name);
    countriesList(data);
    if (searchContactController.text.isEmpty &&
        (phoneCodeController.text == "+1")) {
      searchContactController.text = countriesList[230].name;
    }

    return data;
  }

  searchContact({required dynamic data}) {
    print(data);
    if (searchContactController.text.isNotEmpty) {
      countriesList(data
          .where((x) => (x.name
                  .toString()
                  .toLowerCase()
                  .contains(searchContactController.text.toLowerCase()) ||
              x.dialCode
                  .toString()
                  .toLowerCase()
                  .contains(searchContactController.text.toLowerCase()) ||
              x.dialCode
                  .toString()
                  .toLowerCase()
                  .contains(searchContactController.text.toLowerCase())))
          .toList());
      print(countriesList);
    } else {
      countriesList.clear();
    }
  }

  enableLocationPermission() async {
    if (isLocationPermissionByPassed.value) {
      Get.offAndToNamed(Routes.HOME);
    } else {
      result = await _handlePermission();
      appStorage.storeLocationPermissonGranted(result);

      if (!result) {
        _mandateEnablingLocation();
      } else {
        Get.offAndToNamed(Routes.HOME);
      }
    }
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

  // Future<bool> _handlePermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.

  //     return false;
  //   }

  //   permission = await _geolocatorPlatform.checkPermission();
  //   appStorage.storeLocationPermissionName(permission);
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.

  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.

  //     return false;
  //   }

  //   return true;
  // }

  void _openAppSettings() async {
    Get.back();
    // final opened = await location.changeSettings();
    // String displayValue;
    // if (opened) {
    //   displayValue = 'Opened Application Settings.';
    // } else {
    //   displayValue = 'Error opening Application Settings.';
    // }
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
            onTap: () {
              isLocationPermissionByPassed(true);
              Get.back();
            },
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
}
