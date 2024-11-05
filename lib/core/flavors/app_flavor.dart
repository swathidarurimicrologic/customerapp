import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/environment/lwcustomer/app_configuration/app_theme.dart';
import 'package:customer_app/environment/other/app_configuration/app_theme.dart';

enum Flavor {
  lwcustomerdev,
  lwcustomerstaging,
  lwcustomer,
  otherdev,
  otherstaging,
  other
}

class AppFlavor {
  static late Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.lwcustomerdev:
        return 'LW Customer DEV';
      case Flavor.other:
        return 'Other';

      default:
        return 'Customer App';
    }
  }

  //get my enviroment
  // static bool get isLwCustomer => appFlavor == Flavor.lwcustomer;
  // static bool get isOther => appFlavor == Flavor.other;

  // get base url
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.lwcustomerdev:
        return 'https://api.flutter.flavor.com.br'; // TODO: Change to base url provided by backend
      case Flavor.lwcustomerstaging:
        return 'https://api.flutter.flavor.com.br';
      case Flavor.lwcustomer:
        return 'https://api.flutter.flavor.com.br';
      case Flavor.otherdev:
        return 'https://api.flutter.flavor-qa.com.br';
      case Flavor.otherstaging:
        return 'https://api.flutter.flavor-qa.com.br';
      case Flavor.other:
        return 'https://api.flutter.flavor-qa.com.br';

      default:
        return 'https://api.flutter.flavor-dev.com.br';
    }
  }

  static ThemeData get appTheme {
    switch (appFlavor) {
      case Flavor.lwcustomerdev ||
            Flavor.lwcustomerstaging ||
            Flavor.lwcustomer:
        return CustomerAppTheme.getAppTheme();
      default:
        return OtherAppTheme.getAppTheme();
    }
  }

  static String get defaultAssetPath {
    return 'assets/common/images/';
  }

  static String get assetPath {
    switch (appFlavor) {
      case Flavor.lwcustomer:
        return 'assets/lwcustomer/';
      case Flavor.other:
        return 'assets/other/';
      default:
        return 'assets/common/images/';
    }
  }
}
