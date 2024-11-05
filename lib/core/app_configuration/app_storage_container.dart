import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:location/location.dart';

class AppStorage extends GetxService {
  var loggedInUser;
  late bool isLocationPermissonGranted;
  // late PermissionStatus locationPermissionName;

  storeUserData(userData) {
    loggedInUser = userData;
    GetStorage().write(CoreAppConstants.loggedInUser, userData);
  }

  Future<AppStorage> init() async {
    await GetStorage.init();
    return this;
  }

  getUserData() {
    var loggedInUserInformation =
        GetStorage().read(CoreAppConstants.loggedInUser);
    print(loggedInUserInformation);
    // if (loggedInUserInformation != null) {
    //   loggedInUser = UserInformationModel.fromJson(loggedInUserInformation);
    //   return loggedInUser;
    // }
    return loggedInUserInformation;
  }

  // storeLocationPermissionName(PermissionStatus value) {
  //   locationPermissionName = value;
  //   GetStorage()
  //       .write(CoreAppConstants.locationPermissionName, (value.toString()));
  // }

  storeLocationPermissonGranted(value) {
    isLocationPermissonGranted = value;
    GetStorage().write(CoreAppConstants.isLocationPermissonGranted, value);
  }

  getLocationPermissionName() {
    var permission = GetStorage().read(CoreAppConstants.locationPermissionName);
    if (permission != null) {
      return (permission);
    } else {
      return permission;
    }
  }

  getLocationPermissonGranted() {
    return GetStorage().read(CoreAppConstants.isLocationPermissonGranted);
  }

  setForceStorageCheck(value) {
    GetStorage().write(CoreAppConstants.forceUpdateCheck, value);
  }

  getForceStorageCheck() {
    return GetStorage().read(CoreAppConstants.forceUpdateCheck);
  }

  resetStorage() {
    GetStorage().remove(CoreAppConstants.loggedInUser);
  }

  getUserName() {
    String loggedInUser;
    var loggedInUserInformation =
        GetStorage().read(CoreAppConstants.userCredentails);
    if (loggedInUserInformation != null) {
      loggedInUser = loggedInUserInformation;
      return loggedInUser;
    }
    return null;
  }

  storeUserName(userName) {
    GetStorage().write(CoreAppConstants.userCredentails, userName);
  }

  resetUserName() {
    GetStorage().remove(CoreAppConstants.userCredentails);
  }

  void storeMembershipDetails(dynamic data) {
    GetStorage().write(CoreAppConstants.membershipDetails, data);
  }

  fetchMembershipDetails() {
    return GetStorage().read(CoreAppConstants.membershipDetails);
  }

  saveCreditCardInfo(data) {
    GetStorage().write(CoreAppConstants.creditCardInfo, data);
  }

  deleteCreditCardInfo() {
    GetStorage().remove(CoreAppConstants.creditCardInfo);
  }
}
