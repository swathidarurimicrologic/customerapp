import 'package:customer_app/app.dart';
import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/app_configuration/app_storage_container.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppStorage().init());
  runApp(const MyApp(appFlavor: Flavor.lwcustomer));
}
