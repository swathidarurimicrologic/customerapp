import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  final Flavor appFlavor;
  const MyApp({super.key, required this.appFlavor});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final EnvConfig _envConfig = BuildConfig.instance.config;

  @override
  void initState() {
    super.initState();
    AppFlavor.appFlavor = widget.appFlavor;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: AppFlavor.title,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppFlavor.appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
