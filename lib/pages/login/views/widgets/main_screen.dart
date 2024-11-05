import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/login/controllers/login_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var loginController = Get.find<LoginController>();

  @override
  void initState() {
    CommonBottomSheet.showBottomSheet(
        widgetBody: Container(
      padding: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
      height: Get.mediaQuery.size.height * 0.2,
      child: ListView(
        children: [
          CommonButton(
            // buttonColor: AppColors.primaryColor,
            onTap: () => loginController.enableLocationPermission(),
            isEnabled: true,
            text: CoreAppConstants.continueBtn,
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => Get.toNamed(Routes.HOME),
            child: Container(
                alignment: Alignment.center,
                child: Text(CoreAppConstants.skipLbl,
                    style: Get.textTheme.bodyLarge!
                        .copyWith(color: Get.theme.colorScheme.primary))),
          ),
        ],
      ),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    AppFlavor.assetPath + CoreAppConstants.backgroundImg),
                fit: BoxFit.contain),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppFlavor.assetPath + CoreAppConstants.logo,
                    width: Get.mediaQuery.size.width - 200,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppFlavor.assetPath + CoreAppConstants.locationMainImg,
                        width: 150,
                        height: 150,
                      ),
                      Text(CoreAppConstants.shareLocationLbl,
                          style: Get.textTheme.headlineMedium!.copyWith(
                              color: Get.theme.colorScheme.secondary)),
                      Text(CoreAppConstants.shareLocationDetailLbl,
                          style: Get.textTheme.headlineSmall)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SplashScreenView extends GetView<SplashScreenController> {
//   const SplashScreenView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(AppConstants.splashImage), fit: BoxFit.cover),
//         ),
//         child: Container(),
//       ),
//     );
//   }
// }
