import 'package:customer_app/app.dart';
import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:get/get.dart';

void main() async {
  // Inject our own configurations
  // LW Customer

  // EnvConfig envConfig = EnvConfig(
  //     appName: "LW Customer QA",
  //     baseUrl: "", //TODO: Enter base Url
  //     shouldCollectCrashLog: true,
  //     assetsImagePath: 'assets/lwcustomer/appicons/');

  // BuildConfig.instantiate(
  //   envType: Environment.STAGING,
  //   envConfig: envConfig,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppStorage().init());
  runApp(const MyApp(appFlavor: Flavor.other));
}
