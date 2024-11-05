import 'package:customer_app/core/app_configuration/app_required.dart';
import 'package:customer_app/core/components/common_app_bar.dart';
import 'package:customer_app/pages/home/controllers/home_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:get/get.dart';

class LegalWidget extends StatefulWidget {
  const LegalWidget({super.key});

  @override
  State<LegalWidget> createState() => _LegalWidgetState();
}

class _LegalWidgetState extends State<LegalWidget> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !homeController.hideAppBar.value
          ? Scaffold(
              appBar: CommonAppBar(
                  titleWidget: const Text(CoreAppConstants.legalLbl),
                  iconData: Icons.arrow_back_sharp,
                  onAppBarMenuPressed: () {
                    homeController.hideAppBar(true);

                    Get.back();
                  }),
              body: _bodyWidget())
          : Scaffold(body: _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: ListView(
          children: [
            Container(
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
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.PRIVACY_POLICY);
                },
                title: Text(
                  CoreAppConstants.privacyNoticeLbl,
                  style: Get.textTheme.titleMedium,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.disableColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.UNLIMITED_TERMS);
                },
                title: Text(CoreAppConstants.unlimitedTermsLbl,
                    style: Get.textTheme.titleMedium),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.disableColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                onTap: () => Get.toNamed(Routes.UNLIMITED_TERMS),
                title: Text(CoreAppConstants.termsOnlineSingleWashLbl,
                    style: Get.textTheme.titleMedium),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.disableColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                },
                title: Text(CoreAppConstants.termsOfServiceLbl,
                    style: Get.textTheme.titleMedium),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
