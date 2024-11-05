import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_bottom_sheet.dart';
import 'package:customer_app/core/components/common_button.dart';
import 'package:customer_app/core/flavors/app_flavor.dart';
import 'package:customer_app/pages/splash_screen/controllers/splash_screen_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  var splashController = Get.find<SplashScreenController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: splashController.isFromAccountTab.value ? 0 : 2),
      () {
        CommonBottomSheet.showBottomSheet(
            widgetBody: Container(
          padding:
              const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          height: Get.mediaQuery.size.height * 0.18,
          child: ListView(
            children: [
              CommonButton(
                // buttonColor: AppColors.primaryColor,
                onTap: () => Get.toNamed(Routes.LOGIN),
                isEnabled: true,
                text: CoreAppConstants.loginSignupLbl,
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  print(splashController.appStorage
                      .getLocationPermissonGranted());
                  if (splashController.appStorage
                          .getLocationPermissonGranted() !=
                      null) {
                    Get.toNamed(Routes.HOME, arguments: {'guest': true});
                  } else {
                    Get.toNamed(Routes.MAIN_SCREEN, arguments: {'guest': true});
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Text(CoreAppConstants.continueGuestLbl,
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Get.theme.colorScheme.primary))),
              ),
            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  AppFlavor.assetPath + CoreAppConstants.splashImage),
              fit: BoxFit.cover),
        ),
        child: Container(),
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
